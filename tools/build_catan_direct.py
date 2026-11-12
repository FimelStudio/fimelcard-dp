"""卡坦岛直接操作：棋盘预览、私有物品镜像、弃牌与资源选择。

玩家间多项报价沿用单页编辑器。其余入口不打开日常操作菜单。
"""
import json
from pathlib import Path
from build_catan_game import put, PACK

ROOT=PACK/'data/catan/function'
RES=[('木材','wood','oak_log'),('砖块','brick','brick'),('羊毛','wool','white_wool'),('粮食','grain','wheat'),('矿石','ore','iron_ingot')]
DEV=[('骑士','knight','移动强盗并偷取资源'),('修路','road_building','免费建造至多两条道路'),('垄断','monopoly','收取所有对手的一种资源'),('丰收','plenty','从银行领取任意两张资源'),('胜利点','victory_point','秘密计入1胜利点')]


def js(v):return json.dumps(v,ensure_ascii=False,separators=(',',':'))


def notice(t,color='yellow'):
    return 'function catan:hud/notice '+js({'text':{'text':t,'color':color}})


def extend(name,text):
    body=(ROOT/(name+'.mcfunction')).read_text(encoding='utf-8').split('# direct-v2')[0].rstrip()
    put(name,body+'\n# direct-v2\n'+text)


def tool(slot,action,label,model='minecraft:paper'):
    return f'function catan:direct/control {{slot:{slot},action:{action},label:"{label}",model:"{model}"}}'


