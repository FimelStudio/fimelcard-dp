"""胡闹运动会：桌面招募、秘密阵容与按阶段发放的技能物品。

这里只适配输入，所有操作仍交给原事务规则引擎校验和提交。
"""
from pathlib import Path
import json
from build_magical_athlete_game import PACK, put

ROOT = PACK / 'data/magical_athlete/function'
CHARS = json.loads((PACK / 'tools/magical_athlete_characters.json').read_text(encoding='utf-8'))


def js(v):
    return json.dumps(v, ensure_ascii=False, separators=(',', ':'))


def extend(name, text):
    path = ROOT / (name + '.mcfunction')
    body = path.read_text(encoding='utf-8').split('# direct-v2')[0].rstrip()
    put(name, body + '\n# direct-v2\n' + text)


def notice(message, color='yellow'):
    return 'function magical_athlete:hud/notice ' + js({'text': {'text': message, 'color': color}})


def build():
    base = json.loads((PACK / 'tools/direct_interaction_templates/magical_athlete.json').read_text(encoding='utf-8'))
    for name, body in base.items():
        put(name, body)
    from build_table_direct_hud import build as hud
    hud('magical_athlete', 'ma', '胡闹运动会', 6)
    put('direct/load', [f'scoreboard objectives add ma_{n} dummy' for n in
        ('depoch', 'iepoch', 'dpage', 'expected', 'dice_expected', 'confirm', 'cepoch', 'dcode', 'dtype', 'did', 'dround', 'next', 'dclock')])
    extend('load', 'function magical_athlete:direct/load\nfunction magical_athlete:hud/load')
    extend('system/reload', 'execute as @a[tag=ma.audience] run scoreboard players set @s ma_depoch -1\nexecute as @a[tag=ma.audience] run function magical_athlete:direct/sync')
    extend('player/clear_state', 'function magical_athlete:hud/deactivate\nscoreboard players reset @s ma_depoch\nscoreboard players reset @s ma_iepoch\nscoreboard players set @s ma_dpage 0\nscoreboard players reset @s ma_expected\nscoreboard players reset @s ma_confirm')
    extend('input/context', 'execute if entity @s[nbt={Health:0.0f}] run tag @s remove ma.actor')
    # 不覆盖普通物品；开局要求9格为空，之后只回收本游戏的显示物。
    path = ROOT / 'game/start.mcfunction'
    body = path.read_text(encoding='utf-8')
    old = 'execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{magical_athlete:{tool:1b}}] run scoreboard players set #blocked ma_ctx 1'
    new = '\n'.join(old.replace('hotbar.8', f'hotbar.{i}') for i in range(9))
    body = body.replace(old, new).replace('请先腾空快捷栏最后一格。', '请先腾空快捷栏九格。').replace('开始四场积分赛！快捷栏最后一格按Q打开比赛菜单。', '开始四场积分赛！右键桌面招募；手持角色或技能选项按Q。')
    body=body.replace('function magical_athlete:engine/init','data remove entity @s data.ma_inventory\nfunction magical_athlete:engine/init')
    put('game/start', body)
    put('input/give', 'function magical_athlete:direct/sync')
    put('input/menu_tool', '$item replace entity @s hotbar.7 with minecraft:paper[minecraft:item_model="card:magical_athlete/dice",minecraft:custom_name={text:"投骰〔Q〕",color:"gold",italic:false},minecraft:custom_data={magical_athlete:{tool:1b,dice:1b,table:$(table)}}]')
    put('direct/dye_item', '# 已移除常驻比赛菜单。')
    put('direct/dye_drop', 'clear @s minecraft:purple_dye[minecraft:custom_data~{magical_athlete:{tool:1b}}]\nscoreboard players set @s ma_dye 0')
    put('direct/sync', '''
function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
execute if entity @s[nbt={Health:0.0f}] run return 0
execute unless score @s ma_depoch = @e[tag=ma.current,limit=1] ma_epoch run function magical_athlete:direct/rebuild
function magical_athlete:direct/dice_sync
''')
    put('direct/rebuild', '''
clear @s *[minecraft:custom_data~{magical_athlete:{tool:1b}}]
scoreboard players set @s ma_expected 1
scoreboard players set @s ma_dice_expected 1
scoreboard players operation @s ma_depoch = @e[tag=ma.current,limit=1] ma_epoch
execute unless score @s ma_cepoch = @e[tag=ma.current,limit=1] ma_epoch run scoreboard players set @s ma_confirm -999
execute unless score @s ma_iepoch = @e[tag=ma.current,limit=1] ma_epoch run scoreboard players set @s ma_dpage 0
scoreboard players operation @s ma_iepoch = @e[tag=ma.current,limit=1] ma_epoch
execute store result storage magical_athlete:direct table int 1 run scoreboard players get @s ma_table
execute store result storage magical_athlete:direct epoch int 1 run scoreboard players get @s ma_depoch
execute store result storage magical_athlete:ui side int 1 run scoreboard players get @s ma_side
function magical_athlete:ui/private with storage magical_athlete:ui
execute if entity @e[tag=ma.current,scores={ma_state=1},limit=1] if score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run function magical_athlete:direct/draft
execute if entity @e[tag=ma.current,scores={ma_state=2},limit=1] run function magical_athlete:direct/lineup
execute if entity @e[tag=ma.current,scores={ma_state=3,ma_anim=0},limit=1] if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run function magical_athlete:direct/choices
function magical_athlete:direct/roster
''')
    put('direct/dice_eligible','''
scoreboard players set #can_roll ma_ctx 0
execute unless entity @e[tag=ma.current,scores={ma_state=3,ma_anim=0},limit=1] run return 0
execute if entity @e[tag=ma.current,scores={ma_pending=0},limit=1] if score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run scoreboard players set #can_roll ma_ctx 1
execute if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending if data entity @e[tag=ma.current,limit=1] data.magical_athlete.pending{kind:"ready"} run scoreboard players set #can_roll ma_ctx 1
''')
    put('direct/dice_sync','''
function magical_athlete:direct/dice_eligible
scoreboard players operation @s ma_expected -= @s ma_dice_expected
scoreboard players operation @s ma_expected += #can_roll ma_ctx
scoreboard players operation @s ma_dice_expected = #can_roll ma_ctx
execute if score #can_roll ma_ctx matches 0 run return run clear @s *[minecraft:custom_data~{magical_athlete:{tool:1b,dice:1b}}]
execute store result storage magical_athlete:direct table int 1 run scoreboard players get @s ma_table
execute unless items entity @s hotbar.7 *[minecraft:custom_data~{magical_athlete:{dice:1b}}] run function magical_athlete:input/menu_tool with storage magical_athlete:direct
''')
    put('direct/draft', 'data modify storage magical_athlete:direct options set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pool\ndata modify storage magical_athlete:direct kind set value "draft"\nfunction magical_athlete:direct/page')
    put('direct/lineup', '''
execute store result score #lineup_count ma_ctx run data get storage magical_athlete:ui hand.selected
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} if score #lineup_count ma_ctx matches 2.. run return 0
execute unless data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} if score #lineup_count ma_ctx matches 1.. run return 0
data modify storage magical_athlete:direct options set from storage magical_athlete:ui hand.hand
data modify storage magical_athlete:direct kind set value "lineup"
function magical_athlete:direct/page
''')
    put('direct/special_tool', '$item replace entity @s hotbar.6 with minecraft:paper[minecraft:item_model="minecraft:book",minecraft:custom_name={text:"查看全部候选能力〔Q〕",color:"aqua",italic:false},minecraft:custom_data={magical_athlete:{tool:1b,choice:1b,code:9997,epoch:$(epoch),table:$(table)}}]')
    # 六个选项一页，翻页和取消固定格位；两人八角色也不会覆盖骰子。
    put('direct/page', '''
clear @s *[minecraft:custom_data~{magical_athlete:{choice:1b}}]
data modify storage magical_athlete:direct index set value 0
''' + '\n'.join(f'function magical_athlete:direct/page_slot {{slot:{i}}}' for i in range(6)) + '''
execute store result score #count ma_ctx run data get storage magical_athlete:direct options
scoreboard players operation #page_count ma_ctx = #count ma_ctx
scoreboard players operation #page_count ma_ctx -= @s ma_dpage
execute if score #page_count ma_ctx matches 7.. run scoreboard players set #page_count ma_ctx 6
scoreboard players operation @s ma_expected = #page_count ma_ctx
scoreboard players add @s ma_expected 2
execute if score #count ma_ctx matches 7.. run scoreboard players add @s ma_expected 1
execute if score #count ma_ctx matches 7.. run function magical_athlete:direct/page_tool with storage magical_athlete:direct
function magical_athlete:direct/cancel_tool with storage magical_athlete:direct
''')
    put('direct/page_slot', '''
$scoreboard players set #option_index ma_ctx $(slot)
scoreboard players operation #option_index ma_ctx += @s ma_dpage
execute store result storage magical_athlete:direct index int 1 run scoreboard players get #option_index ma_ctx
$data modify storage magical_athlete:direct slot set value $(slot)
function magical_athlete:direct/page_read with storage magical_athlete:direct
''')
    put('direct/page_read', '''
$execute unless data storage magical_athlete:direct options[$(index)] run return 0
$data modify storage magical_athlete:direct target set from storage magical_athlete:direct options[$(index)]
execute if data storage magical_athlete:direct {kind:"draft"} run function magical_athlete:direct/character with storage magical_athlete:direct
execute if data storage magical_athlete:direct {kind:"lineup"} run function magical_athlete:direct/character with storage magical_athlete:direct
execute if data storage magical_athlete:direct {kind:"pending"} run function magical_athlete:direct/option with storage magical_athlete:direct
''')
    put('direct/character', '''
$data modify storage magical_athlete:direct card set from storage magical_athlete:characters chars[$(target)]
$data modify storage magical_athlete:direct card.slot set value $(slot)
$scoreboard players set #card_code ma_ctx $(target)
execute if data storage magical_athlete:direct {kind:"draft"} run scoreboard players add #card_code ma_ctx 100
execute if data storage magical_athlete:direct {kind:"lineup"} run scoreboard players add #card_code ma_ctx 200
execute store result storage magical_athlete:direct card.code int 1 run scoreboard players get #card_code ma_ctx
data modify storage magical_athlete:direct card.table set from storage magical_athlete:direct table
data modify storage magical_athlete:direct card.epoch set from storage magical_athlete:direct epoch
function magical_athlete:direct/character_item with storage magical_athlete:direct card
''')
    put('direct/character_item', '$item replace entity @s hotbar.$(slot) with minecraft:paper[minecraft:item_model="card:magical_athlete/hand/$(slug)",minecraft:custom_name={text:"$(name)：$(ability)",color:"aqua",italic:false},minecraft:lore=[{text:"按Q选中，再按Q确认；秘密阵容全员提交后揭晓",color:"gray",italic:false}],minecraft:custom_data={magical_athlete:{tool:1b,choice:1b,code:$(code),epoch:$(epoch),table:$(table)}}]')
    put('direct/page_tool', '$item replace entity @s hotbar.6 with minecraft:paper[minecraft:item_model="minecraft:arrow",minecraft:custom_name={text:"下一页〔Q〕",color:"yellow",italic:false},minecraft:custom_data={magical_athlete:{tool:1b,choice:1b,code:9999,epoch:$(epoch),table:$(table)}}]')
    put('direct/cancel_tool', '$item replace entity @s hotbar.8 with minecraft:paper[minecraft:item_model="minecraft:barrier",minecraft:custom_name={text:"取消选中〔Q〕",color:"red",italic:false},minecraft:custom_data={magical_athlete:{tool:1b,choice:1b,code:9998,epoch:$(epoch),table:$(table)}}]')
    put('direct/choices', '''
data modify storage magical_athlete:ui pending set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pending
data modify storage magical_athlete:direct options set from storage magical_athlete:ui pending.options
data modify storage magical_athlete:direct kind set value "pending"
function magical_athlete:direct/page
execute if data storage magical_athlete:ui pending{kind:"twin"} run function magical_athlete:direct/special_tool with storage magical_athlete:direct
''')
    put('direct/option', '''
$scoreboard players set #option ma_ctx $(target)
$data modify storage magical_athlete:ui option set value {target:$(target),slot:$(slot),table:$(table),epoch:$(epoch)}
data modify storage magical_athlete:ui option.kind set from storage magical_athlete:ui pending.kind
scoreboard players operation #choice_code ma_ctx = #option ma_ctx
scoreboard players add #choice_code ma_ctx 2100
execute store result storage magical_athlete:ui option.code int 1 run scoreboard players get #choice_code ma_ctx
function magical_athlete:ui/option_label with storage magical_athlete:ui option
''')
    put('ui/choice_button', 'function magical_athlete:direct/choice_item with storage magical_athlete:ui option')
    put('direct/choice_item', '$item replace entity @s hotbar.$(slot) with minecraft:paper[minecraft:item_model="minecraft:lime_dye",minecraft:custom_name={text:"$(label)〔Q〕",color:"green",italic:false},minecraft:custom_data={magical_athlete:{tool:1b,choice:1b,code:$(code),epoch:$(epoch),table:$(table)}}]')
    put('direct/use_choice', '''
function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
$execute unless score @s ma_table matches $(table) run return 0
$execute unless score @e[tag=ma.current,limit=1] ma_epoch matches $(epoch) run return run function magical_athlete:direct/stale
execute store result storage magical_athlete:direct table int 1 run scoreboard players get @s ma_table
execute store result storage magical_athlete:direct epoch int 1 run scoreboard players get @s ma_depoch
$scoreboard players set #code ma_ctx $(code)
execute if score #code ma_ctx matches 100..135 unless score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run return run function magical_athlete:direct/wait
execute if score #code ma_ctx matches 9997 run return run function magical_athlete:direct/special
execute if score #code ma_ctx matches 9998 run return run function magical_athlete:direct/cancel
execute if score #code ma_ctx matches 9999 run return run function magical_athlete:direct/next_page
execute if score #code ma_ctx matches 2099..2135 run return run function magical_athlete:direct/q_submit
function magical_athlete:direct/confirm
''')
    put('direct/q_submit','execute if entity @e[tag=ma.current,scores={ma_anim=1..},limit=1] run return run function magical_athlete:direct/busy\nfunction magical_athlete:direct/submit')
    put('direct/next_page', '''
scoreboard players add @s ma_dpage 6
execute store result storage magical_athlete:ui side int 1 run scoreboard players get @s ma_side
function magical_athlete:ui/private with storage magical_athlete:ui
execute if entity @e[tag=ma.current,scores={ma_state=1},limit=1] run data modify storage magical_athlete:direct options set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pool
execute if entity @e[tag=ma.current,scores={ma_state=2},limit=1] run data modify storage magical_athlete:direct options set from storage magical_athlete:ui hand.hand
execute if entity @e[tag=ma.current,scores={ma_state=3},limit=1] run data modify storage magical_athlete:direct options set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pending.options
execute store result score #count ma_ctx run data get storage magical_athlete:direct options
execute if score @s ma_dpage >= #count ma_ctx run scoreboard players set @s ma_dpage 0
# 共享storage可能刚被另一桌更新；重新读取本人的阶段与候选列表。
execute if entity @e[tag=ma.current,scores={ma_state=1},limit=1] run return run function magical_athlete:direct/draft
execute if entity @e[tag=ma.current,scores={ma_state=2},limit=1] run return run function magical_athlete:direct/lineup
function magical_athlete:direct/choices
''')
    put('direct/confirm', '''
execute if entity @e[tag=ma.current,scores={ma_anim=1..},limit=1] run return run function magical_athlete:direct/busy
execute if score @s ma_confirm = #code ma_ctx if score @s ma_cepoch = @e[tag=ma.current,limit=1] ma_epoch run return run function magical_athlete:direct/submit
scoreboard players operation @s ma_confirm = #code ma_ctx
scoreboard players operation @s ma_cepoch = @e[tag=ma.current,limit=1] ma_epoch
''' + notice('已选中：再次右键或按Q确认，左键取消。', 'aqua') + '''
playsound minecraft:ui.button.click master @s ~ ~ ~ 0.5 1.3
function magical_athlete:direct/highlight
function magical_athlete:direct/confirm_details
''')
    put('direct/confirm_details','''
scoreboard players operation #detail ma_ctx = @s ma_confirm
execute if score #detail ma_ctx matches 100..135 run scoreboard players remove #detail ma_ctx 100
execute if score #detail ma_ctx matches 200..235 run scoreboard players remove #detail ma_ctx 200
execute unless score #detail ma_ctx matches 0..35 run return 0
execute store result storage magical_athlete:direct id int 1 run scoreboard players get #detail ma_ctx
function magical_athlete:direct/card_details with storage magical_athlete:direct
''')
    put('direct/card_details','$data modify storage magical_athlete:direct detail set from storage magical_athlete:characters chars[$(id)]\nfunction magical_athlete:direct/card_notice with storage magical_athlete:direct detail')
    put('direct/card_notice','$function magical_athlete:hud/notice {text:{text:"$(name)：$(ability) · 再次确认，取消可重选",color:"aqua"}}')
    put('direct/submit', '''
scoreboard players operation @s ma_seen = @e[tag=ma.current,limit=1] ma_epoch
scoreboard players set @s ma_confirm -999
scoreboard players operation @s ma_dcode = #code ma_ctx
execute if score @s ma_dcode matches 200..235 run function magical_athlete:direct/lineup_order
function magical_athlete:ui/dispatch
execute if score #ok ma_ctx matches 1 if score @s ma_dcode matches 200..235 run function magical_athlete:direct/lineup_receipt
scoreboard players set @s ma_depoch -1
function magical_athlete:direct/sync
''')
    put('direct/lineup_order','execute store result storage magical_athlete:ui side int 1 run scoreboard players get @s ma_side\nfunction magical_athlete:ui/private with storage magical_athlete:ui\nexecute store result score @s ma_dround run data get storage magical_athlete:ui hand.selected\nscoreboard players add @s ma_dround 1')
    put('direct/lineup_receipt','scoreboard players operation #receipt_id ma_ctx = @s ma_dcode\nscoreboard players remove #receipt_id ma_ctx 200\nexecute store result storage magical_athlete:direct id int 1 run scoreboard players get #receipt_id ma_ctx\nfunction magical_athlete:direct/receipt_card with storage magical_athlete:direct')
    put('direct/receipt_card','$data modify storage magical_athlete:direct receipt set from storage magical_athlete:characters chars[$(id)]\nexecute store result storage magical_athlete:direct receipt.order int 1 run scoreboard players get @s ma_dround\nfunction magical_athlete:direct/receipt_message with storage magical_athlete:direct receipt')
    put('direct/receipt_message','$tellraw @s {text:"已秘密提交第$(order)位：$(name)。全员选好后揭晓。",color:"aqua"}')
    put('direct/cancel', 'scoreboard players set @s ma_confirm -999\n' + notice('已取消选中；必选技能仍需选择一个合法选项。') + '\nfunction magical_athlete:direct/highlight')
    put('direct/stale', 'scoreboard players set @s ma_depoch -1\n' + notice('局面已变化，请重新选择。') + '\nfunction magical_athlete:direct/sync')
    put('direct/busy', notice('正在结算移动或技能，请稍候。'))
    put('direct/roll_pending', '''
data modify storage magical_athlete:ui pending set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pending
execute unless data storage magical_athlete:ui pending{kind:"ready"} run return run function magical_athlete:direct/pending_note
execute store result score #code ma_ctx run data get storage magical_athlete:ui pending.options[0]
scoreboard players add #code ma_ctx 2100
function magical_athlete:direct/submit
''')
    put('direct/pending_note', notice('请先决定当前技能：手持物品选项按Q，或瞄准目标右键。'))
    put('input/roll', '''
function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
execute unless entity @e[tag=ma.current,scores={ma_state=3,ma_anim=0},limit=1] run return run function magical_athlete:direct/busy
execute if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run return run function magical_athlete:direct/roll_pending
execute if entity @e[tag=ma.current,scores={ma_pending=1..},limit=1] run return run function magical_athlete:direct/pending_note
execute unless score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run return run function magical_athlete:direct/wait
scoreboard players set #roll_pawn ma_ctx -1
''' + '\n'.join(f'execute if score #roll_pawn ma_ctx matches -1 run function magical_athlete:input/roll_pawn {{index:{i}}}' for i in range(6)) + '''
execute store result score #forced_roll ma_ctx run data get entity @e[tag=ma.current,limit=1] data.magical_athlete.forced
execute if score #forced_roll ma_ctx matches 0..5 run scoreboard players operation #roll_pawn ma_ctx = #forced_roll ma_ctx
execute unless score #roll_pawn ma_ctx matches 0..5 run return run function magical_athlete:direct/wait
scoreboard players operation #code ma_ctx = #roll_pawn ma_ctx
scoreboard players add #code ma_ctx 300
function magical_athlete:direct/submit
''')
    put('input/roll_pawn', '''
$data modify storage magical_athlete:direct probe set from entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(index)]
execute unless data storage magical_athlete:direct probe{status:0,done:0} run return 0
$execute store result score #roll_owner ma_ctx run data get entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(index)].owner
$execute if score #roll_owner ma_ctx = @s ma_side run scoreboard players set #roll_pawn ma_ctx $(index)
''')
    put('direct/wait', notice('当前不轮到你行动，请等待提示的玩家。'))
    put('input/use_drop', '''
$execute unless score @a[tag=ma.dropper,limit=1] ma_table matches $(table) run return 0
execute as @a[tag=ma.dropper,limit=1] run function magical_athlete:input/roll
execute as @a[tag=ma.dropper,limit=1] run scoreboard players set @s ma_depoch -1
execute as @a[tag=ma.dropper,limit=1] run function magical_athlete:direct/sync
''')
    extend('input/check_drop', 'execute as @a[tag=ma.dropper,limit=1] run scoreboard players set @s ma_depoch -1\nexecute as @a[tag=ma.dropper,limit=1] run function magical_athlete:direct/sync')
    path=ROOT/'input/check_drop.mcfunction';body=path.read_text(encoding='utf-8')
    body=body.replace('execute unless data storage magical_athlete:input drop{choice:1b} run function', 'execute unless data storage magical_athlete:input drop{choice:1b} unless data storage magical_athlete:input drop{roster:1b} run function')
    body=body.replace('kill @s','execute if data storage magical_athlete:input drop{roster:1b} as @a[tag=ma.dropper,limit=1] run function magical_athlete:direct/roster_use with storage magical_athlete:input drop\nkill @s')
    put('input/check_drop',body)
    # 尽管物品可移动，只有带本人桌号和当前epoch的服务端选项才能请求规则动作。
    extend('tick', '''execute as @a[tag=ma.player] at @s run function magical_athlete:direct/player_tick
execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run function magical_athlete:direct/recover_drop''')
    put('direct/recover_drop', 'execute on origin run scoreboard players set @s ma_depoch -1\nkill @s')
    put('direct/player_tick', '''
execute if entity @s[nbt={Health:0.0f}] run return 0
function magical_athlete:direct/sync
execute unless entity @s[tag=ma.actor] run return 0
function magical_athlete:hud/tick
execute store result score #mirrored ma_ctx run clear @s *[minecraft:custom_data~{magical_athlete:{tool:1b}}] 0
execute unless score #mirrored ma_ctx = @s ma_expected run scoreboard players set @s ma_depoch -1
execute if score @s ma_dice_expected matches 1 unless items entity @s hotbar.7 *[minecraft:custom_data~{magical_athlete:{dice:1b}}] run scoreboard players set @s ma_depoch -1
''')
    put('ui/open', '''
function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
scoreboard players set @s ma_depoch -1
function magical_athlete:direct/sync
execute if score @s ma_side = @e[tag=ma.current,limit=1] ma_pending if data entity @e[tag=ma.current,limit=1] data.magical_athlete.pending{kind:"twin"} run return run function magical_athlete:direct/special
''' + notice('右键桌面选择；角色与技能选项手持按Q，骰子按Q投骰。'))
    put('direct/special', 'function magical_athlete:ui/begin\nfunction magical_athlete:ui/pending\nfunction magical_athlete:ui/show with storage magical_athlete:ui')
    # 特殊能力窗口的按钮不经物品栏重定向。
    path = ROOT / 'ui/option_label.mcfunction'
    body = path.read_text(encoding='utf-8').replace('function magical_athlete:ui/choice_button with storage magical_athlete:ui option', 'function magical_athlete:direct/option_finish with storage magical_athlete:ui option')
    put('ui/option_label', body)
    put('direct/option_finish', '''
execute if entity @s[tag=ma.special] run return run function magical_athlete:direct/dialog_button with storage magical_athlete:ui option
function magical_athlete:direct/choice_item with storage magical_athlete:ui option
''')
    put('direct/dialog_button', '$function magical_athlete:ui/button {code:$(code),label:"$(label)",color:"green"}')
    put('direct/special', 'tag @s add ma.special\nfunction magical_athlete:ui/begin\nfunction magical_athlete:ui/pending\nfunction magical_athlete:ui/show with storage magical_athlete:ui\ntag @s remove ma.special')
    put('ui/refresh', '''
function magical_athlete:system/context
execute as @a[tag=ma.audience] run scoreboard players set @s ma_depoch -1
execute as @a[tag=ma.audience] run function magical_athlete:direct/sync
function magical_athlete:game/hud
''')
    put('game/illegal', 'execute as @a[tag=ma.actor] run function magical_athlete:direct/error\nfunction magical_athlete:sound/illegal')
    errors = {1:'对局状态不可用。',2:'你不在本局名单中。',3:'局面已变化，请重新选择。',4:'当前不轮到你，或目标不在可选范围。',5:'本场已结束。',6:'这名选手当前不能行动，或行动顺序不符。',7:'目标不在当前技能的可选范围。',8:'这名角色当前不可选。',9:'当前阶段不能执行这项操作。',10:'操作数据已过期，请重新选择。',13:'有玩家离线，整桌已暂停。'}
    put('direct/error', [notice('操作未完成：请检查当前阶段、行动顺序和可选目标。', 'red')] + [f'execute if score #error ma_ctx matches {n} run '+notice(t,'red') for n,t in errors.items()])
    scene()
    roster()
    for name, slot in [('input/menu_tool','7'),('direct/character_item','$(slot)'),('direct/choice_item','$(slot)'),('direct/page_tool','6'),('direct/cancel_tool','8'),('direct/special_tool','6')]:
        path=ROOT/(name+'.mcfunction');body=path.read_text(encoding='utf-8')
        line=f'execute if items entity @s hotbar.{slot} * unless items entity @s hotbar.{slot} *[minecraft:custom_data~{{magical_athlete:{{tool:1b}}}}] run return run function magical_athlete:direct/space_notice'
        put(name,('$' if '$(' in line else '')+line+'\n'+body)
    put('direct/space_notice','execute if score @s ma_htimer matches 1.. run return 0\n'+notice('请腾空快捷栏操作位置，并为队伍卡留出主物品栏空间；普通物品不会被覆盖。'))
    # 特殊界面只在本人主动操作特殊入口时显示；普通流程绝不弹窗。
    assets()
    from build_table_feedback import magical_athlete as feedback
    feedback()
    from build_magical_athlete_scene import build as scene_updates
    scene_updates()
    from build_direct_support import finish
    finish('magical_athlete')


