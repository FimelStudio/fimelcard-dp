"""生成 UNO Dialog、名字解析、输入路由与规则；不修改核心规则或通用牌桌。"""
from pathlib import Path
import json

ROOT = Path(__file__).resolve().parents[1] / "data/uno/function"


def put(name, lines):
    path = ROOT / (name + ".mcfunction")
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text((lines.strip() + "\n"), encoding="utf-8")


def js(value):
    return json.dumps(value, ensure_ascii=False, separators=(",", ":"))


def msg(text, color="white", width=440):
    return {"type": "minecraft:plain_message", "width": width,
            "contents": {"text": text, "color": color}}


def action(label, command, color="white"):
    return {"label": {"text": label, "color": color}, "width": 140,
            "action": {"type": "minecraft:run_command", "command": command}}


# 与花火相同：Dialog不会解析selector，先在战利品上下文中解析名字为静态组件。
name_loot = ROOT.parent / "loot_table/player_name.json"
name_loot.parent.mkdir(parents=True, exist_ok=True)
name_loot.write_text(json.dumps({"pools": [{"rolls": 1, "entries": [{
    "type": "minecraft:item", "name": "minecraft:paper", "functions": [{
        "function": "minecraft:set_name", "entity": "this", "name": {"selector": "@s"}
    }]
}]}]}, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
put("name/resolve", '''
# 当前执行者是该行玩家；不向玩家背包写物品，不保留临时展示实体。
data modify storage uno:name resolved set value {text:"未知玩家"}
kill @e[type=minecraft:item_display,tag=un.name_resolver,distance=..1,limit=1]
summon minecraft:item_display ~ ~ ~ {Tags:["un.name_resolver"],view_range:0f,item:{id:"minecraft:paper"}}
loot replace entity @e[type=minecraft:item_display,tag=un.name_resolver,distance=..1,sort=nearest,limit=1] contents loot uno:player_name
data modify storage uno:name resolved set from entity @e[type=minecraft:item_display,tag=un.name_resolver,distance=..1,sort=nearest,limit=1] item.components."minecraft:custom_name"
# 移除名字自带的私聊/悬浮事件，保持对话框显示与按钮行为独立。
data remove storage uno:name resolved.click_event
data remove storage uno:name resolved.hover_event
data remove storage uno:name resolved.insertion
kill @e[type=minecraft:item_display,tag=un.name_resolver,distance=..1,sort=nearest,limit=1]
''')


put("input/give", '''
# 手牌逻辑留在实体记分板；这里只提供快捷栏第1格的操作物。
clear @s minecraft:purple_dye[minecraft:custom_data~{uno:{tool:1b}}]
execute store result storage uno:input table int 1 run scoreboard players get @s un_table
function uno:input/give_tool with storage uno:input
''')
put("input/give_tool", '''
$execute unless items entity @s hotbar.0 * run return run item replace entity @s hotbar.0 with minecraft:purple_dye[minecraft:item_model="card:uno/back",minecraft:item_name="UNO 手牌（按Q打开）",minecraft:custom_data={uno:{tool:1b,table:$(table)}},minecraft:max_stack_size=1]
$give @s minecraft:purple_dye[minecraft:item_model="card:uno/back",minecraft:item_name="UNO 手牌（按Q打开）",minecraft:custom_data={uno:{tool:1b,table:$(table)}},minecraft:max_stack_size=1]
tellraw @s {text:"[UNO] 快捷栏第1格有其他物品，操作物已放入背包；挪空后按Q可归位。",color:"yellow"}
''')
put("input/tick", '''
# 仅扫描即时输入。设置窗口只在打开后启用 trigger。
execute as @a[tag=un.player,scores={un_drop=1..}] at @s run function uno:input/drop
execute as @a[tag=un.player,scores={un_action=1..}] at @s run function uno:input/submit
execute as @a[scores={un_settings=1..}] at @s run function uno:settings/save
''')
put("input/drop", '''
scoreboard players set @s un_drop 0
tag @a[tag=un.dropper] remove un.dropper
tag @s add un.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{uno:{tool:1b}}] run function uno:input/check_drop
tag @s remove un.dropper
''')
put("input/check_drop", '''
# origin 校验保证不会收走隔壁桌或另一玩家的操作物。
scoreboard players set #ui_drop_owner un_ctx 0
execute on origin if entity @s[tag=un.dropper,tag=un.player] run scoreboard players set #ui_drop_owner un_ctx 1
execute unless score #ui_drop_owner un_ctx matches 1 run return 0
kill @s
execute as @a[tag=un.dropper,limit=1] run function uno:input/give
execute as @a[tag=un.dropper,limit=1] at @s run function uno:ui/open
''')
put("input/context", '''
# 玩家入口：同时核验通用座位、游戏归属与控制器当前游戏。
tag @a[tag=un.actor] remove un.actor
tag @e[tag=un.current] remove un.current
execute unless entity @s[tag=un.player,tag=ct.player] run return 0
execute unless score @s ct_id = @s un_table run return 0
scoreboard players operation #ui_table un_ctx = @s un_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=un.controller,scores={ct_game=11,ct_state=1}] if score @s ct_id = #ui_table un_ctx run tag @s add un.current
execute unless entity @e[tag=un.current,limit=1] run return 0
tag @s add un.actor
execute as @e[tag=un.current,limit=1] at @s run function uno:system/context
''')
put("input/invalid", '''
tellraw @s {text:"[UNO] 这个窗口已过期或当前操作不可用，请按Q重新打开手牌。",color:"yellow"}
scoreboard players set @s un_action 0
scoreboard players enable @s un_action
scoreboard players set @s un_colorpick -1
tag @a[tag=un.actor] remove un.actor
''')
put("input/submit", '''
# 编码：当前 epoch × 1000 + 动作；旧对话框及选色页不能操作后续回合。
scoreboard players operation @s un_ui_tmp = @s un_action
scoreboard players set @s un_action 0
scoreboard players enable @s un_action
function uno:input/context
execute unless entity @s[tag=un.actor] run return run function uno:input/invalid
scoreboard players set #ui_1000 un_ctx 1000
scoreboard players operation #ui_epoch un_ctx = @s un_ui_tmp
scoreboard players operation #ui_epoch un_ctx /= #ui_1000 un_ctx
execute unless score #ui_epoch un_ctx = @s un_seen run return run function uno:input/invalid
execute unless score #ui_epoch un_ctx = @e[tag=un.current,limit=1] un_epoch run return run function uno:input/invalid
scoreboard players operation #ui_base un_ctx = @s un_seen
scoreboard players operation #ui_base un_ctx *= #ui_1000 un_ctx
scoreboard players operation #ui_action un_ctx = @s un_ui_tmp
scoreboard players operation #ui_action un_ctx %= #ui_1000 un_ctx
execute if score #ui_action un_ctx matches 200..203 unless score @s un_pick = @s un_colorpick run return run function uno:input/invalid
execute if score #ui_action un_ctx matches 210..213 unless score @s un_pick = @s un_colorpick run return run function uno:input/invalid
execute if score #ui_action un_ctx matches 200..203 unless score @s un_colorpick matches 52..53 run return run function uno:input/invalid
execute if score #ui_action un_ctx matches 210..213 unless score @s un_colorpick matches 52..53 run return run function uno:input/invalid
execute if score #ui_action un_ctx matches 100..153 run return run function uno:input/select
execute if score #ui_action un_ctx matches 1..2 if score @s un_pick matches 52..53 run return run function uno:ui/colors
scoreboard players set #say un_ctx 0
scoreboard players set #color un_ctx 0
execute if score #ui_action un_ctx matches 2 run scoreboard players set #say un_ctx 1
execute if score #ui_action un_ctx matches 200..203 run scoreboard players operation #color un_ctx = #ui_action un_ctx
execute if score #ui_action un_ctx matches 200..203 run scoreboard players remove #color un_ctx 200
execute if score #ui_action un_ctx matches 210..213 run scoreboard players operation #color un_ctx = #ui_action un_ctx
execute if score #ui_action un_ctx matches 210..213 run scoreboard players remove #color un_ctx 210
execute if score #ui_action un_ctx matches 210..213 run scoreboard players set #say un_ctx 1
# 核心只在真正提交牌后置1；出牌失败继续打开窗口修正选择。
scoreboard players set #ui_played un_ctx 0
execute if score #ui_action un_ctx matches 1..2 as @e[tag=un.current,limit=1] at @s run function uno:action/play
execute if score #ui_action un_ctx matches 200..203 if score @s un_pick matches 52..53 as @e[tag=un.current,limit=1] at @s run function uno:action/play
execute if score #ui_action un_ctx matches 210..213 if score @s un_pick matches 52..53 as @e[tag=un.current,limit=1] at @s run function uno:action/play
execute if score #ui_played un_ctx matches 1 run dialog clear @s
execute if score #ui_played un_ctx matches 1 run tag @a[tag=un.actor] remove un.actor
execute if score #ui_played un_ctx matches 1 run return 0
execute if score #ui_action un_ctx matches 3 as @e[tag=un.current,limit=1] at @s run function uno:action/draw
execute if score #ui_action un_ctx matches 4 as @e[tag=un.current,limit=1] at @s run function uno:action/pass
execute if score #ui_action un_ctx matches 5 as @e[tag=un.current,limit=1] at @s run function uno:action/call
execute if score #ui_action un_ctx matches 6 as @e[tag=un.current,limit=1] at @s run function uno:action/catch
execute if score #ui_action un_ctx matches 7 as @e[tag=un.current,limit=1] at @s run function uno:action/accept
execute if score #ui_action un_ctx matches 8 as @e[tag=un.current,limit=1] at @s run function uno:action/challenge
execute if entity @s[tag=un.player] run function uno:ui/open
tag @a[tag=un.actor] remove un.actor
''')
put("input/select", '''
# 每人只选一个牌型；重复点击取消，点另一牌型直接转移亮框。
# 是否持有、是否本回合新摸牌仍由核心在真正出牌时复验。
scoreboard players operation #ui_selection un_ctx = #ui_action un_ctx
scoreboard players remove #ui_selection un_ctx 100
execute if score @s un_pick = #ui_selection un_ctx run return run function uno:input/deselect
scoreboard players operation @s un_pick = #ui_selection un_ctx
function uno:ui/open
''')
put("input/deselect", '''
scoreboard players set @s un_pick -1
function uno:ui/open
''')
put("ui/refresh", '''
# 状态推进后仅更新可用输入，不逐刻向全桌强制弹窗。
function uno:system/context
scoreboard players set @a[tag=un.audience] un_pick -1
scoreboard players set @a[tag=un.audience] un_colorpick -1
scoreboard players set @a[tag=un.audience] un_action 0
scoreboard players enable @a[tag=un.audience] un_action
''')
put("ui/open", '''
function uno:input/context
execute unless entity @s[tag=un.actor] run return 0
scoreboard players set @s un_colorpick -1
scoreboard players operation @s un_seen = @e[tag=un.current,limit=1] un_epoch
scoreboard players operation #ui_base un_ctx = @s un_seen
scoreboard players set #ui_1000 un_ctx 1000
scoreboard players operation #ui_base un_ctx *= #ui_1000 un_ctx
scoreboard players operation #ui_seat un_ctx = @s un_seat
execute store result storage uno:ui table int 1 run scoreboard players get @s un_table
tag @e[tag=un.uihand] remove un.uihand
execute as @e[type=minecraft:marker,tag=un.card] if score @s ct_id = #ui_table un_ctx if score @s un_owner = #ui_seat un_ctx run tag @s add un.uihand
# 54px牌面向基线上方延伸50px；五个空行留出完整的首行牌面。
data modify storage uno:ui grid set value {text:"\\n\\n\\n\\n\\n",shadow_color:0,extra:[]}
data modify storage uno:ui selected set value {text:"未选择",color:"gray"}
scoreboard players set #ui_col un_ctx 0
function uno:ui/build
tag @e[tag=un.uihand] remove un.uihand
function uno:ui/status
function uno:ui/controls
function uno:ui/show with storage uno:ui
scoreboard players set @s un_action 0
scoreboard players enable @s un_action
function uno:hud/update
tag @a[tag=un.actor] remove un.actor
''')

names = []
for color in ["红", "黄", "绿", "蓝"]:
    names.extend([color + str(i) for i in range(10)] + [color + "·跳过", color + "·反转", color + "·+2"])
names += ["变色", "变色+4"]
put("ui/build", "\n".join(
    f'function uno:ui/append {js({"id": i, "glyph": chr(0xE600+i), "name": name})}'
    for i, name in enumerate(names)))
put("ui/append", '''
$execute store result score #ui_count un_ctx if entity @e[tag=un.uihand,scores={un_card=$(id)}]
execute if score #ui_count un_ctx matches 0 run return 0
# 每行仍为8牌型；七个9px换行给54px牌面留出9px行距。
execute if score #ui_col un_ctx matches 8 run data modify storage uno:ui grid.extra append value {text:"\\n\\n\\n\\n\\n\\n\\n"}
execute if score #ui_col un_ctx matches 8 run scoreboard players set #ui_col un_ctx 0
scoreboard players add #ui_col un_ctx 1
$scoreboard players set #ui_code un_ctx $(id)
scoreboard players add #ui_code un_ctx 100
scoreboard players operation #ui_code un_ctx += #ui_base un_ctx
execute store result storage uno:ui pick int 1 run scoreboard players get #ui_code un_ctx
execute store result storage uno:ui count int 1 run scoreboard players get #ui_count un_ctx
$data modify storage uno:ui glyph set value "$(glyph)"
$data modify storage uno:ui name set value "$(name)"
data modify storage uno:ui card_font set value "card:uno/dialog"
data modify storage uno:ui pick_hint set value "点击选择"
$execute if score @s un_pick matches $(id) run data modify storage uno:ui card_font set value "card:uno/dialog_selected"
$execute if score @s un_pick matches $(id) run data modify storage uno:ui pick_hint set value "已选中 · 再点取消"
$execute if score @s un_pick matches $(id) run data modify storage uno:ui selected set value {text:"$(name)",color:"gold"}
function uno:ui/append_card with storage uno:ui
''')
put("ui/append_card", '''
$data modify storage uno:ui grid.extra append value {text:"",click_event:{action:"run_command",command:"trigger un_action set $(pick)"},hover_event:{action:"show_text",value:{text:"$(name) ×$(count) · $(pick_hint)"}},extra:[{text:"$(glyph)",font:"$(card_font)",color:"white"},{text:"×$(count)  ",font:"minecraft:default",color:"white"}]}
''')
put("ui/status", '''
scoreboard players operation #ui_top_idx un_ctx = @e[tag=un.current,limit=1] un_top
scoreboard players set #ui_top_type un_ctx -1
execute as @e[type=minecraft:marker,tag=un.card] if score @s ct_id = #ui_table un_ctx if score @s un_idx = #ui_top_idx un_ctx run scoreboard players operation #ui_top_type un_ctx = @s un_card
data modify storage uno:ui top set value {text:"尚未翻开",color:"gray"}
function uno:ui/top
data modify storage uno:ui phase set value {text:"发牌中，请稍候。",color:"gray"}
execute if entity @e[tag=un.current,scores={un_state=2},limit=1] run data modify storage uno:ui phase set value {text:"等待其他玩家出牌。",color:"gray"}
execute if entity @e[tag=un.current,scores={un_state=2},limit=1] if score @s un_seat = @e[tag=un.current,limit=1] un_turn run data modify storage uno:ui phase set value {text:"轮到你：选一张牌出牌，或主动摸一张。",color:"green"}
execute if entity @e[tag=un.current,scores={un_state=2,un_drew=1},limit=1] if score @s un_seat = @e[tag=un.current,limit=1] un_turn run data modify storage uno:ui phase set value {text:"本回合已摸牌：只能打出刚摸到的牌，或选择不出。",color:"yellow"}
execute if entity @e[tag=un.current,scores={un_state=3},limit=1] run data modify storage uno:ui phase set value {text:"抓UNO阶段：漏喊者可补喊，其他玩家可抓UNO。",color:"yellow"}
execute if entity @e[tag=un.current,scores={un_state=4},limit=1] run data modify storage uno:ui phase set value {text:"等待受罚玩家接受或质疑变色+4。",color:"yellow"}
execute if entity @e[tag=un.current,scores={un_state=5..},limit=1] run data modify storage uno:ui phase set value {text:"本轮已结束，正在结算。",color:"gold"}
data modify storage uno:ui color set value {text:"红",color:"red"}
execute if entity @e[tag=un.current,scores={un_color=1},limit=1] run data modify storage uno:ui color set value {text:"黄",color:"yellow"}
execute if entity @e[tag=un.current,scores={un_color=2},limit=1] run data modify storage uno:ui color set value {text:"绿",color:"green"}
execute if entity @e[tag=un.current,scores={un_color=3},limit=1] run data modify storage uno:ui color set value {text:"蓝",color:"blue"}
data modify storage uno:ui direction set value "顺时针"
execute if entity @e[tag=un.current,scores={un_dir=-1},limit=1] run data modify storage uno:ui direction set value "逆时针"
''')
put("ui/top", "\n".join(
    f'execute if score #ui_top_type un_ctx matches {i} run data modify storage uno:ui top set value {js({"text": name, "color": ["red", "yellow", "green", "blue"][i//13] if i<52 else "light_purple"})}'
    for i, name in enumerate(names)))
put("ui/player_line", '''
execute at @s run function uno:name/resolve
data modify storage uno:ui line_name set value {text:"",color:"white",extra:[]}
data modify storage uno:ui line_name.extra append from storage uno:name resolved
execute store result storage uno:ui line_seat int 1 run scoreboard players get @s un_seat
execute store result storage uno:ui line_count int 1 run scoreboard players get @s un_count
execute store result storage uno:ui line_score int 1 run scoreboard players get @s un_score
data modify storage uno:ui line_turn set value ""
execute if score @s un_seat = @e[tag=un.current,limit=1] un_turn run data modify storage uno:ui line_turn set value " ▶"
function uno:ui/player_append with storage uno:ui
''')
put("ui/player_append", '''
$data modify storage uno:ui players.extra append value {text:"",extra:[{text:"$(line_seat)号位 ",color:"gray"},$(line_name),{text:" · $(line_count)张 · $(line_score)分$(line_turn)\\n",color:"gray"}]}
''')
put("ui/controls", '''
data modify storage uno:ui controls set value []
execute if entity @e[tag=un.current,scores={un_state=2},limit=1] if score @s un_seat = @e[tag=un.current,limit=1] un_turn run function uno:ui/turn_controls
execute if entity @e[tag=un.current,scores={un_state=3},limit=1] if score @s un_seat = @e[tag=un.current,limit=1] un_pending run function uno:ui/control {code:5,label:"补喊 UNO",color:"green"}
execute if entity @e[tag=un.current,scores={un_state=3},limit=1] unless score @s un_seat = @e[tag=un.current,limit=1] un_pending run function uno:ui/control {code:6,label:"抓 UNO",color:"yellow"}
execute if entity @e[tag=un.current,scores={un_state=4},limit=1] if score @s un_seat = @e[tag=un.current,limit=1] un_challenger run function uno:ui/control {code:7,label:"接受：摸4并跳过",color:"yellow"}
execute if entity @e[tag=un.current,scores={un_state=4},limit=1] if score @s un_seat = @e[tag=un.current,limit=1] un_challenger run function uno:ui/control {code:8,label:"质疑 +4",color:"red"}
''')
put("ui/turn_controls", '''
execute if score @s un_pick matches 0..53 run function uno:ui/control {code:1,label:"出牌",color:"white"}
execute if score @s un_pick matches 0..53 run function uno:ui/control {code:2,label:"出牌并喊 UNO",color:"green"}
execute if entity @e[tag=un.current,scores={un_drew=0},limit=1] run function uno:ui/control {code:3,label:"摸一张",color:"aqua"}
execute if entity @e[tag=un.current,scores={un_drew=1},limit=1] run function uno:ui/control {code:4,label:"摸后不出",color:"yellow"}
''')
put("ui/control", '''
$scoreboard players set #ui_code un_ctx $(code)
scoreboard players operation #ui_code un_ctx += #ui_base un_ctx
execute store result storage uno:ui code int 1 run scoreboard players get #ui_code un_ctx
$data modify storage uno:ui label set value "$(label)"
$data modify storage uno:ui control_color set value "$(color)"
function uno:ui/control_append with storage uno:ui
''')
put("ui/control_append", '''
$data modify storage uno:ui controls append value {label:{text:"$(label)",color:"$(control_color)"},width:140,action:{type:"minecraft:run_command",command:"trigger un_action set $(code)"}}
''')
put("ui/show", '''
$dialog show @s {type:"minecraft:multi_action",title:{text:"UNO · 手牌",color:"gold"},body:[{type:"minecraft:plain_message",width:460,contents:$(phase)},{type:"minecraft:plain_message",width:460,contents:[{text:"顶牌：",color:"gray"},$(top),{text:" · 当前颜色：",color:"gray"},$(color),{text:" · $(direction)\\n已选：",color:"gray"},$(selected)]},{type:"minecraft:plain_message",width:660,contents:$(grid)}],columns:3,actions:$(controls),exit_action:{label:{text:"返回游戏"},width:140},pause:false,can_close_with_escape:true,after_action:"close"}
''')
put("ui/colors", '''
# 万能牌的选色按钮携带原窗口epoch；后续回合无法提交。
scoreboard players operation @s un_colorpick = @s un_pick
data modify storage uno:ui colors set value []
scoreboard players set #ui_colorcode un_ctx 200
execute if score #ui_action un_ctx matches 2 run scoreboard players set #ui_colorcode un_ctx 210
scoreboard players operation #ui_colorcode un_ctx += #ui_base un_ctx
function uno:ui/color_button {name:"红",color:"red"}
scoreboard players add #ui_colorcode un_ctx 1
function uno:ui/color_button {name:"黄",color:"yellow"}
scoreboard players add #ui_colorcode un_ctx 1
function uno:ui/color_button {name:"绿",color:"green"}
scoreboard players add #ui_colorcode un_ctx 1
function uno:ui/color_button {name:"蓝",color:"blue"}
function uno:ui/colors_show with storage uno:ui
scoreboard players enable @s un_action
tag @a[tag=un.actor] remove un.actor
''')
put("ui/color_button", '''
execute store result storage uno:ui code int 1 run scoreboard players get #ui_colorcode un_ctx
$data modify storage uno:ui label set value "$(name)"
$data modify storage uno:ui control_color set value "$(color)"
function uno:ui/color_append with storage uno:ui
''')
put("ui/color_append", '''
$data modify storage uno:ui colors append value {label:{text:"$(label)",color:"$(control_color)"},width:100,action:{type:"minecraft:run_command",command:"trigger un_action set $(code)"}}
''')
put("ui/colors_show", '''
$dialog show @s {type:"minecraft:multi_action",title:{text:"UNO · 选择新颜色",color:"gold"},body:[{type:"minecraft:plain_message",width:380,contents:{text:"选择颜色后才会出牌。变色+4可被下家质疑；手中有当前颜色牌时出+4属于违规。"}}],columns:4,actions:$(colors),exit_action:{label:{text:"暂不出牌"}},pause:false}
''')

# 单页即时设置；点击即写入本桌，不另开分项页。
from build_uno_settings import build as build_settings
build_settings(ROOT)

sections = [
    ("人数与目标", "2～8人，超过4人请使用八人桌。经典108张牌，每人7张，起始牌只使用数字牌；按实际座位顺时针开始并跳过空座。先出完手牌者赢得一轮。"),
    ("回合与操作", "快捷栏第1格（hotbar.0）是“UNO 手牌”，选中后按Q打开。点击牌面亮框选中，再点同一牌型取消，点另一牌型直接转移选中；相同牌型合并显示。选好后点“出牌”或“出牌并喊UNO”，每次只出一张；HUD同步显示手牌与选中亮框。牌必须同色、同数字或同功能符号，普通变色牌可随时出并选色。即使能出牌，也可主动摸一张；摸后只能打刚摸到的牌，或选择不出。禁止叠加罚牌、一次出多张、抢出和摸到能出为止。"),
    ("功能牌", "跳过：下家失去回合。反转：行动方向倒转。+2：下家摸2并失去回合。变色：选择当前颜色。变色+4：选择颜色，下家摸4并失去回合或发起质疑。二人局的反转与跳过均让自己再次行动；二人局+2/+4正常罚牌后也回到自己。"),
    ("+4与质疑", "只有手中没有当前颜色牌时，+4才合法；有相同数字或功能、但颜色不同的牌仍可合法出+4。开启质疑时允许冒险违规出牌：下家接受则摸4并跳过；质疑成功，出牌者摸4，质疑者正常行动；质疑失败，质疑者摸6并跳过。系统只公布是否合法，不公开整手牌。关闭质疑时，系统直接禁止违规+4。"),
    ("喊UNO", "打到只剩1张时应选择“出牌并喊UNO”。漏喊会进入抓UNO阶段：本人可补喊，其他玩家可抓UNO；他人先抓到则漏喊者摸2。本人先补喊或无人抓到均不受罚。默认窗口3秒，期间不允许下一位出牌。设置可调整1～5秒或开启自动喊UNO。"),
    ("结算与积分", "默认单局，出完即胜。可在游戏设置选择固定局数或目标积分赛（默认500分）；每轮胜者获得其他玩家剩牌总分。数字牌按牌面分，跳过/反转/+2各20分，变色/+4各50分。末张+2/+4先处理罚牌与质疑再结算；末张+4被质疑成功须摸4并继续本轮。固定局数完成后总分最高者获胜，同分并列。"),
    ("特殊情况与管理", "牌库耗尽时，保留弃牌堆顶牌，将其余弃牌洗回牌库。玩家离线则中止整场并回大厅；/reload保留本场手牌、回合与计分，旧窗口需按Q重开。普通玩家无需管理员权限；结束游戏使用桌边投票。管理员可站在牌桌旁执行 /function uno:admin/abort。"),
]
dialog = {"type":"minecraft:notice","title":{"text":"UNO · 游戏规则","color":"gold","bold":True},"body":[],"pause":False}
for title, text in sections:
    dialog["body"].append({"type":"minecraft:plain_message","width":480,"contents":[{"text":title+"\n","color":"aqua","bold":True},{"text":text,"color":"white"}]})
put("rules/show", 'dialog show @a[tag=ct.rules_actor,limit=1] '+js(dialog))

print("UNO input/ui/settings/rules generated")