def build():
    for name,body in json.loads((PACK/'tools/direct_interaction_templates/catan.json').read_text(encoding='utf-8')).items():put(name,body)
    from build_table_direct_hud import build as hud
    hud('catan','ca','卡坦岛',4)
    put('direct/load',[f'scoreboard objectives add ca_{n} dummy' for n in ('depoch','confirm','cepoch','cmode','step','lastres','dphase','discepoch','dclock')])
    extend('load','function catan:direct/load\nfunction catan:hud/load')
    extend('player/clear_state','function catan:hud/deactivate\nscoreboard players reset @s ca_depoch\nscoreboard players reset @s ca_confirm')
    extend('system/reload','execute as @a[tag=ca.audience] run scoreboard players set @s ca_depoch -1')
    # 九个操作位从开局就预留，不会在开始后突然挤掉普通物品。
    path=ROOT/'game/start.mcfunction';body=path.read_text(encoding='utf-8')
    lines=body.splitlines()
    at=next(i for i,l in enumerate(lines) if 'hotbar.' in l and '#blocked' in l)
    lines=[l for l in lines if not ('hotbar.' in l and '#blocked' in l)]
    checks=[f'execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx if items entity @s hotbar.{i} * unless items entity @s hotbar.{i} *[minecraft:custom_data~{{catan:{{tool:1b}}}}] run scoreboard players set #blocked ca_ctx 1' for i in range(9)]
    lines[at:at]=checks
    body='\n'.join(lines).replace('请先腾空快捷栏第1、8、9格。','请先腾空快捷栏九格。').replace('第9格','物品栏').replace('紫色染料','操作物品')
    body='\n'.join('tellraw @a[tag=ca.audience] {text:"[卡坦岛] 建筑右键或Q两次确认；第8格投骰，第7格结束回合；资源、发展卡在物品栏按Q。",color:"aqua"}' if l.startswith('tellraw ') and '打开菜单' in l else l for l in body.splitlines())
    put('game/start',body)
    put('direct/dye_item','# 常驻更多操作菜单已移除。')
    put('direct/dye_drop','clear @s minecraft:purple_dye[minecraft:custom_data~{catan:{tool:1b}}]\nscoreboard players set @s ca_dye 0')
    # 每次动作重新取上下文，原射线拾取仍负责四／八座与旋转后的准确交点。
    extend('input/context','execute if score @s ct_paused matches 1 run tag @s remove ca.actor\nexecute if entity @e[tag=ca.current,scores={ct_paused=1},limit=1] run tag @s remove ca.actor\nexecute if entity @s[nbt={Health:0.0f}] run tag @s remove ca.actor')
    put('input/give','function catan:direct/sync')
    put('direct/sync','''
function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
execute store result storage catan:direct table int 1 run scoreboard players get @s ca_table
execute store result storage catan:direct side int 1 run scoreboard players get @s ca_side
execute store result storage catan:direct epoch int 1 run scoreboard players get @e[tag=ca.current,limit=1] ca_epoch
function catan:direct/read_hand with storage catan:direct
execute store result score #controls ca_ctx run clear @s *[minecraft:custom_data~{catan:{control:1b}}] 0
execute unless score #controls ca_ctx matches 9 run scoreboard players set @s ca_confirm -999
execute unless score #controls ca_ctx matches 9 run scoreboard players set @s ca_depoch -1
execute unless score @s ca_depoch = @e[tag=ca.current,limit=1] ca_epoch run function catan:direct/rebuild
function catan:direct/resources
function catan:direct/development
''')
    put('direct/rebuild','''
clear @s *[minecraft:custom_data~{catan:{control:1b}}]
execute unless score @s ca_cepoch = @e[tag=ca.current,limit=1] ca_epoch run scoreboard players set @s ca_confirm -999
scoreboard players set @s ca_edit 0
execute unless entity @e[tag=ca.current,scores={ca_state=5},limit=1] run scoreboard players set @s ca_dphase 0
scoreboard players operation @s ca_depoch = @e[tag=ca.current,limit=1] ca_epoch
execute if entity @e[tag=ca.current,scores={ca_state=5},limit=1] run function catan:direct/discard_begin
function catan:direct/controls
''')
    # 只清理本游戏操作物；固定格被普通物品占据时提示并跳过。
    put('direct/control','''
$execute if items entity @s hotbar.$(slot) * unless items entity @s hotbar.$(slot) *[minecraft:custom_data~{catan:{tool:1b}}] run return run function catan:direct/space
execute store result storage catan:direct table int 1 run scoreboard players get @s ca_table
execute store result storage catan:direct epoch int 1 run scoreboard players get @e[tag=ca.current,limit=1] ca_epoch
$data modify storage catan:direct control set value {slot:$(slot),action:$(action),label:"$(label)",model:"$(model)"}
data modify storage catan:direct control.table set from storage catan:direct table
data modify storage catan:direct control.epoch set from storage catan:direct epoch
function catan:direct/control_item with storage catan:direct control
''')
    put('direct/control_item','$item replace entity @s hotbar.$(slot) with minecraft:paper[minecraft:item_model="$(model)",minecraft:custom_name={text:"$(label)",color:"gold",italic:false},minecraft:custom_data={catan:{tool:1b,control:1b,action:$(action),table:$(table),epoch:$(epoch)}}]')
    put('direct/space',notice('请腾空操作物品需要的快捷栏位置，并留出资源牌空间。'))
    controls=['function catan:direct/buildings',tool(3,23,'购买发展卡〔Q两次〕','minecraft:book'),tool(4,210,'银行／港口兑换〔Q〕','minecraft:gold_ingot'),tool(5,200,'玩家交易／查看报价〔Q〕','minecraft:emerald'),tool(6,29,'结束回合〔Q两次〕','minecraft:lime_dye'),tool(7,10,'投骰〔Q〕','card:aeroplane_chess/dice'),tool(8,999,'取消选择〔Q〕','minecraft:barrier')]
    controls += ['execute if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run '+tool(6,31,'放弃剩余免费道路〔Q两次〕','minecraft:barrier'),
        'execute if score @s ca_edit matches 1 run function catan:direct/resource_controls',
        'execute if score @s ca_edit matches 3..5 run function catan:direct/resource_controls',
        'execute if entity @e[tag=ca.current,scores={ca_state=7},limit=1] if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run function catan:direct/victims']
    put('direct/controls',controls)
    # 让建筑物带上可回收标记与中文成本；资源不足沿用灰色模型。
    for name in ('build_item','build_gray'):
        path=ROOT/f'direct/{name}.mcfunction';body=path.read_text(encoding='utf-8')
        body=body.replace('tool:1b,action:1','tool:1b,control:1b,action:1')
        body=body.replace('tool:1b,build:$(mode)','tool:1b,control:1b,build:$(mode)')
        body=body.replace('title @s actionbar {text:"请腾空游戏操作物品需要的快捷栏位置",color:"yellow"}','function catan:direct/space')
        body=body.replace('建筑 · 手持后右键桌面建造','$(label) · 右键或Q选择／确认')
        put('direct/'+name,body)
    path=ROOT/'direct/buildings.mcfunction';body=path.read_text(encoding='utf-8')
    body=body.replace('data modify storage catan:direct kind set value "settlement"','data modify storage catan:direct label set value "村庄〔木材砖块羊毛粮食各1〕"\ndata modify storage catan:direct kind set value "settlement"')
    body=body.replace('data modify storage catan:direct kind set value "road"','data modify storage catan:direct label set value "道路〔木材1＋砖块1〕"\ndata modify storage catan:direct kind set value "road"')
    body=body.replace('data modify storage catan:direct kind set value "city"','data modify storage catan:direct label set value "城市〔粮食2＋矿石3〕"\ndata modify storage catan:direct kind set value "city"')
    body='\n'.join(l for l in body.splitlines() if 'direct/end_item' not in l)
    put('direct/buildings',body)
    put('input/aim','''
function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run return run function catan:direct/wait
execute if entity @e[tag=ca.current,scores={ca_anim=1..},limit=1] run return run function catan:direct/busy
execute if entity @e[tag=ca.current,scores={ca_vtimer=1..},limit=1] run return run function catan:direct/busy
execute unless entity @s[tag=ca.q_aim] run scoreboard players set @s ca_mode 0
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{catan:{build:2}}] run scoreboard players set @s ca_mode 2
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{catan:{build:3}}] run scoreboard players set @s ca_mode 3
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{catan:{build:4}}] run scoreboard players set @s ca_mode 4
execute if entity @e[tag=ca.current,scores={ca_state=1},limit=1] run scoreboard players set @s ca_mode 2
execute if entity @e[tag=ca.current,scores={ca_state=2},limit=1] run scoreboard players set @s ca_mode 3
execute if entity @e[tag=ca.current,scores={ca_state=6},limit=1] run scoreboard players set @s ca_mode 1
execute if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run scoreboard players set @s ca_mode 3
execute unless score @s ca_mode matches 1..4 run return run function catan:direct/aim_note
function catan:input/ray
execute unless score #ray_ok ca_ctx matches 1 run return run function catan:input/miss_note
scoreboard players operation @s ca_pick = #target ca_ctx
scoreboard players operation #code ca_ctx = #target ca_ctx
scoreboard players add #code ca_ctx 1000
execute if score @s ca_confirm = #code ca_ctx if score @s ca_cmode = @s ca_mode if score @s ca_cepoch = @e[tag=ca.current,limit=1] ca_epoch run return run function catan:direct/place
scoreboard players operation @s ca_confirm = #code ca_ctx
scoreboard players operation @s ca_cmode = @s ca_mode
scoreboard players operation @s ca_cepoch = @e[tag=ca.current,limit=1] ca_epoch
execute as @e[tag=ca.current,limit=1] at @s run function catan:input/preview
''' + notice('已预览位置：再次右键或按Q确认，左键取消。','aqua'))
    put('direct/place','scoreboard players operation @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch\nscoreboard players set @s ca_confirm -999\nfunction catan:ui/place')
    put('direct/cancel','scoreboard players set @s ca_confirm -999\nscoreboard players set @s ca_edit 0\nscoreboard players set @s ca_step 0\nscoreboard players set @s ca_dphase 0\nfunction catan:direct/discard_reset\nexecute if entity @e[tag=ca.current,scores={ca_state=5},limit=1] run function catan:direct/discard_begin\nexecute as @e[tag=ca.current,limit=1] run function catan:visual/clear_selection\nfunction catan:direct/controls\n'+notice('已取消当前选择。'))
    put('direct/aim_note',notice('手持村庄、道路或城市，瞄准交点或边；移动强盗时直接瞄准地块。'))
    put('direct/wait',notice('当前不轮到你执行这项操作。'))
    put('direct/busy',notice('正在结算或播放动画，请稍候。'))
    put('input/miss_note',notice('没有瞄准可识别的地块、交点或道路中段，请重新瞄准。','red'))
    # Q得到的物品元数据只作为请求，桌号／epoch／当前回合仍重新校验。
    put('input/use_drop','''
function catan:direct/drop_use with storage catan:input drop
''')
    put('direct/drop_use','''
execute as @a[tag=ca.dropper,limit=1] run function catan:direct/drop_actor with storage catan:input drop
''')
    put('direct/drop_actor','''
function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
$execute unless score @s ca_table matches $(table) run return 0
execute if data storage catan:input drop{resource:1b} run return run function catan:direct/resource with storage catan:input drop
execute if data storage catan:input drop{development:1b} run return run function catan:direct/dev_use with storage catan:input drop
$scoreboard players set #code ca_ctx $(action)
execute if score #code ca_ctx matches 1 run return run function catan:direct/q_aim with storage catan:input drop
$execute if data storage catan:input drop{control:1b} unless score @e[tag=ca.current,limit=1] ca_epoch matches $(epoch) run return run function catan:ui/stale
execute if score #code ca_ctx matches 999 run return run function catan:direct/cancel
execute if score #code ca_ctx matches 900..904 run return run function catan:direct/resource_code
execute if score #code ca_ctx matches 998 run return run function catan:direct/undo
execute if score #code ca_ctx matches 210 run return run function catan:direct/bank_begin
execute if score #code ca_ctx matches 200 run return run function catan:direct/trade_begin
execute if score #code ca_ctx matches 501..504 run return run function catan:direct/partner
execute if score #code ca_ctx matches 401..404 run return run function catan:direct/confirm
execute if score #code ca_ctx matches 352..354 run return run function catan:direct/confirm
execute if score #code ca_ctx matches 10 run return run function catan:input/roll
function catan:direct/confirm
''')
    put('direct/q_aim','$scoreboard players set @s ca_mode $(build)\ntag @s add ca.q_aim\nfunction catan:input/aim\ntag @s remove ca.q_aim')
    # 宏中的资源和发展牌没有action字段，先规范到完整结构再调用。
    put('input/check_drop','''
scoreboard players set #owner ca_ctx 0
execute on origin if entity @s[tag=ca.dropper] run scoreboard players set #owner ca_ctx 1
execute unless score #owner ca_ctx matches 1 run return 0
data modify storage catan:input drop set value {action:-1,table:-1,epoch:-1}
data modify storage catan:input drop merge from entity @s Item.components."minecraft:custom_data".catan
function catan:input/use_drop
kill @s
''')
    put('direct/confirm','''
execute if score @s ca_confirm = #code ca_ctx if score @s ca_cepoch = @e[tag=ca.current,limit=1] ca_epoch run return run function catan:direct/submit
scoreboard players operation @s ca_confirm = #code ca_ctx
scoreboard players operation @s ca_cepoch = @e[tag=ca.current,limit=1] ca_epoch
''' + notice('再次按Q确认；取消选项可撤销。','aqua'))
    put('direct/submit','''
scoreboard players set @s ca_confirm -999
scoreboard players operation @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch
execute if score #code ca_ctx matches 352 unless score @s ca_pay matches 0..4 run return run function catan:direct/choose_first
execute if score #code ca_ctx matches 352 unless score @s ca_receive matches 0..4 run return run function catan:direct/choose_first
execute if score #code ca_ctx matches 353..354 unless score @s ca_a matches 0..4 run return run function catan:direct/choose_first
execute if score #code ca_ctx matches 354 unless score @s ca_b matches 0..4 run return run function catan:direct/choose_first
execute if score #code ca_ctx matches 352 run return run function catan:ui/send_bank
execute if score #code ca_ctx matches 353 run return run function catan:ui/send_monopoly
execute if score #code ca_ctx matches 354 run return run function catan:ui/send_plenty
execute if score #code ca_ctx matches 401..404 run return run function catan:direct/steal
execute if score #code ca_ctx matches 600..603 run return run function catan:direct/dev_submit
execute store result storage catan:direct code int 1 run scoreboard players get #code ca_ctx
function catan:ui/simple with storage catan:direct
''')
    put('input/roll','''
function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
execute if entity @e[tag=ca.current,scores={ca_state=6},limit=1] run return run function catan:input/aim
execute unless entity @e[tag=ca.current,scores={ca_state=3},limit=1] run return run function catan:direct/roll_note
scoreboard players operation @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch
function catan:ui/simple {code:10}
''')
    put('direct/roll_note',notice('当前阶段无需投骰，请先完成建造、弃牌或强盗操作。'))
    put('game/busy','execute as @a[tag=ca.actor] run function catan:direct/busy')
    put('direct/choose_first',notice('请先选择完整的资源种类，再确认提交。','red'))
    # 左键取消，沿用单个桌面interaction的真实射线。
    extend('game/tick','execute as @e[tag=ca.surface] if score @s ct_id = #table ca_ctx if data entity @s attack run function catan:direct/left\nexecute as @a[tag=ca.audience] run function catan:hud/tick\nexecute as @e[tag=ca.deck_hit] if score @s ct_id = #table ca_ctx if data entity @s interaction run function catan:direct/deck_click')
    put('direct/left','execute on attacker if entity @s[type=minecraft:player] run function catan:direct/cancel\ndata remove entity @s attack')
    # 每次Q后缺失的控制物补回，资源则按服务器库存重新显示。
    extend('input/drop','execute as @a[tag=ca.player] if score @s ca_table = #table ca_ctx run function catan:direct/controls')
    extend('tick','execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{catan:{tool:1b}}] run function catan:direct/recover_drop')
    put('direct/resource_drop','function catan:direct/recover_drop')
    put('direct/recover_drop','execute on origin run scoreboard players reset @s ca_inv_epoch\nkill @s')
    inventory()
    resources()
    trading()
    scene()
    looking()
    # 遗留入口直接提示，不可再把规则失败或投骰导回旧菜单。
    put('ui/open','function catan:input/context\nexecute unless entity @s[tag=ca.actor] run return 0\nfunction catan:direct/controls\n'+notice('建筑右键或Q；资源和发展卡在物品栏，交易使用交易物品。'))
    put('ui/stale',notice('局面或交易报价已变化，请重新操作。','red'))
    put('game/illegal_message','$execute as @a[tag=ca.actor] run function catan:hud/notice {text:{text:"$(error)",color:"red"}}')
    path=ROOT/'game/illegal.mcfunction';body=path.read_text(encoding='utf-8').replace('重新打开菜单查看下一步','查看当前阶段和操作提示').replace('这个窗口已经过期，请从第9格 Q 菜单重新操作。','局面已经变化，请重新选择。').replace('请看菜单顶部的个人提示','请看当前阶段提示')
    put('game/illegal',body)
    put('direct/private','execute store result storage catan:ui side int 1 run scoreboard players get @s ca_side\nfunction catan:ui/color_label\nfunction catan:ui/private with storage catan:ui')
    for path in (ROOT/'direct').glob('*.mcfunction'):
        if path.stem=='private':continue
        body=path.read_text(encoding='utf-8')
        if 'function catan:ui/private with storage catan:ui' in body:
            put('direct/'+path.stem,body.replace('function catan:ui/private with storage catan:ui','function catan:direct/private'))
    from build_catan_usability import build as usability
    usability()
    from build_table_feedback import catan as feedback
    feedback()
    from build_tabletop_hand_poses import build as hand_poses
    hand_poses()
    from build_direct_support import finish
    finish('catan')