def scene():
    extend('visual/refresh', 'function magical_athlete:direct/board_refresh')
    # 招募会刷新桌面；能力的选中效果只影响表现。
    extend('game/after_action', 'execute unless score @s ma_anim matches 1.. run function magical_athlete:direct/board_refresh')
    extend('visual/clear', 'execute as @e[tag=ma.direct] if score @s ct_id = #vis_table ma_ctx run kill @s')
    extend('game/tick', '''execute as @e[tag=ma.hit] if score @s ct_id = #table ma_ctx if data entity @s interaction run function magical_athlete:direct/click
execute as @e[tag=ma.hit] if score @s ct_id = #table ma_ctx if data entity @s attack run function magical_athlete:direct/left
function magical_athlete:direct/countdown''')
    put('direct/board_refresh', '''
scoreboard players operation #table ma_ctx = @s ct_id
execute as @e[tag=ma.direct] if score @s ct_id = #table ma_ctx run kill @s
function magical_athlete:visual/context
execute store result storage magical_athlete:direct table int 1 run scoreboard players get @s ct_id
execute store result storage magical_athlete:direct epoch int 1 run scoreboard players get @s ma_epoch
execute if score @s ma_state matches 1 run function magical_athlete:direct/pool_spawn
execute if score @s ma_state matches 3 run function magical_athlete:direct/racer_hits
''')
    pool=[]
    for i in range(12):
        pool += [f'execute if data entity @s data.magical_athlete.pool[{i}] run function magical_athlete:direct/pool_card {{index:{i},x:{(i%4-1.5)*.56},z:{(i//4-1)*.65}}}']
    put('direct/pool_spawn',pool)
    put('direct/pool_card', '''
$data modify storage magical_athlete:direct id set from entity @s data.magical_athlete.pool[$(index)]
$data modify storage magical_athlete:direct x set value $(x)
$data modify storage magical_athlete:direct z set value $(z)
data modify storage magical_athlete:direct type set value 1
function magical_athlete:direct/pool_data with storage magical_athlete:direct
''')
    put('direct/pool_data', '''
$data modify storage magical_athlete:direct card set from storage magical_athlete:characters chars[$(id)]
data modify storage magical_athlete:direct slug set from storage magical_athlete:direct card.slug
data modify storage magical_athlete:direct name set from storage magical_athlete:direct card.name
data modify storage magical_athlete:direct width set value 0.46
execute if score @s ma_orient matches 1 run function magical_athlete:direct/rotate_pool
$execute positioned ~$(x) ~1.055 ~$(z) summon minecraft:item_display run function magical_athlete:direct/pool_init with storage magical_athlete:direct
$execute positioned ~$(x) ~1.055 ~$(z) summon minecraft:interaction run function magical_athlete:direct/hit_init with storage magical_athlete:direct
$execute positioned ~$(x) ~1.42 ~$(z) summon minecraft:text_display run function magical_athlete:direct/pool_title with storage magical_athlete:direct
''')
    put('direct/pool_title','tag @s add ma.direct\n$scoreboard players set @s ct_id $(table)\n$data merge entity @s {billboard:"vertical",Rotation:[0f,0f],background:0,shadow:1b,text:{text:"$(name)",color:"aqua"},transformation:{translation:[0f,0f,0f],scale:[0.18f,0.18f,0.18f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f]}}')
    put('direct/rotate_pool','data modify storage magical_athlete:direct old_x set from storage magical_athlete:direct x\nexecute store result score #pool_z ma_ctx run data get storage magical_athlete:direct z 1000000\nexecute store result storage magical_athlete:direct x double -0.000001 run scoreboard players get #pool_z ma_ctx\ndata modify storage magical_athlete:direct z set from storage magical_athlete:direct old_x')
    put('direct/pool_init', '''
tag @s add ma.direct
tag @s add ma.pool
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ma_did $(id)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:magical_athlete/racer/$(slug)"}},item_display:"none",brightness:{block:15,sky:15},transformation:{scale:[0.26f,0.26f,0.26f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,1f,0f,0f]}}
''')
    put('direct/hit_init', '''
tag @s add ma.direct
tag @s add ma.hit
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ma_dtype $(type)
$scoreboard players set @s ma_did $(id)
$data merge entity @s {width:$(width)f,height:0.18f,response:1b,data:{hit:{table:$(table),epoch:$(epoch),type:$(type),id:$(id)}}}
execute if score @s ma_dtype matches 1 run data modify entity @s height set value 0.36f
execute if score @s ma_dtype matches 2 run data modify entity @s height set value 0.30f
''')
    put('direct/racer_hits', [f'function magical_athlete:direct/racer_hit {{index:{i}}}' for i in range(6)] + [f'execute if data entity @s data.magical_athlete.pending{{kind:"thirdwheel"}} run function magical_athlete:direct/cell_hit {{pos:{i}}}' for i in range(31)])
    put('direct/racer_hit', '''
$data modify storage magical_athlete:visual racer set from entity @s data.magical_athlete.racers[$(index)]
execute if data storage magical_athlete:visual racer{status:2} run return 0
$data modify storage magical_athlete:visual racer.index set value $(index)
function magical_athlete:visual/racer_data with storage magical_athlete:visual racer
data modify storage magical_athlete:direct x set from storage magical_athlete:visual pose.x
data modify storage magical_athlete:direct z set from storage magical_athlete:visual pose.z
data modify storage magical_athlete:direct width set from storage magical_athlete:visual pose.scale
$data modify storage magical_athlete:direct id set value $(index)
data modify storage magical_athlete:direct type set value 2
function magical_athlete:direct/hit_spawn with storage magical_athlete:direct
''')
    put('direct/cell_hit', '''
$data modify storage magical_athlete:direct pose set from storage magical_athlete:visual layout.pawns[0][$(pos)]
data modify storage magical_athlete:direct x set from storage magical_athlete:direct pose.x
data modify storage magical_athlete:direct z set from storage magical_athlete:direct pose.z
data modify storage magical_athlete:direct width set value 0.28
$data modify storage magical_athlete:direct id set value $(pos)
data modify storage magical_athlete:direct type set value 3
function magical_athlete:direct/hit_spawn with storage magical_athlete:direct
''')
    put('direct/hit_spawn', '$execute positioned ~$(x) ~1.08 ~$(z) summon minecraft:interaction run function magical_athlete:direct/hit_init with storage magical_athlete:direct')
    put('direct/click', 'data modify storage magical_athlete:direct hit set from entity @s data.hit\nexecute on target if entity @s[type=minecraft:player] run function magical_athlete:direct/use with storage magical_athlete:direct hit\ndata remove entity @s interaction')
    put('direct/left', 'execute on attacker if entity @s[type=minecraft:player] run function magical_athlete:direct/cancel\ndata remove entity @s attack')
    put('direct/use', '''
function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
$data modify storage magical_athlete:direct hit set value {table:$(table),epoch:$(epoch),type:$(type),id:$(id)}
$execute unless score @s ma_table matches $(table) run return 0
$execute unless score @e[tag=ma.current,limit=1] ma_epoch matches $(epoch) run return run function magical_athlete:direct/stale
$scoreboard players set #hit_type ma_ctx $(type)
$scoreboard players set #hit_id ma_ctx $(id)
execute if score #hit_type ma_ctx matches 1 unless score @s ma_side = @e[tag=ma.current,limit=1] ma_turn run return run function magical_athlete:direct/roster_info with storage magical_athlete:direct hit
execute if score #hit_type ma_ctx matches 1 run scoreboard players operation #code ma_ctx = #hit_id ma_ctx
execute if score #hit_type ma_ctx matches 1 run scoreboard players add #code ma_ctx 100
execute if score #hit_type ma_ctx matches 1 run return run function magical_athlete:direct/confirm
execute if score #hit_type ma_ctx matches 2 unless score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run return run function magical_athlete:direct/pawn_info with storage magical_athlete:direct hit
execute unless score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run return run function magical_athlete:direct/wait
data modify storage magical_athlete:direct pending set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pending
scoreboard players set #target_skill ma_ctx 0
'''+ '\n'.join(f'execute if data storage magical_athlete:direct pending{{kind:"{kind}"}} run scoreboard players set #target_skill ma_ctx 1' for kind in ('hypnotist','flip','duel','mastermind','copycat'))+'''
execute if score #hit_type ma_ctx matches 2 if data storage magical_athlete:direct pending{kind:"thirdwheel"} run return run function magical_athlete:direct/pawn_cell with storage magical_athlete:direct hit
execute if score #hit_type ma_ctx matches 2 unless score #target_skill ma_ctx matches 1 run return run function magical_athlete:direct/pawn_info with storage magical_athlete:direct hit
execute if score #hit_type ma_ctx matches 3 unless data storage magical_athlete:direct pending{kind:"thirdwheel"} run return 0
$execute unless data storage magical_athlete:direct pending{options:[$(id)]} run return run function magical_athlete:direct/target_error
scoreboard players operation #code ma_ctx = #hit_id ma_ctx
scoreboard players add #code ma_ctx 2100
function magical_athlete:direct/confirm
''')
    put('direct/pawn_info','''
$data modify storage magical_athlete:direct pawn set from entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(id)]
data modify storage magical_athlete:direct id set from storage magical_athlete:direct pawn.char
execute store result score #read_power ma_ctx run data get storage magical_athlete:direct pawn.power
execute if score #read_power ma_ctx matches 0..35 run data modify storage magical_athlete:direct id set from storage magical_athlete:direct pawn.power
function magical_athlete:direct/roster_info with storage magical_athlete:direct
''')
    put('direct/pawn_cell','''
$data modify storage magical_athlete:direct cell set value {table:$(table),epoch:$(epoch),type:3,id:0}
$data modify storage magical_athlete:direct cell.id set from entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(id)].pos
function magical_athlete:direct/use with storage magical_athlete:direct cell
''')
    put('direct/target_error', notice('这个目标不在当前技能的可选范围。', 'red'))
    put('direct/highlight', '''
scoreboard players operation #table ma_ctx = @s ma_table
execute as @e[tag=ma.cell_preview] if score @s ct_id = #table ma_ctx run kill @s
execute as @e[tag=ma.pool] if score @s ct_id = #table ma_ctx run data merge entity @s {Glowing:0b}
execute as @e[tag=ma.racer] if score @s ct_id = #table ma_ctx run data merge entity @s {Glowing:0b}
scoreboard players operation #selected ma_ctx = @s ma_confirm
execute if score #selected ma_ctx matches 100..135 run scoreboard players remove #selected ma_ctx 100
execute as @e[tag=ma.pool] if score @s ct_id = #table ma_ctx if score @s ma_did = #selected ma_ctx run data merge entity @s {Glowing:1b,glow_color_override:5636095}
scoreboard players operation #selected ma_ctx = @s ma_confirm
scoreboard players remove #selected ma_ctx 2100
execute unless data entity @e[tag=ma.current,limit=1] data.magical_athlete.pending{kind:"thirdwheel"} as @e[tag=ma.racer] if score @s ct_id = #table ma_ctx if score @s ma_vid = #selected ma_ctx run data merge entity @s {Glowing:1b,glow_color_override:5636095}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.pending{kind:"thirdwheel"} if score #selected ma_ctx matches 0..30 as @e[tag=ma.current,limit=1] at @s run function magical_athlete:direct/cell_highlight
''')
    put('direct/cell_highlight','function magical_athlete:visual/context\nexecute store result storage magical_athlete:direct pos int 1 run scoreboard players get #selected ma_ctx\nfunction magical_athlete:direct/cell_highlight_pose with storage magical_athlete:direct')
    put('direct/cell_highlight_pose','$data modify storage magical_athlete:direct pose set from storage magical_athlete:visual layout.pawns[0][$(pos)]\nfunction magical_athlete:direct/cell_flag_spawn with storage magical_athlete:direct pose')
    put('direct/cell_flag_spawn','$execute positioned ~$(x) ~1.12 ~$(z) summon minecraft:item_display run function magical_athlete:direct/cell_flag_init')
    put('direct/cell_flag_init','tag @s add ma.direct\ntag @s add ma.cell_preview\nscoreboard players operation @s ct_id = #vis_table ma_ctx\ndata merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:magical_athlete/prop/flag"}},item_display:"none",Glowing:1b,glow_color_override:16766720,brightness:{block:15,sky:15},transformation:{translation:[0f,0f,0f],scale:[0.16f,0.16f,0.16f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,1f,0f,0f]}}')
    put('direct/countdown', '''
execute unless score @s ma_state matches 4 run return run scoreboard players set @s ma_next 0
execute unless score @s ma_next matches 1.. run scoreboard players set @s ma_next 120
scoreboard players remove @s ma_next 1
execute unless score @s ma_next matches 0 run return 0
execute as @a[tag=ma.audience,limit=1] run function magical_athlete:direct/next_race
''')
    put('direct/next_race', 'function magical_athlete:input/context\nexecute unless entity @s[tag=ma.actor] run return 0\nscoreboard players set #code ma_ctx 5\nfunction magical_athlete:direct/submit')


