"""璀璨宝石桌面输入：选择、确认、预定、退珠；规则状态只由 engine/action 提交。"""
from build_splendor_game import put
import json

OBJECTIVES = {n: 'dummy' for n in ('sp_select_kind', 'sp_select_id', 'sp_select_epoch', 'sp_select_stage')}
NAMES = ['钻石', '蓝宝石', '祖母绿', '红宝石', '缟玛瑙', '黄金']


def notice(text):
    return 'function splendor:hud/notice ' + json.dumps({'text': {'text': text, 'color': 'yellow'}}, ensure_ascii=False, separators=(',', ':'))


def stop(condition, text):
    return 'execute ' + condition + ' run return run ' + notice(text)


def build():
    put('direct/load', [f'scoreboard objectives add {n} {kind}' for n, kind in OBJECTIVES.items()])
    reset = [f'scoreboard players set @s sp_pick{i} 0' for i in range(6)] + [
        'scoreboard players set @s sp_select_kind 0', 'scoreboard players set @s sp_select_id -1',
        'scoreboard players set @s sp_select_stage 0', 'scoreboard players set @s sp_panel 1',
        'scoreboard players operation @s sp_select_epoch = @e[tag=sp.current,limit=1] sp_epoch',
        'scoreboard players operation @s sp_seen = @e[tag=sp.current,limit=1] sp_epoch']
    put('direct/reset', reset)
    put('direct/clear_player', [f'scoreboard players reset @s {n}' for n in OBJECTIVES])
    put('direct/spawn', '''
data modify storage splendor:direct hit set value {table:0,epoch:0,kind:0,id:0}
execute store result storage splendor:direct hit.table int 1 run scoreboard players get @s sp_table
execute store result storage splendor:direct hit.epoch int 1 run scoreboard players get @e[tag=sp.current,limit=1] sp_epoch
execute store result storage splendor:direct hit.kind int 1 run scoreboard players get @s sp_vkind
execute store result storage splendor:direct hit.id int 1 run scoreboard players get @s sp_vid
data modify storage splendor:direct hit.width set from storage splendor:visual pose.scale
data modify storage splendor:direct hit.yaw set from storage splendor:visual pose.yaw
$execute positioned ~$(x) ~$(y) ~$(z) summon minecraft:interaction run function splendor:direct/hit_init with storage splendor:direct hit
execute if score @s sp_vkind matches 4 run function splendor:direct/gem_model
''')
    put('direct/hit_init', '''
tag @s add sp.visual
tag @s add sp.hit
$scoreboard players set @s sp_table $(table)
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s sp_vkind $(kind)
$scoreboard players set @s sp_vid $(id)
$data merge entity @s {width:$(width)f,height:0.14f,response:1b,Rotation:[$(yaw)f,0f],data:{hit:{table:$(table),epoch:$(epoch),kind:$(kind),id:$(id)}}}
''')
    items = ['diamond','lapis_lazuli','emerald','redstone','coal','gold_ingot']
    put('direct/gem_model', [f'execute if score @s sp_vid matches {i} run data merge entity @s {{item:{{id:"minecraft:{item}",count:1,components:{{"minecraft:item_model":"minecraft:{item}"}}}}}}' for i,item in enumerate(items)]+[
        'function splendor:direct/gem_pose with storage splendor:visual pose'])
    put('direct/gem_pose', '$data modify entity @s transformation.left_rotation set value [$(gqx)f,$(gqy)f,$(gqz)f,$(gqw)f]')
    for endpoint, relation, field, handler in [('click', 'target', 'interaction', 'use'), ('left', 'attacker', 'attack', 'cancel')]:
        put('direct/'+endpoint, f'''data modify storage splendor:direct hit set from entity @s data.hit
execute on {relation} if entity @s[type=minecraft:player] run function splendor:direct/{handler} with storage splendor:direct hit
data remove entity @s {field}
''')
    # 交互实体的 target/attacker 关系从 interaction/attack NBT 读取，处理后才清除。
    checks = '''function splendor:input/context
execute unless entity @s[tag=sp.actor] run return 0
$execute unless score @s sp_table matches $(table) run return run function splendor:direct/stale
$execute unless score @e[tag=sp.current,limit=1] sp_epoch matches $(epoch) run return run function splendor:direct/stale
'''
    checks += '\n'.join([stop('unless score @s sp_side = @e[tag=sp.current,limit=1] sp_turn', '尚未轮到你行动。'),
        stop('unless entity @e[tag=sp.current,scores={sp_anim=0},limit=1]', '正在结算上次行动，请稍候。'),
        stop('if entity @e[tag=sp.current,scores={sp_state=4},limit=1]', '游戏已经结束。')])+'\n'
    put('direct/use', checks + '''execute unless score @s sp_select_epoch = @e[tag=sp.current,limit=1] sp_epoch run function splendor:direct/reset
$scoreboard players set @s sp_target $(id)
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:4} run return run function splendor:direct/gem
'''+stop('if entity @e[tag=sp.current,scores={sp_state=2},limit=1]', '筹码超过十颗，请右键宝石选择退回，左键取消，恰好退到十颗。')+'''
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:3} run return run function splendor:direct/noble
'''+stop('if entity @e[tag=sp.current,scores={sp_state=3},limit=1]', '有多位贵族符合要求，请右键选择一位来访。')+'''
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:2} run return run function splendor:direct/card
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:5} run return run function splendor:direct/deck
''')
    put('direct/stale', ['function splendor:direct/reset', 'execute as @e[tag=sp.current,limit=1] at @s run function splendor:visual/selection', notice('局面已更新，请重新选择。')])
    put('direct/cancel', checks + '''execute unless score @s sp_select_epoch = @e[tag=sp.current,limit=1] sp_epoch run function splendor:direct/reset
$scoreboard players set @s sp_target $(id)
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:4} run return run function splendor:direct/gem_cancel
function splendor:direct/reset
execute as @e[tag=sp.current,limit=1] at @s run function splendor:visual/selection
'''+notice('已取消选择。'))
    put('direct/read_hand', '$data modify storage splendor:direct hand set from entity @e[tag=sp.current,limit=1] data.splendor.p$(side)')
    put('direct/hand', ['execute store result storage splendor:direct side int 1 run scoreboard players get @s sp_side', 'function splendor:direct/read_hand with storage splendor:direct'])
    put('direct/select', '''
function splendor:direct/reset
scoreboard players operation @s sp_select_id = @s sp_target
scoreboard players operation @s sp_select_kind = #select_kind sp_ctx
scoreboard players set @s sp_select_stage 1
execute as @e[tag=sp.current,limit=1] at @s run function splendor:visual/selection
''')
    # 发展卡第二次点击自动优先支付普通宝石，不足部分精确使用黄金。
    read_card = ['data modify storage splendor:direct card_id set value -1']
    read_card += [f'execute if score @s sp_target matches {s} run data modify storage splendor:direct card_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[{s}]' for s in range(12)]
    read_card += [f'execute if score @s sp_target matches {12+s} run data modify storage splendor:direct card_id set from storage splendor:direct hand.reserve[{s}]' for s in range(3)]
    read_card += ['scoreboard players set #card sp_ctx -1', 'execute store result score #card sp_ctx run data get storage splendor:direct card_id',
        'execute if score #card sp_ctx matches 0..89 run function splendor:direct/card_data with storage splendor:direct']
    put('direct/read_card', read_card)
    put('direct/card_data', '$data modify storage splendor:direct card set from storage splendor:cards cards[$(card_id)]')
    quote = ['data modify storage splendor:direct pay set value [0,0,0,0,0,0]', 'scoreboard players set #quote_gold sp_ctx 0']
    for i in range(5):
        quote += [f'execute store result score #quote_cost sp_ctx run data get storage splendor:direct card.cost[{i}]',
            f'execute store result score #quote_bonus sp_ctx run data get storage splendor:direct hand.bonus[{i}]',
            'scoreboard players operation #quote_cost sp_ctx -= #quote_bonus sp_ctx',
            'execute if score #quote_cost sp_ctx matches ..-1 run scoreboard players set #quote_cost sp_ctx 0',
            f'execute store result score #quote_token sp_ctx run data get storage splendor:direct hand.tokens[{i}]',
            'scoreboard players operation #quote_pay sp_ctx = #quote_cost sp_ctx',
            'scoreboard players operation #quote_pay sp_ctx < #quote_token sp_ctx',
            f'execute store result storage splendor:direct pay[{i}] int 1 run scoreboard players get #quote_pay sp_ctx',
            'scoreboard players operation #quote_cost sp_ctx -= #quote_pay sp_ctx', 'scoreboard players operation #quote_gold sp_ctx += #quote_cost sp_ctx']
    quote += ['execute store result storage splendor:direct pay[5] int 1 run scoreboard players get #quote_gold sp_ctx',
        'execute store result score #quote_owned sp_ctx run data get storage splendor:direct hand.tokens[5]']
    put('direct/quote', quote)
    build_card_interaction()
    put('direct/card_unaffordable', ['scoreboard players set @s sp_select_stage 2', notice('宝石不足，再次右键可预定。')])
    put('direct/reserve', ['scoreboard players set #action_code sp_ctx 2', 'function splendor:direct/submit'])
    put('direct/deck', '''
'''+stop('unless score @s sp_target matches 0..2', '请选择一个有效的牌堆。')+'''
function splendor:direct/hand
scoreboard players set #select_kind sp_ctx 5
execute unless score @s sp_select_kind matches 5 run return run function splendor:direct/deck_select
execute unless score @s sp_select_id = @s sp_target run return run function splendor:direct/deck_select
scoreboard players add @s sp_target 12
function splendor:direct/reserve
''')
    put('direct/deck_select', ['function splendor:direct/select', notice('已选中牌堆，再次右键盲预定一张，左键取消。')])
    reserved_checks = checks.replace('$(table)', '$(table)').replace('$(epoch)', '$(epoch)')+'$execute unless score @s sp_side matches $(owner) run return 0\n'
    put('direct/reserved_use', reserved_checks+stop('unless entity @e[tag=sp.current,scores={sp_state=1},limit=1]', '请先完成当前待办，再购买预定牌。')+'''
execute unless score @s sp_select_epoch = @e[tag=sp.current,limit=1] sp_epoch run function splendor:direct/reset
$scoreboard players set @s sp_target $(slot)
'''+stop('unless score @s sp_target matches 0..2', '这张预定牌的格位无效，请重新操作。')+'''
function splendor:direct/hand
scoreboard players set #select_kind sp_ctx 6
execute unless score @s sp_select_kind matches 6 run return run function splendor:direct/reserved_select
execute unless score @s sp_select_id = @s sp_target run return run function splendor:direct/reserved_select
scoreboard players add @s sp_target 12
function splendor:direct/read_card
'''+stop('unless score #card sp_ctx matches 0..89', '这张预定牌已经失效，请重新操作。')+'''
function splendor:direct/quote
'''+stop('if score #quote_gold sp_ctx > #quote_owned sp_ctx', '宝石不足，暂时无法购买这张预定牌。')+'''
scoreboard players set #action_code sp_ctx 3
function splendor:direct/submit
''')
    put('direct/reserved_select', ['function splendor:direct/select', notice('已选中自己的预定牌，再按一次 Q 购买。')])
    # 共用请求构造保证每次 action 都复核当前 side、epoch、phase 和库存。
    submit = ['data modify storage splendor:action input set value {actor:0,code:0,target:0,epoch:0,take:[0,0,0,0,0,0],pay:[0,0,0,0,0,0]}',
        'execute store result storage splendor:action input.actor int 1 run scoreboard players get @s sp_side',
        'execute store result storage splendor:action input.code int 1 run scoreboard players get #action_code sp_ctx',
        'execute store result storage splendor:action input.target int 1 run scoreboard players get @s sp_target',
        'data modify storage splendor:action input.epoch set from entity @e[tag=sp.current,limit=1] data.splendor.epoch']
    submit += [f'execute store result storage splendor:action input.take[{i}] int 1 run scoreboard players get @s sp_pick{i}' for i in range(6)]
    submit += ['execute if score #action_code sp_ctx matches 3 run data modify storage splendor:action input.pay set from storage splendor:direct pay',
        'execute as @e[tag=sp.current,limit=1] at @s run function splendor:game/action']
    put('direct/submit', submit)
    build_gems()
    put('direct/noble', [stop('unless entity @e[tag=sp.current,scores={sp_state=3},limit=1]', '贵族满足发展卡要求后自动来访；同时符合多位时，每回合选择一位。'),
        'scoreboard players set #action_code sp_ctx 5', 'function splendor:direct/submit'])
    put('direct/pending', [
        'execute if entity @e[tag=sp.current,scores={sp_state=2},limit=1] run '+notice('筹码超过十颗：右键宝石选择退回，左键取消，选够数量后自动退到十颗。'),
        'execute if entity @e[tag=sp.current,scores={sp_state=3},limit=1] run '+notice('多位贵族符合要求，请直接右键选择一位来访。')])
    errors = {1:'当前没有可用的璀璨宝石对局。',2:'你不是这局的有效参与者。',3:'局面已更新，请重新选择。',4:'尚未轮到你行动。',
        5:'请先完成退珠或贵族选择；每回合只进行一次主行动。',6:'拿珠须选三色，或在该色库存至少四颗时拿两颗；不能直接拿黄金。',
        7:'退珠数量不正确，请恰好退到十颗。',8:'卡牌或牌堆已经用完，请重新选择。',9:'这个操作当前不可用。',10:'操作数据无效，请重新选择。',
        11:'最多同时预定三张发展卡，请先购买已有预定牌。',12:'宝石不足，无法支付这张发展卡的费用。',13:'有玩家离线，游戏暂停中。',14:'这位贵族的发展卡要求尚未满足。'}
    put('direct/error', [f'execute if score #error sp_ctx matches {n} run return run '+notice(t) for n,t in errors.items()]+[notice('操作未完成，请重新选择。')])
    put('input/give', ['clear @s *[minecraft:custom_data~{splendor:{tool:1b}}]', 'function splendor:inventory/sync'])
    # 旧操作物、旧窗口和 trigger 不再产生规则输入。
    for endpoint in ('drop','use_drop','menu_tool','check_drop'):
        put('input/'+endpoint, 'return 0')
    for endpoint in ('buy','take','dye_item','dye_drop','dye_check','inventory','inventory_read','sync_gem','give_gem','count'):
        put('direct/'+endpoint, '# 旧操作层已停用，保留路径以拒绝过期调用。\nreturn 0')
    for endpoint in ('open','show','handle','dispatch'):
        put('ui/'+endpoint, ['scoreboard players reset @s sp_action','scoreboard players reset @s sp_nonce',notice('直接右键桌面的宝石、发展卡和牌堆；左键取消选择。')])