def inventory():
    lines=['function catan:direct/read_hand with storage catan:direct']+[f'clear @s minecraft:{item}[minecraft:custom_data~{{catan:{{resource:1b}}}}]' for name,slug,item in RES]
    for i,(name,slug,item) in enumerate(RES):
        lines += [f'execute store result score #wanted ca_ctx run data get storage catan:direct hand.resources[{i}]',f'execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx',f'function catan:direct/resource_inventory {{id:{i},name:"{name}",model:"card:catan/hand/resource/{slug}"}}']
    put('direct/resources',lines)
    put('direct/resource_inventory','''
$execute store result score #have ca_ctx run clear @s *[minecraft:custom_data~{catan:{resource:1b,id:$(id)}}] 0
execute if score #have ca_ctx = #wanted ca_ctx run return 0
$clear @s *[minecraft:custom_data~{catan:{resource:1b,id:$(id)}}]
execute if score #wanted ca_ctx matches 1.. run function catan:direct/inventory_space
execute if score #wanted ca_ctx matches 1.. unless score #space ca_ctx matches 1 run return run function catan:direct/no_space
$data modify storage catan:direct card set value {id:$(id),name:"$(name)",model:"$(model)"}
data modify storage catan:direct card.count set from storage catan:direct count
data modify storage catan:direct card.table set from storage catan:direct table
execute if score #wanted ca_ctx matches 1.. run function catan:direct/resource_item with storage catan:direct card
''')
    put('direct/resource_item','$give @s minecraft:paper[minecraft:item_model="$(model)",minecraft:custom_name={text:"$(name)",color:"aqua",italic:false},minecraft:lore=[{text:"Q：弃牌／资源选择；普通回合Q选择银行支付资源",color:"gray",italic:false}],minecraft:custom_data={catan:{tool:1b,resource:1b,id:$(id),table:$(table)}}] $(count)')
    lines=[]
    for i,(name,slug,effect) in enumerate(DEV):
        for fresh in (0,1):
            field='fresh' if fresh else 'dev'
            lines += [f'execute store result score #wanted ca_ctx run data get storage catan:direct hand.{field}[{i}]',f'execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx',f'function catan:direct/dev_inventory {{id:{i},fresh:{fresh},name:"{name}",effect:"{effect}",model:"card:catan/hand/dev/{slug}"}}']
    put('direct/development',lines)
    put('direct/dev_inventory','''
$execute store result score #have ca_ctx run clear @s *[minecraft:custom_data~{catan:{development:1b,id:$(id),fresh:$(fresh)}}] 0
execute if score #have ca_ctx = #wanted ca_ctx run return 0
$clear @s *[minecraft:custom_data~{catan:{development:1b,id:$(id),fresh:$(fresh)}}]
execute if score #wanted ca_ctx matches 1.. run function catan:direct/inventory_space
execute if score #wanted ca_ctx matches 1.. unless score #space ca_ctx matches 1 run return run function catan:direct/no_space
$data modify storage catan:direct card set value {id:$(id),fresh:$(fresh),name:"$(name)",effect:"$(effect)",model:"$(model)"}
data modify storage catan:direct card.count set from storage catan:direct count
data modify storage catan:direct card.table set from storage catan:direct table
execute if score #wanted ca_ctx matches 1.. run function catan:direct/dev_item with storage catan:direct card
''')
    put('direct/dev_item','$give @s minecraft:paper[minecraft:item_model="$(model)",minecraft:custom_name={text:"$(name)：$(effect)",color:"gold",italic:false},minecraft:lore=[{text:"Q选中，再按Q使用；新买牌下回合才可用，胜利点自动计分",color:"gray",italic:false}],minecraft:custom_data={catan:{tool:1b,development:1b,id:$(id),fresh:$(fresh),table:$(table)}}] $(count)')
    put('direct/dev_use','''
$execute if predicate {condition:"minecraft:value_check",value:$(id),range:4} run return run function catan:direct/vp_note
$execute if predicate {condition:"minecraft:value_check",value:$(fresh),range:1} run return run function catan:direct/fresh_note
$scoreboard players set #code ca_ctx $(id)
scoreboard players add #code ca_ctx 600
function catan:direct/confirm
''')
    put('direct/dev_submit','''
execute if score #code ca_ctx matches 600 run return run function catan:ui/dev_0
execute if score #code ca_ctx matches 601 run return run function catan:ui/dev_1
execute if score #code ca_ctx matches 602 run scoreboard players set @s ca_edit 4
execute if score #code ca_ctx matches 603 run scoreboard players set @s ca_edit 5
scoreboard players set @s ca_step 0
scoreboard players set @s ca_a -1
scoreboard players set @s ca_b -1
function catan:direct/resource_controls
''')
    put('direct/vp_note',notice('胜利点牌已自动计分，无需使用；仅本人可见。'))
    put('direct/fresh_note',notice('这张发展卡是本回合买入的，下回合才能使用。','red'))
    put('direct/inventory_space',['scoreboard players set #space ca_ctx 0']+[f'execute unless items entity @s inventory.{i} * run scoreboard players set #space ca_ctx 1' for i in range(27)])
    put('direct/no_space','execute if score @s ca_htimer matches 1.. run return 0\n'+notice('物品栏已满，请空出一格；资源和发展卡仍保存在本桌，会自动补回。','red'))
    # 替换旧原版方块镜像，防止放置／合成／喂食转移或消耗游戏资产。
    extend('player/clear_state','clear @s *[minecraft:custom_data~{catan:{tool:1b}}]\nfunction catan:hud/deactivate\nscoreboard players reset @s ca_depoch')
    rp=PACK.resolve().parents[3]/'resourcepacks/fimelcard-rp'
    candidates=list((rp/'assets/card/items/catan').rglob('*.json'))
    # 现有发展牌的资源名以唯一模型实际文件为准。
    for i,(name,slug,effect) in enumerate(DEV):
        names={'road_building':['road_building','roads'],'plenty':['year_of_plenty','plenty','invention'],'victory_point':['victory_point','victory','vp']}.get(slug,[slug])
        found=next((f for f in candidates if f.stem in names and '/hand/' not in f.as_posix()),None)
        fallback=('minecraft:item/'+['iron_sword','rail','emerald','bread','nether_star'][i]) if found is None else json.loads(found.read_text(encoding='utf-8'))['model'].get('model','minecraft:item/book')
        write_private(rp,'dev/'+slug,fallback)
    for name,slug,item in RES:
        write_private(rp,'resource/'+slug,'card:item/catan/resource/'+slug)
    target=rp/'.source/catan/direct-interaction.json';target.parent.mkdir(parents=True,exist_ok=True)
    target.write_text(js({'source':'tools/build_catan_direct.py','private_cards':'card:catan/hand/{resource,dev}/<name>','rule_authority':'controller.data.catan'})+'\n',encoding='utf-8')