def assets():
    rp = PACK.resolve().parents[3] / 'resourcepacks/fimelcard-rp'
    for name in ('mild','wild'):
        path=rp/f'assets/card/models/item/magical_athlete/board/{name}.json'
        obj=json.loads(path.read_text(encoding='utf-8'))
        for element in obj['elements']:
            if element.get('name')=='board':element['from'][1]=8;element['to'][1]=8.06
        path.write_text(json.dumps(obj,indent=2)+'\n',encoding='utf-8')
    from build_magical_athlete_assets import build_hand_models
    build_hand_models()
    p=rp/'.source/magical_athlete/direct-interaction.json'
    p.write_text(js({'secret_hand':'card:magical_athlete/hand/<slug>','front_contexts':['gui','firstperson_righthand','firstperson_lefthand'],'fallback':'card:item/magical_athlete/hand/back','hand_pose_source':'tools/build_magical_athlete_figures.py','model_base_y':8,'draft_feet_y':1.055,'race_feet_y':1.052,'source':'tools/build_magical_athlete_direct.py'})+'\n',encoding='utf-8')


def roster():
    # 仅保存展示用的招募历史，放在事务状态之外，规则结果仍由hand/selected决定。
    put('direct/roster','execute store result storage magical_athlete:direct side int 1 run scoreboard players get @s ma_side\nfunction magical_athlete:direct/roster_read with storage magical_athlete:direct')
    lines=['$execute unless data entity @e[tag=ma.current,limit=1] data.ma_inventory.p$(side) run data modify entity @e[tag=ma.current,limit=1] data.ma_inventory.p$(side) set value {team:[]}',
        '$data modify storage magical_athlete:ui hand set from entity @e[tag=ma.current,limit=1] data.magical_athlete.p$(side)']
    for c in CHARS:
        ident=c['id']
        for field in ('hand','selected'):
            lines += [f'$execute if data storage magical_athlete:ui hand{{{field}:[{ident}]}} unless data entity @e[tag=ma.current,limit=1] data.ma_inventory.p$(side){{team:[{ident}]}} run data modify entity @e[tag=ma.current,limit=1] data.ma_inventory.p$(side).team append value {ident}']
    lines += ['$data modify storage magical_athlete:direct team set from entity @e[tag=ma.current,limit=1] data.ma_inventory.p$(side).team']
    lines += [f'execute if data storage magical_athlete:direct team[{i}] run function magical_athlete:direct/roster_card {{index:{i}}}' for i in range(8)]
    put('direct/roster_read',lines)
    put('direct/roster_card','''
$data modify storage magical_athlete:direct id set from storage magical_athlete:direct team[$(index)]
function magical_athlete:direct/roster_data with storage magical_athlete:direct
''')
    put('direct/roster_data','''
$data modify storage magical_athlete:direct roster set from storage magical_athlete:characters chars[$(id)]
data modify storage magical_athlete:direct roster.state set value "已使用"
$execute if data storage magical_athlete:ui hand{hand:[$(id)]} run data modify storage magical_athlete:direct roster.state set value "未使用"
$execute if data storage magical_athlete:ui hand{selected:[$(id)]} run data modify storage magical_athlete:direct roster.state set value "本场已提交"
execute store result storage magical_athlete:direct roster.table int 1 run scoreboard players get @s ma_table
execute store result storage magical_athlete:direct roster.epoch int 1 run scoreboard players get @e[tag=ma.current,limit=1] ma_epoch
scoreboard players add @s ma_expected 1
scoreboard players set #roster_slot ma_ctx -1
'''+ '\n'.join(f'execute if score #roster_slot ma_ctx matches -1 unless items entity @s inventory.{i} * run scoreboard players set #roster_slot ma_ctx {i}' for i in range(27))+'''
execute if score #roster_slot ma_ctx matches -1 run return run function magical_athlete:direct/space_notice
execute store result storage magical_athlete:direct roster.slot int 1 run scoreboard players get #roster_slot ma_ctx
function magical_athlete:direct/roster_item with storage magical_athlete:direct roster
''')
    put('direct/roster_item','$item replace entity @s inventory.$(slot) with minecraft:paper[minecraft:item_model="card:magical_athlete/hand/$(slug)",minecraft:custom_name={text:"〔$(state)〕$(name)：$(ability)",color:"aqua",italic:false},minecraft:lore=[{text:"Q查看能力；秘密出场阶段未使用角色可按Q两次提交",color:"gray",italic:false}],minecraft:custom_data={magical_athlete:{tool:1b,roster:1b,char:$(id),table:$(table),epoch:$(epoch)}}]')
    put('direct/roster_use','''
function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
$execute unless score @s ma_table matches $(table) run return 0
$data modify storage magical_athlete:direct id set value $(char)
execute unless entity @e[tag=ma.current,scores={ma_state=2},limit=1] run return run function magical_athlete:direct/roster_info with storage magical_athlete:direct
execute store result storage magical_athlete:ui side int 1 run scoreboard players get @s ma_side
function magical_athlete:ui/private with storage magical_athlete:ui
$execute unless data storage magical_athlete:ui hand{hand:[$(char)]} run return run function magical_athlete:direct/used_roster
execute store result score #submitted ma_ctx run data get storage magical_athlete:ui hand.selected
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} if score #submitted ma_ctx matches 2.. run return run function magical_athlete:direct/lineup_wait
execute unless data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} if score #submitted ma_ctx matches 1.. run return run function magical_athlete:direct/lineup_wait
$scoreboard players set #code ma_ctx $(char)
scoreboard players add #code ma_ctx 200
function magical_athlete:direct/confirm
''')
    put('direct/used_roster',notice('这名角色已经使用或已提交，本场请选择另一名未使用角色。','red'))
    put('direct/lineup_wait',notice('本场阵容已经提交，等待其他玩家选择后统一揭晓。'))
    put('direct/roster_info','$data modify storage magical_athlete:direct detail set from storage magical_athlete:characters chars[$(id)]\nfunction magical_athlete:direct/roster_notice with storage magical_athlete:direct detail')
    put('direct/roster_notice','$function magical_athlete:hud/notice {text:{text:"$(name)：$(ability)",color:"aqua"}}')


if __name__ == '__main__':
    build()