def build_gems():
    setup = ['execute unless score @s sp_select_kind matches 4 run function splendor:direct/reset',
        'scoreboard players set @s sp_select_kind 4', 'function splendor:direct/hand']
    read = []
    for i in range(6):
        read += [f'execute if score @s sp_target matches {i} store result score #gem_stock sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[{i}]',
            f'execute if score @s sp_target matches {i} store result score #gem_owned sp_ctx run data get storage splendor:direct hand.tokens[{i}]',
            f'execute if score @s sp_target matches {i} run scoreboard players operation #gem_pick sp_ctx = @s sp_pick{i}']
    put('direct/gem_read', ['scoreboard players set #gem_stock sp_ctx 0','scoreboard players set #gem_owned sp_ctx 0','scoreboard players set #gem_pick sp_ctx 0']+read)
    stats = ['scoreboard players set #pick_total sp_ctx 0','scoreboard players set #pick_available sp_ctx 0']
    for i in range(6):
        stats += [f'scoreboard players operation #pick_total sp_ctx += @s sp_pick{i}']
        if i < 5:
            stats += [f'execute store result score #stock sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.bank[{i}]',
                'execute if score #stock sp_ctx matches 1.. run scoreboard players add #pick_available sp_ctx 1']
    stats += ['execute if score #pick_available sp_ctx matches 4.. run scoreboard players set #pick_available sp_ctx 3']
    put('direct/gem_stats', stats)
    put('direct/gem', stop('unless score @s sp_target matches 0..5', '请选择一种有效宝石。')+'\n'+'\n'.join(setup)+'''
function splendor:direct/gem_read
execute if entity @e[tag=sp.current,scores={sp_state=2},limit=1] run return run function splendor:direct/gem_discard
'''+stop('unless entity @e[tag=sp.current,scores={sp_state=1},limit=1]', '请先选择符合条件的一位贵族。')+'\n'+
        stop('if score @s sp_target matches 5', '黄金只能通过预定发展卡获得。')+'\n'+
        stop('unless score #gem_stock sp_ctx matches 1..', '银行没有这种宝石了。')+'''
function splendor:direct/gem_stats
execute if score #gem_pick sp_ctx matches 1 run return run function splendor:direct/gem_double
'''+ '\n'.join(f'execute if score @s sp_target matches {i} run scoreboard players set @s sp_pick{i} 1' for i in range(5))+'''
function splendor:direct/gem_stats
execute if score #pick_available sp_ctx matches 2.. if score #pick_total sp_ctx = #pick_available sp_ctx run return run function splendor:direct/gem_commit
execute if score #pick_available sp_ctx matches 1 unless score #gem_stock sp_ctx matches 4.. run return run function splendor:direct/gem_commit
execute as @e[tag=sp.current,limit=1] at @s run function splendor:visual/selection
'''+notice('已选中宝石；继续右键其他颜色，或再次右键这一颗拿两颗同色；左键取消。'))
    put('direct/gem_double', [stop('unless score #pick_total sp_ctx matches 1', '拿两颗同色前，请先左键取消其他颜色。'),
        stop('unless score #gem_stock sp_ctx matches 4..', '拿两颗同色宝石前，该色银行库存至少需要四颗。')]+
        [f'execute if score @s sp_target matches {i} run scoreboard players set @s sp_pick{i} 2' for i in range(5)]+['function splendor:direct/gem_commit'])
    put('direct/gem_commit', ['scoreboard players set #action_code sp_ctx 1', 'function splendor:direct/submit'])
    put('direct/gem_cancel', '\n'.join(setup)+ '\n'+'\n'.join(f'execute if score @s sp_target matches {i} if score @s sp_pick{i} matches 1.. run scoreboard players remove @s sp_pick{i} 1' for i in range(6))+'''
execute as @e[tag=sp.current,limit=1] at @s run function splendor:visual/selection
'''+notice('已取消这颗宝石的选择。'))
    put('direct/gem_discard', [stop('unless score #gem_owned sp_ctx > #gem_pick sp_ctx', '你没有更多这种宝石可以退回。')]+
        [f'execute if score @s sp_target matches {i} run scoreboard players add @s sp_pick{i} 1' for i in range(6)]+[
        'scoreboard players set @s sp_panel 2', 'function splendor:direct/gem_stats',
        'execute store result score #discard_due sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.discard_due',
        'execute if score #pick_total sp_ctx = #discard_due sp_ctx run return run function splendor:direct/discard_commit',
        'execute as @e[tag=sp.current,limit=1] at @s run function splendor:visual/selection',notice('已选中待退宝石；继续右键选择，左键撤销，退到十颗时自动确认。')])
    put('direct/discard_commit', ['scoreboard players set #action_code sp_ctx 4','function splendor:direct/submit'])
    put('direct/gem_return', '''function splendor:input/context
execute unless entity @s[tag=sp.actor] run return 0
$execute unless score @s sp_table matches $(table) run return 0
$execute unless score @s sp_side matches $(owner) run return 0
'''+stop('unless score @s sp_side = @e[tag=sp.current,limit=1] sp_turn','尚未轮到你行动。')+'\n'+
        stop('unless entity @e[tag=sp.current,scores={sp_state=2,sp_anim=0},limit=1]','只有筹码超过十颗时才需要退珠。')+'''
execute unless score @s sp_select_epoch = @e[tag=sp.current,limit=1] sp_epoch run function splendor:direct/reset
$scoreboard players set @s sp_target $(color)
function splendor:direct/gem
''')