def write_private(rp,name,model):
    path=rp/f'assets/card/items/catan/hand/{name}.json';path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(js({'model':{'type':'minecraft:select','property':'minecraft:display_context','cases':[{'when':['thirdperson_righthand','thirdperson_lefthand','ground'],'model':{'type':'minecraft:model','model':'minecraft:item/paper'}}],'fallback':{'type':'minecraft:model','model':model}}})+'\n',encoding='utf-8')


def resources():
    put('direct/resource_controls',[tool(i,900+i,name+'〔Q选择〕','card:catan/resource/'+slug) for i,(name,slug,item) in enumerate(RES)] + [tool(5,998,'撤销一张待弃资源〔Q〕','minecraft:arrow'),'execute if score @s ca_edit matches 3 run '+tool(6,352,'确认兑换〔Q两次〕','minecraft:lime_dye'),'execute if score @s ca_edit matches 4 run '+tool(6,353,'确认垄断〔Q两次〕','minecraft:lime_dye'),'execute if score @s ca_edit matches 5 run '+tool(6,354,'确认丰收〔Q两次〕','minecraft:lime_dye')])
    put('direct/resource_code','scoreboard players operation #resource ca_ctx = #code ca_ctx\nscoreboard players remove #resource ca_ctx 900\nexecute store result storage catan:direct id int 1 run scoreboard players get #resource ca_ctx\nfunction catan:direct/resource with storage catan:direct')
    put('direct/resource','''
$scoreboard players set #resource ca_ctx $(id)
execute if entity @e[tag=ca.current,scores={ca_state=5},limit=1] run return run function catan:direct/discard_add
execute if score @s ca_edit matches 4 run scoreboard players operation @s ca_a = #resource ca_ctx
execute if score @s ca_edit matches 4 run return run function catan:direct/selected_resource
execute if score @s ca_edit matches 5 run return run function catan:direct/plenty_select
execute unless score @s ca_edit matches 3 run function catan:direct/bank_begin
execute if score @s ca_step matches 0 run return run function catan:direct/pay_select
scoreboard players operation @s ca_receive = #resource ca_ctx
scoreboard players set @s ca_step 0
function catan:direct/bank_quote
''')
    put('direct/selected_resource',notice('已选择垄断资源，使用“确认垄断”按Q两次提交。','aqua'))
    put('direct/pay_select','scoreboard players operation @s ca_pay = #resource ca_ctx\nscoreboard players set @s ca_step 1\n'+notice('已选择支付资源，再选择要换取的资源。'))
    put('direct/plenty_select','''
execute if score @s ca_step matches 0 run return run function catan:direct/plenty_first
scoreboard players operation @s ca_b = #resource ca_ctx
scoreboard players set @s ca_step 0
''' + notice('两张资源已选好，可以同种；使用“确认丰收”按Q两次提交。','aqua'))
    put('direct/plenty_first','scoreboard players operation @s ca_a = #resource ca_ctx\nscoreboard players set @s ca_step 1\n'+notice('已选择第一张，再选择第二张资源，可以相同。'))
    put('direct/discard_begin','''
execute store result storage catan:ui side int 1 run scoreboard players get @s ca_side
function catan:ui/private with storage catan:ui
execute if data storage catan:ui hand{discard_due:0} run return 0
execute unless score @s ca_dphase matches 1 run function catan:direct/discard_reset
scoreboard players set @s ca_dphase 1
scoreboard players set @s ca_edit 1
''')
    put('direct/discard_reset',[f'scoreboard players set @s ca_g{i} 0' for i in range(5)])
    put('direct/discard_add','''
execute store result storage catan:ui side int 1 run scoreboard players get @s ca_side
function catan:ui/private with storage catan:ui
execute if data storage catan:ui hand{discard_due:0} run return run function catan:direct/no_discard
scoreboard players set @s ca_edit 1
execute store result storage catan:direct id int 1 run scoreboard players get #resource ca_ctx
function catan:direct/discard_one with storage catan:direct
''')
    put('direct/discard_one','''
$execute store result score #owned ca_ctx run data get storage catan:ui hand.resources[$(id)]
$execute if score @s ca_g$(id) >= #owned ca_ctx run return run function catan:direct/no_resource
$scoreboard players add @s ca_g$(id) 1
$scoreboard players set @s ca_lastres $(id)
function catan:direct/discard_progress
''')
    put('direct/discard_progress',['scoreboard players set #selected ca_ctx 0']+[f'scoreboard players operation #selected ca_ctx += @s ca_g{i}' for i in range(5)]+['execute store result score #due ca_ctx run data get storage catan:ui hand.discard_due','execute store result storage catan:direct selected int 1 run scoreboard players get #selected ca_ctx','execute store result storage catan:direct due int 1 run scoreboard players get #due ca_ctx','function catan:direct/discard_note with storage catan:direct','execute if score #selected ca_ctx = #due ca_ctx run function catan:direct/discard_commit'])
    put('direct/discard_note','$function catan:hud/notice {text:{text:"待弃 $(selected)/$(due) 张；选满自动提交，撤销物品可退回一张。",color:"yellow"}}')
    put('direct/discard_commit','scoreboard players operation @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch\nfunction catan:ui/send_discard\nfunction catan:direct/discard_reset')
    put('direct/undo','''
execute unless score @s ca_edit matches 1 run return run function catan:direct/cancel
scoreboard players set #removed ca_ctx 0
'''+ '\n'.join(f'execute if score #removed ca_ctx matches 0 if score @s ca_g{i} matches 1.. run function catan:direct/undo_one {{id:{i}}}' for i in reversed(range(5)))+'''
execute store result storage catan:ui side int 1 run scoreboard players get @s ca_side
function catan:ui/private with storage catan:ui
function catan:direct/discard_progress
''')
    put('direct/undo_one','$scoreboard players remove @s ca_g$(id) 1\nscoreboard players set #removed ca_ctx 1')
    put('direct/no_resource',notice('该种资源的待弃数量已达到你实际持有的数量。','red'))
    put('direct/no_discard',notice('你本次无需弃牌，请等待其他玩家。'))


def trading():
    put('direct/bank_begin','scoreboard players set @s ca_edit 3\nscoreboard players set @s ca_step 0\nscoreboard players set @s ca_batch 1\nscoreboard players set @s ca_pay -1\nscoreboard players set @s ca_receive -1\nfunction catan:direct/resource_controls\n'+notice('先选择支付资源，再选择换取资源；确认兑换按Q两次。'))
    put('direct/bank_quote','''
execute store result storage catan:ui side int 1 run scoreboard players get @s ca_side
function catan:ui/private with storage catan:ui
data modify storage catan:ui bank set from entity @e[tag=ca.current,limit=1] data.catan.bank
function catan:ui/bank_summary
execute store result storage catan:direct pay int 1 run scoreboard players get @s ca_pay
execute store result storage catan:direct receive int 1 run scoreboard players get @s ca_receive
function catan:direct/bank_names with storage catan:direct
''')
    put('direct/bank_names','''
$data modify storage catan:direct ratio set from storage catan:ui ratio$(pay)
'''+ '\n'.join(f'execute if score @s ca_pay matches {i} run data modify storage catan:direct give_name set value "{name}"\nexecute if score @s ca_receive matches {i} run data modify storage catan:direct get_name set value "{name}"' for i,(name,slug,item) in enumerate(RES))+'''
function catan:direct/bank_note with storage catan:direct
''')
    put('direct/bank_note','$function catan:hud/notice {text:{text:"$(give_name) $(ratio) 张 → $(get_name) 1张；确认兑换按Q两次。",color:"aqua"}}')
    put('direct/trade_begin','''
execute if data entity @e[tag=ca.current,limit=1] data.catan.trade run return run function catan:ui/trade_response
'''+ '\n'.join(f'execute unless score @s ca_side matches {i} if data entity @e[tag=ca.current,limit=1] data.catan.p{i}.name run function catan:direct/partner_tool {{side:{i}}}' for i in range(1,5))+'\n'+notice('手持目标玩家的交易物品按Q，打开单页报价编辑器。'))
    put('direct/partner_tool','''
$execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn unless score @e[tag=ca.current,limit=1] ca_turn matches $(side) run return 0
$data modify storage catan:direct partner set from entity @e[tag=ca.current,limit=1] data.catan.p$(side)
$data modify storage catan:direct partner.side set value $(side)
execute store result storage catan:direct partner.table int 1 run scoreboard players get @s ca_table
execute store result storage catan:direct partner.epoch int 1 run scoreboard players get @e[tag=ca.current,limit=1] ca_epoch
function catan:direct/partner_item with storage catan:direct partner
''')
    put('direct/partner_item','$item replace entity @s hotbar.$(side) with minecraft:paper[minecraft:item_model="minecraft:emerald",minecraft:custom_name={text:"交易：",italic:false,extra:[$(name)]},minecraft:custom_data={catan:{tool:1b,control:1b,action:50$(side),table:$(table),epoch:$(epoch)}}]')
    put('direct/partner','scoreboard players operation @s ca_partner = #code ca_ctx\nscoreboard players remove @s ca_partner 500\nscoreboard players operation @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch\nfunction catan:ui/trade_begin')
    path=ROOT/'ui/trade_guard.mcfunction'
    body=path.read_text(encoding='utf-8').replace('unless score @s ca_side matches $(to) run return run function catan:ui/open','unless score @s ca_side matches $(to) run return run function catan:direct/trade_unrelated')
    put('ui/trade_guard',body)
    put('direct/trade_unrelated',notice('当前报价不属于你，请等待交易双方处理；报价内容仅双方可见。','red'))
    # 仅报价与查看报价需要对话框。银行、弃牌、垄断和丰收的旧入口也转到直接操作。
    put('ui/bank','function catan:direct/bank_begin')
    put('ui/discard','function catan:direct/discard_begin\nfunction catan:direct/resource_controls')
    put('ui/dev_2','scoreboard players set @s ca_edit 4\nscoreboard players set @s ca_step 0\nfunction catan:direct/resource_controls')
    put('ui/dev_3','scoreboard players set @s ca_edit 5\nscoreboard players set @s ca_step 0\nfunction catan:direct/resource_controls')
    put('direct/victims',[f'execute if data entity @e[tag=ca.current,limit=1] data.catan{{eligible:[{i}]}} run function catan:direct/victim_tool {{side:{i}}}' for i in range(1,5)])
    put('direct/victim_tool','''
$data modify storage catan:direct victim set from entity @e[tag=ca.current,limit=1] data.catan.p$(side)
$data modify storage catan:direct victim.side set value $(side)
execute store result storage catan:direct victim.table int 1 run scoreboard players get @s ca_table
execute store result storage catan:direct victim.epoch int 1 run scoreboard players get @e[tag=ca.current,limit=1] ca_epoch
function catan:direct/victim_item with storage catan:direct victim
''')
    put('direct/victim_item','$item replace entity @s hotbar.$(side) with minecraft:paper[minecraft:item_model="minecraft:player_head",minecraft:custom_name={text:"偷取：",color:"red",italic:false,extra:[$(name)]},minecraft:custom_data={catan:{tool:1b,control:1b,action:40$(side),table:$(table),epoch:$(epoch)}}]')
    for name in ('partner_item','victim_item'):
        path=ROOT/f'direct/{name}.mcfunction';body=path.read_text(encoding='utf-8')
        put('direct/'+name,'$execute if items entity @s hotbar.$(side) * unless items entity @s hotbar.$(side) *[minecraft:custom_data~{catan:{tool:1b}}] run return run function catan:direct/space\n'+body)
    put('direct/steal','scoreboard players operation #target ca_ctx = #code ca_ctx\nscoreboard players remove #target ca_ctx 400\nexecute store result storage catan:direct target int 1 run scoreboard players get #target ca_ctx\nfunction catan:ui/steal with storage catan:direct')