def build_card_interaction():
    put('direct/card',[
        stop('unless score @s sp_target matches 0..11','请选择市场中的发展卡。'),
        'function splendor:direct/hand','function splendor:direct/read_card',
        stop('unless score #card sp_ctx matches 0..89','这张发展卡已不在市场中。'),
        'scoreboard players set #select_kind sp_ctx 2',
        'execute if predicate {condition:"minecraft:entity_properties",entity:"this",predicate:{flags:{is_sneaking:true}}} run return run function splendor:direct/card_shift',
        'execute unless score @s sp_select_kind matches 2 run return run function splendor:direct/card_select',
        'execute unless score @s sp_select_id = @s sp_target run return run function splendor:direct/card_select',
        'execute if score @s sp_select_stage matches 3 run return run function splendor:direct/card_select',
        'execute if score @s sp_select_stage matches 2 run return run function splendor:direct/reserve',
        'function splendor:direct/quote',
        'execute if score #quote_gold sp_ctx > #quote_owned sp_ctx run return run function splendor:direct/card_unaffordable',
        'scoreboard players set #action_code sp_ctx 3','function splendor:direct/submit'])
    put('direct/card_shift',[
        'execute unless score @s sp_select_kind matches 2 run return run function splendor:direct/card_reserve_select',
        'execute unless score @s sp_select_id = @s sp_target run return run function splendor:direct/card_reserve_select',
        'execute unless score @s sp_select_stage matches 3 run return run function splendor:direct/card_reserve_select',
        'function splendor:direct/reserve'])
    put('direct/card_reserve_select',[
        'function splendor:direct/select','scoreboard players set @s sp_select_stage 3',
        notice('预约发展卡：再次潜行右键同一张牌确认；左键取消。')])
    put('direct/card_select',[
        'function splendor:direct/select',notice('已选中发展卡，再次右键购买；预约请潜行右键两次，左键取消。')])


if __name__ == '__main__':
    build()