def scene():
    extend('visual/refresh','execute if score @s ct_state matches 1 unless data entity @s data.catan{review:1b} run function catan:direct/deck_spawn')
    extend('game/start','execute if score @s ct_start matches 1 run function catan:direct/deck_spawn')
    extend('game/after_action','function catan:direct/deck_spawn')
    extend('visual/clear','scoreboard players operation #table ca_ctx = @s ct_id\nexecute as @e[tag=ca.deck_direct] if score @s ct_id = #table ca_ctx run kill @s')
    put('direct/deck_spawn','''
scoreboard players operation #table ca_ctx = @s ct_id
execute as @e[tag=ca.deck_direct] if score @s ct_id = #table ca_ctx run kill @s
execute store result storage catan:direct remaining int 1 run data get entity @s data.catan.dev_deck
scoreboard players operation #deck_orient ca_ctx = @s ca_orient
# The square table corners are outside the hexagonal sea frame at both sizes.
execute if score @s ct_capacity matches 4 if score @s ca_orient matches 0 positioned ~1.18 ~1.10 ~-1.18 run function catan:direct/deck_at
execute if score @s ct_capacity matches 4 if score @s ca_orient matches 1 positioned ~1.18 ~1.10 ~1.18 run function catan:direct/deck_at
execute if score @s ct_capacity matches 8 if score @s ca_orient matches 0 positioned ~1.65 ~1.10 ~-1.65 run function catan:direct/deck_at
execute if score @s ct_capacity matches 8 if score @s ca_orient matches 1 positioned ~1.65 ~1.10 ~1.65 run function catan:direct/deck_at
''')
    put('direct/deck_at','execute summon minecraft:item_display run function catan:direct/deck_init\nexecute summon minecraft:interaction run function catan:direct/deck_hit_init\nexecute positioned ~ ~0.2 ~ summon minecraft:text_display run function catan:direct/deck_label with storage catan:direct')
    put('direct/deck_label','tag @s add ca.deck_direct\nscoreboard players operation @s ct_id = #table ca_ctx\n$data merge entity @s {billboard:"vertical",Rotation:[0f,0f],background:0,shadow:1b,text:{text:"发展卡 $(remaining)",color:"gold"},transformation:{translation:[0f,0f,0f],scale:[0.2f,0.2f,0.2f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f]}}')
    put('direct/deck_init','''
tag @s add ca.deck_direct
scoreboard players operation @s ct_id = #table ca_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:catan/development_deck"}},item_display:"none",brightness:{block:15,sky:15},transformation:{translation:[0f,0.15f,0f],scale:[0.3f,0.3f,0.3f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,1f,0f,0f]}}
execute if score #deck_orient ca_ctx matches 1 run data modify entity @s transformation.left_rotation set value [0f,-0.7071068f,0f,0.7071068f]
''')
    put('direct/deck_hit_init','tag @s add ca.deck_direct\ntag @s add ca.deck_hit\nscoreboard players operation @s ct_id = #table ca_ctx\ndata merge entity @s {width:0.5f,height:0.2f,response:1b}')
    put('direct/deck_click','scoreboard players operation #click_table ca_ctx = @s ct_id\nexecute on target if entity @s[type=minecraft:player] if score @s ca_table = #click_table ca_ctx run function catan:direct/deck_use\ndata remove entity @s interaction')
    put('direct/deck_use','function catan:input/context\nexecute unless entity @s[tag=ca.actor] run return 0\nscoreboard players set #code ca_ctx 23\nfunction catan:direct/confirm')


def looking():
    for name in ('input/aim','input/roll'):
        path=ROOT/(name+'.mcfunction');body=path.read_text(encoding='utf-8')
        guard='execute unless entity @s[tag=ca.actor] run return 0'
        body=body.replace(guard,guard+'\nexecute if entity @e[tag=ca.current,scores={ca_state=7},limit=1] run return run function catan:direct/steal_look')
        put(name,body)
    path=ROOT/'direct/trade_begin.mcfunction';body=path.read_text(encoding='utf-8')
    first='execute if data entity @e[tag=ca.current,limit=1] data.catan.trade run return run function catan:ui/trade_response'
    body=body.replace(first,first+'\nfunction catan:direct/look\nexecute if score #look_side ca_ctx matches 1..4 run return run function catan:direct/look_trade')
    put('direct/trade_begin',body)
    put('direct/look','''
kill @e[tag=ca.look_ray]
tag @a[tag=ca.look_actor] remove ca.look_actor
tag @s add ca.look_actor
scoreboard players set #look_side ca_ctx -1
scoreboard players set #look_steps ca_ctx 32
execute anchored eyes positioned ^ ^ ^ summon minecraft:marker run tag @s add ca.look_ray
data modify entity @e[tag=ca.look_ray,limit=1] Rotation set from entity @s Rotation
execute as @e[tag=ca.look_ray,limit=1] at @s run function catan:direct/look_step
kill @e[tag=ca.look_ray]
tag @s remove ca.look_actor
''')
    put('direct/look_step','''
execute as @a[tag=ca.audience,tag=!ca.look_actor] at @s positioned ~ ~1 ~ if entity @e[tag=ca.look_ray,distance=..0.7,limit=1] run scoreboard players operation #look_side ca_ctx = @s ca_side
execute if score #look_side ca_ctx matches 1..4 run return 0
scoreboard players remove #look_steps ca_ctx 1
execute unless score #look_steps ca_ctx matches 1.. run return 0
tp @s ^ ^ ^0.3
execute at @s run function catan:direct/look_step
''')
    put('direct/look_trade','''
scoreboard players operation @s ca_partner = #look_side ca_ctx
scoreboard players operation @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch
execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn unless score #look_side ca_ctx = @e[tag=ca.current,limit=1] ca_turn run return run function catan:direct/wait
function catan:ui/trade_begin
''')
    put('direct/steal_look','''
execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run return run function catan:direct/wait
function catan:direct/look
execute unless score #look_side ca_ctx matches 1..4 run return run function catan:direct/look_miss
scoreboard players operation #code ca_ctx = #look_side ca_ctx
scoreboard players add #code ca_ctx 400
execute store result storage catan:direct target int 1 run scoreboard players get #look_side ca_ctx
function catan:direct/steal_check with storage catan:direct
''')
    put('direct/steal_check','$execute unless data entity @e[tag=ca.current,limit=1] data.catan{eligible:[$(target)]} run return run function catan:direct/look_invalid\nfunction catan:direct/confirm')
    put('direct/look_miss',notice('请瞄准相邻对手，或手持对应玩家的偷取选项按Q。','red'))
    put('direct/look_invalid',notice('该玩家没有与强盗地块相邻的建筑，不能偷取。','red'))
    extend('game/tick','''execute as @e[tag=ca.surface] if score @s ct_id = #table ca_ctx if data entity @s attack run function catan:direct/left
execute as @a[tag=ca.audience] run function catan:hud/tick
execute as @e[tag=ca.deck_hit] if score @s ct_id = #table ca_ctx if data entity @s interaction run function catan:direct/deck_click
execute if score @s ca_state matches 7 if data entity @s data.catan.eligible[0] unless data entity @s data.catan.eligible[1] as @a[tag=ca.audience] if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run function catan:direct/auto_steal
scoreboard players add @s ca_dclock 1
execute if score @s ca_dclock matches 5.. run scoreboard players set @s ca_dclock 0
execute if score @s ca_dclock matches 0 as @a[tag=ca.audience] at @s if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run function catan:direct/look_highlight
''')
    put('direct/auto_steal','function catan:input/context\nexecute store result score #code ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.eligible[0]\nscoreboard players add #code ca_ctx 400\nfunction catan:direct/submit')
    put('direct/look_highlight','''
scoreboard players set #looking ca_ctx 0
execute if entity @e[tag=ca.current,scores={ca_state=7},limit=1] run scoreboard players set #looking ca_ctx 1
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{catan:{action:200}}] run scoreboard players set #looking ca_ctx 1
execute unless score #looking ca_ctx matches 1 run return 0
function catan:direct/look
execute unless score #look_side ca_ctx matches 1..4 run return 0
execute store result storage catan:direct target int 1 run scoreboard players get #look_side ca_ctx
function catan:direct/glow_target with storage catan:direct
''')
    put('direct/glow_target','$execute if entity @e[tag=ca.current,scores={ca_state=7},limit=1] unless data entity @e[tag=ca.current,limit=1] data.catan{eligible:[$(target)]} run return 0\n$effect give @a[tag=ca.audience,scores={ca_side=$(target)}] minecraft:glowing 1 0 true')


if __name__=='__main__':build()
