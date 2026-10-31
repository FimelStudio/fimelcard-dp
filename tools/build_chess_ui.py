"""生成国际象棋输入、Dialog、桌内设置和规则，不修改规则引擎或公共牌桌。"""
from pathlib import Path
import json


PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / "data/chess/function"


def put(name, lines):
    path = ROOT / (name + ".mcfunction")
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(lines.strip() + "\n", encoding="utf-8")


def js(value):
    return json.dumps(value, ensure_ascii=False, separators=(",", ":"))


def msg(text, color="white", width=460):
    return {"type": "minecraft:plain_message", "width": width,
            "contents": {"text": text, "color": color}}


put("input/give", '''
# 最后一格：对局菜单；同时替换旧版三个专属操作物。
clear @s minecraft:paper[minecraft:custom_data~{chess:{tool:1b}}]
execute store result storage chess:input table int 1 run scoreboard players get @s ch_table
function chess:input/give_tool with storage chess:input
''')
put("input/give_tool", '''
$function chess:input/place_tool {table:$(table),slot:8,action:0,name:"国际象棋 · 对局菜单",model:"minecraft:book"}
''')
put("input/place_tool", '''
$execute unless items entity @s hotbar.$(slot) * run return run item replace entity @s hotbar.$(slot) with minecraft:paper[minecraft:item_name="$(name)",minecraft:item_model="$(model)",minecraft:custom_data={chess:{tool:1b,action:$(action),table:$(table)}},minecraft:max_stack_size=1]
$give @s minecraft:paper[minecraft:item_name="$(name)",minecraft:item_model="$(model)",minecraft:custom_data={chess:{tool:1b,action:$(action),table:$(table)}},minecraft:max_stack_size=1]
''')
put("input/clear", '''
# 由 player/clear_state 调用；离座会使全部旧面板、旧设置窗口失效。
clear @s minecraft:paper[minecraft:custom_data~{chess:{tool:1b}}]
scoreboard players reset @s ch_action
scoreboard players reset @s ch_settings
scoreboard players reset @s ch_drop
scoreboard players reset @s ch_seen
scoreboard players reset @s ch_ui_load
scoreboard players reset @s ch_ui_tmp
scoreboard players reset @s ch_set_table
scoreboard players reset @s ch_setnonce
scoreboard players reset @s ch_setepoch
scoreboard players reset @s ch_nonce
tag @s remove ch.actor
tag @s remove ch.clicker
tag @s remove ch.dropper
''')
put("input/tick", '''
# 精确消费 interaction 记录，最大延迟一刻；不靠“最近的格子”猜测点击目标。
execute as @e[type=minecraft:interaction,tag=ch.cell] if data entity @s interaction at @s run function chess:input/cell
execute as @a[tag=ch.player,scores={ch_drop=1..}] at @s run function chess:input/drop
execute as @a[tag=ch.player,scores={ch_action=1..}] at @s run function chess:input/submit
execute as @a[scores={ch_settings=1..}] at @s run function chess:settings/save
''')
put("input/click_dispatch", '''
# advancement 只恢复下次右键资格；输入在 tick 中读该格记录的最后右键者。
# 这样不会依赖 advancement 触发与 interaction NBT 写入的先后顺序。
advancement revoke @s only chess:click_cell
''')
put("input/cell", '''
scoreboard players operation #ui_click_table ch_ctx = @s ct_id
scoreboard players operation #target ch_ctx = @s ch_sq
tag @a[tag=ch.actor] remove ch.actor
execute on target if entity @s[type=minecraft:player] run function chess:input/cell_player
data remove entity @s interaction
tag @a[tag=ch.actor] remove ch.actor
''')
put("input/cell_player", '''
execute unless entity @s[tag=ct.player,tag=ch.player] run return 0
execute unless score @s ct_id = #ui_click_table ch_ctx run return 0
execute unless score @s ch_table = #ui_click_table ch_ctx run return 0
function chess:input/context
execute unless entity @s[tag=ch.actor] run return 0
execute unless entity @e[tag=ch.current,scores={ch_state=1},limit=1] run return 0
execute as @e[tag=ch.current,limit=1] at @s run function chess:game/click
''')
put("input/context", '''
# 玩家入口同时核验通用归属、游戏归属与本桌控制器。
tag @a[tag=ch.actor] remove ch.actor
tag @e[tag=ch.current] remove ch.current
execute unless entity @s[tag=ct.player,tag=ch.player] run return 0
execute unless score @s ct_id = @s ch_table run return 0
scoreboard players operation #ui_table ch_ctx = @s ch_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ch.controller,scores={ct_game=12,ct_state=1}] if score @s ct_id = #ui_table ch_ctx run tag @s add ch.current
execute unless entity @e[tag=ch.current,limit=1] run return 0
tag @s add ch.actor
execute as @e[tag=ch.current,limit=1] at @s run function chess:system/context
''')
put("input/drop", '''
scoreboard players set @s ch_drop 0
tag @a[tag=ch.dropper] remove ch.dropper
tag @s add ch.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:paper[minecraft:custom_data~{chess:{tool:1b}}] run function chess:input/check_drop
tag @s remove ch.dropper
''')
put("input/check_drop", '''
scoreboard players set #ui_drop_owner ch_ctx 0
execute on origin if entity @s[tag=ch.dropper,tag=ch.player] run scoreboard players set #ui_drop_owner ch_ctx 1
execute unless score #ui_drop_owner ch_ctx matches 1 run return 0
scoreboard players set #ui_tool ch_ctx 0
execute store result score #ui_tool ch_ctx run data get entity @s Item.components."minecraft:custom_data".chess.action
kill @s
execute as @a[tag=ch.dropper,limit=1] run function chess:input/give
execute as @a[tag=ch.dropper,limit=1] at @s run function chess:ui/quick
''')
put("input/invalid", '''
tellraw @s {text:"[国际象棋] 这个窗口已过期或当前操作不可用，请按Q重新打开面板。",color:"yellow"}
tag @a[tag=ch.actor] remove ch.actor
''')
put("input/submit", '''
# epoch*100 + 动作。回合、阶段或重载变化后，旧窗口不能提交操作。
scoreboard players operation @s ch_ui_tmp = @s ch_action
scoreboard players set @s ch_action 0
scoreboard players enable @s ch_action
function chess:input/context
execute unless entity @s[tag=ch.actor] run return run function chess:input/invalid
execute unless score @s ch_ui_load = #ui_load ch_ctx run return run function chess:input/invalid
scoreboard players set #ui_100 ch_ctx 100
scoreboard players operation #ui_epoch ch_ctx = @s ch_ui_tmp
scoreboard players operation #ui_epoch ch_ctx /= #ui_100 ch_ctx
execute unless score #ui_epoch ch_ctx = @s ch_seen run return run function chess:input/invalid
execute unless score #ui_epoch ch_ctx = @e[tag=ch.current,limit=1] ch_epoch run return run function chess:input/invalid
scoreboard players operation #ui_action ch_ctx = @s ch_ui_tmp
scoreboard players operation #ui_action ch_ctx %= #ui_100 ch_ctx
execute unless score #ui_action ch_ctx matches 1..9 unless score #ui_action ch_ctx matches 10..13 run return run function chess:input/invalid
execute if score #ui_action ch_ctx matches 1 unless entity @e[tag=ch.current,scores={ch_state=1..3},limit=1] run return run function chess:input/invalid
execute if score #ui_action ch_ctx matches 9 unless entity @e[tag=ch.current,scores={ch_state=1..3},limit=1] run return run function chess:input/invalid
execute if score #ui_action ch_ctx matches 2..8 unless entity @e[tag=ch.current,scores={ch_state=1},limit=1] run return run function chess:input/invalid
execute if score #ui_action ch_ctx matches 10..13 unless entity @e[tag=ch.current,scores={ch_state=3},limit=1] run return run function chess:input/invalid
execute if score #ui_action ch_ctx matches 10..13 unless score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run return run function chess:input/invalid
execute if score #ui_action ch_ctx matches 1 as @e[tag=ch.current,limit=1] at @s run function chess:game/resign
execute if score #ui_action ch_ctx matches 2 as @e[tag=ch.current,limit=1] at @s run function chess:game/offer_draw
execute if score #ui_action ch_ctx matches 3 as @e[tag=ch.current,limit=1] at @s run function chess:game/accept_draw
execute if score #ui_action ch_ctx matches 4 as @e[tag=ch.current,limit=1] at @s run function chess:game/decline_draw
execute if score #ui_action ch_ctx matches 5 if entity @e[tag=ch.current,scores={ch_state=1},limit=1] as @e[tag=ch.current,limit=1] at @s run function chess:game/claim_draw
execute if score #ui_action ch_ctx matches 6 as @e[tag=ch.current,limit=1] at @s run function chess:game/offer_undo
execute if score #ui_action ch_ctx matches 7 as @e[tag=ch.current,limit=1] at @s run function chess:game/accept_undo
execute if score #ui_action ch_ctx matches 8 as @e[tag=ch.current,limit=1] at @s run function chess:game/decline_undo
execute if score #ui_action ch_ctx matches 9 run function chess:ui/resign
scoreboard players set #promo ch_ctx 0
execute if score #ui_action ch_ctx matches 10 run scoreboard players set #promo ch_ctx 5
execute if score #ui_action ch_ctx matches 11 run scoreboard players set #promo ch_ctx 4
execute if score #ui_action ch_ctx matches 12 run scoreboard players set #promo ch_ctx 3
execute if score #ui_action ch_ctx matches 13 run scoreboard players set #promo ch_ctx 2
execute if score #promo ch_ctx matches 2..5 as @e[tag=ch.current,limit=1] at @s run function chess:game/promote
tag @a[tag=ch.actor] remove ch.actor
''')
put("ui/refresh", '''
# 更新可用输入，不逐刻强制弹窗。
function chess:system/context
scoreboard players set @a[tag=ch.audience] ch_action 0
scoreboard players enable @a[tag=ch.audience] ch_action
''')
put("ui/begin", '''
scoreboard players operation @s ch_seen = @e[tag=ch.current,limit=1] ch_epoch
scoreboard players operation @s ch_ui_load = #ui_load ch_ctx
scoreboard players operation #ui_base ch_ctx = @s ch_seen
scoreboard players set #ui_100 ch_ctx 100
scoreboard players operation #ui_base ch_ctx *= #ui_100 ch_ctx
data modify storage chess:ui buttons set value []
scoreboard players set @s ch_action 0
scoreboard players enable @s ch_action
''')
put("ui/open", '''
function chess:input/context
execute unless entity @s[tag=ch.actor] run return 0
execute if entity @e[tag=ch.current,scores={ch_state=3},limit=1] if score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run return run function chess:ui/promotion
function chess:ui/begin
data modify storage chess:ui phase set value "等待对手行棋。"
execute unless entity @e[tag=ch.current,scores={ch_bot=0},limit=1] run data modify storage chess:ui phase set value "等待电脑行棋。"
execute if score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run data modify storage chess:ui phase set value "轮到你行棋。"
execute if entity @e[tag=ch.current,scores={ch_state=2},limit=1] run data modify storage chess:ui phase set value "棋子移动动画中，请稍候。"
execute if entity @e[tag=ch.current,scores={ch_state=3},limit=1] run data modify storage chess:ui phase set value "等待对手选择升变棋子。"
execute if entity @e[tag=ch.current,scores={ch_state=4},limit=1] run data modify storage chess:ui phase set value "本局正在结算。"
execute if entity @e[tag=ch.current,scores={ch_state=1,ch_undo=0},limit=1] run function chess:ui/button {code:6,label:"悔棋",color:"yellow"}
execute if entity @e[tag=ch.current,scores={ch_state=1},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_undo unless entity @e[tag=ch.current,scores={ch_undo=0},limit=1] run function chess:ui/button {code:7,label:"同意悔棋",color:"green"}
execute if entity @e[tag=ch.current,scores={ch_state=1},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_undo unless entity @e[tag=ch.current,scores={ch_undo=0},limit=1] run function chess:ui/button {code:8,label:"拒绝悔棋",color:"gray"}
execute if entity @e[tag=ch.current,scores={ch_state=1,ch_draw=0},limit=1] run function chess:ui/button {code:2,label:"和棋",color:"yellow"}
execute if entity @e[tag=ch.current,scores={ch_state=1,ch_draw=1},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run function chess:ui/button {code:3,label:"接受和棋",color:"green"}
execute if entity @e[tag=ch.current,scores={ch_state=1,ch_draw=-1},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run function chess:ui/button {code:3,label:"接受和棋",color:"green"}
execute if entity @e[tag=ch.current,scores={ch_state=1,ch_draw=1},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run function chess:ui/button {code:4,label:"拒绝和棋",color:"gray"}
execute if entity @e[tag=ch.current,scores={ch_state=1,ch_draw=-1},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run function chess:ui/button {code:4,label:"拒绝和棋",color:"gray"}
execute if entity @e[tag=ch.current,scores={ch_state=1..3},limit=1] run function chess:ui/button {code:9,label:"认输",color:"red"}
execute if entity @e[tag=ch.current,scores={ch_state=1},limit=1] if score @s ch_side = @e[tag=ch.current,limit=1] ch_turn if entity @e[tag=ch.current,scores={ch_half=100..},limit=1] run function chess:ui/button {code:5,label:"认领规则和棋",color:"aqua"}
execute if entity @e[tag=ch.current,scores={ch_state=1,ch_half=..99,ch_repetition=3..},limit=1] if score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run function chess:ui/button {code:5,label:"认领规则和棋",color:"aqua"}
execute if entity @e[tag=ch.current,scores={ch_state=1},limit=1] unless entity @e[tag=ch.current,scores={ch_undo=0},limit=1] if score @s ch_side = @e[tag=ch.current,limit=1] ch_undo run data modify storage chess:ui phase set value "已申请悔棋，等待回应。"
execute if entity @e[tag=ch.current,scores={ch_state=1},limit=1] unless entity @e[tag=ch.current,scores={ch_undo=0},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_undo run data modify storage chess:ui phase set value "对手申请悔棋。"
execute if entity @e[tag=ch.current,scores={ch_state=1},limit=1] unless entity @e[tag=ch.current,scores={ch_draw=0},limit=1] if score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run data modify storage chess:ui phase set value "已提出和棋，等待回应。"
execute if entity @e[tag=ch.current,scores={ch_state=1},limit=1] unless entity @e[tag=ch.current,scores={ch_draw=0},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run data modify storage chess:ui phase set value "对手提出和棋。"
function chess:ui/show with storage chess:ui
tag @a[tag=ch.actor] remove ch.actor
''')
put("ui/quick", '''
function chess:input/context
execute unless entity @s[tag=ch.actor] run return 0
execute if score #ui_tool ch_ctx matches 1 if entity @e[tag=ch.current,scores={ch_state=1..3},limit=1] run return run function chess:ui/resign
execute if entity @e[tag=ch.current,scores={ch_state=3},limit=1] if score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run return run function chess:ui/promotion
execute unless entity @e[tag=ch.current,scores={ch_state=1},limit=1] run return run function chess:ui/open
execute unless score #ui_tool ch_ctx matches 2 unless score #ui_tool ch_ctx matches 6 run return run function chess:ui/open
function chess:ui/begin
execute if score #ui_tool ch_ctx matches 6 run function chess:ui/undo_buttons
execute if score #ui_tool ch_ctx matches 2 run function chess:ui/draw_buttons
function chess:ui/show with storage chess:ui
tag @a[tag=ch.actor] remove ch.actor
''')
put("ui/resign", '''
# 认输在行棋、动画、升变阶段均可使用；始终经过确认按钮。
function chess:ui/begin
data modify storage chess:ui phase set value "确认认输？"
function chess:ui/button {code:1,label:"确认认输",color:"red"}
function chess:ui/show with storage chess:ui
tag @a[tag=ch.actor] remove ch.actor
''')
put("ui/undo_buttons", '''
data modify storage chess:ui phase set value "悔棋"
execute if entity @e[tag=ch.current,scores={ch_undo=0},limit=1] run function chess:ui/button {code:6,label:"申请悔棋",color:"yellow"}
execute unless entity @e[tag=ch.current,scores={ch_undo=0},limit=1] if score @s ch_side = @e[tag=ch.current,limit=1] ch_undo run data modify storage chess:ui phase set value "悔棋申请已发出，等待对手回应。"
execute unless entity @e[tag=ch.current,scores={ch_undo=0},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_undo run function chess:ui/button {code:7,label:"同意悔棋",color:"green"}
execute unless entity @e[tag=ch.current,scores={ch_undo=0},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_undo run function chess:ui/button {code:8,label:"拒绝悔棋",color:"gray"}
''')
put("ui/draw_buttons", '''
data modify storage chess:ui phase set value "和棋"
execute if entity @e[tag=ch.current,scores={ch_draw=0},limit=1] run function chess:ui/button {code:2,label:"提出和棋",color:"yellow"}
execute unless entity @e[tag=ch.current,scores={ch_draw=0},limit=1] if score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run data modify storage chess:ui phase set value "和棋申请已发出，等待对手回应。"
execute unless entity @e[tag=ch.current,scores={ch_draw=0},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run function chess:ui/button {code:3,label:"同意和棋",color:"green"}
execute unless entity @e[tag=ch.current,scores={ch_draw=0},limit=1] unless score @s ch_side = @e[tag=ch.current,limit=1] ch_draw run function chess:ui/button {code:4,label:"拒绝和棋",color:"gray"}
execute if score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run function chess:ui/button {code:5,label:"认领规则和棋",color:"aqua"}
''')
put("ui/button", '''
$scoreboard players set #ui_code ch_ctx $(code)
scoreboard players operation #ui_code ch_ctx += #ui_base ch_ctx
execute store result storage chess:ui code int 1 run scoreboard players get #ui_code ch_ctx
$data modify storage chess:ui label set value "$(label)"
$data modify storage chess:ui color set value "$(color)"
function chess:ui/button_append with storage chess:ui
''')
put("ui/button_append", '''
$data modify storage chess:ui buttons append value {label:{text:"$(label)",color:"$(color)"},width:150,action:{type:"minecraft:run_command",command:"trigger ch_action set $(code)"}}
''')
panel = {
    "type": "minecraft:multi_action", "title": {"text": "国际象棋 · 对局面板", "color": "gold"},
    "body": [msg("$(phase)", "yellow")],
    "columns": 2, "actions": "__BUTTONS__", "exit_action": {"label": {"text": "返回棋盘"}}, "pause": False}
put("ui/show", '''
# multi_action 至少需要一个按钮；先分发，避免空列表导致宏整条命令解析失败。
execute if data storage chess:ui buttons[0] run return run function chess:ui/actions_show with storage chess:ui
function chess:ui/notice_show with storage chess:ui
''')
put("ui/actions_show", "$dialog show @s " + js(panel).replace('"__BUTTONS__"', '$(buttons)'))
notice = {"type": "minecraft:notice", "title": panel["title"],
          "body": panel["body"], "pause": False}
put("ui/notice_show", "$dialog show @s " + js(notice))
put("ui/promotion", '''
function chess:input/context
execute unless entity @s[tag=ch.actor] run return 0
execute unless entity @e[tag=ch.current,scores={ch_state=3},limit=1] run return 0
execute unless score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run return 0
function chess:ui/begin
function chess:ui/button {code:10,label:"升变为后",color:"gold"}
function chess:ui/button {code:11,label:"升变为车",color:"white"}
function chess:ui/button {code:12,label:"升变为象",color:"white"}
function chess:ui/button {code:13,label:"升变为马",color:"white"}
function chess:ui/button {code:9,label:"认输",color:"red"}
function chess:ui/promotion_show with storage chess:ui
tag @a[tag=ch.actor] remove ch.actor
''')
promotion = {"type": "minecraft:multi_action", "title": {"text": "国际象棋 · 兵的升变", "color": "gold"},
             "body": [msg("请选择升变棋子。")],
             "columns": 2, "actions": "__BUTTONS__", "exit_action": {"label": {"text": "稍后选择"}}, "pause": False}
put("ui/promotion_show", "$dialog show @s " + js(promotion).replace('"__BUTTONS__"', '$(buttons)'))

from build_chess_settings import build as build_settings
build_settings(ROOT)

sections = [
    ("人数与目标", "支持1～2名真人；仅1人开始时自动与电脑对局，2人时正常双人对局，四人桌和八人桌都可使用。双方各16枚棋子，白方先走。目标是将死对方的王，不能把自己的王置于被攻击的位置，也不能直接吃掉王。电脑有简单、普通、困难三种难度，可在设置中选择。"),
    ("右键走棋", "右键己方棋子选中，actionbar显示名称；再次右键另一枚己方棋子会切换选择。默认高亮选中格和全部合法落点，设置中可关闭可走格提示。再右键目标格或对方棋子，合法则移动或吃子并在聊天栏记录，非法则取消选择。被吃的棋子放在吃子者右侧。手持快捷栏最后一格的「对局菜单」按Q，可选择悔棋、和棋或认输。双人悔棋、求和须对手同意；悔棋撤回最后一步并恢复局面与时钟。人机练习直接同意，悔棋会撤回你最近一手及电脑回应；你尚未行棋时不能悔棋。"),
    ("普通走法", "王横竖斜走一格；后横竖斜走任意格；车横竖走；象斜走；马走日字且能跳子。兵向前一格，初始位置且路径为空时可前进两格；兵只斜前方吃子。除马以外，棋子不能越过其他棋子。坐标固定为a1～h8，白方右手边底角h1为浅格。"),
    ("王车易位", "王和对应的车都未走过、两者间无棋子、王当前未被将军，且王经过和到达的格子均未受攻击时，可以易位。选中王，点击其向车方向移动两格的落点；系统会同步移动车。车被攻击不影响易位。"),
    ("吃过路兵与升变", "对方兵从起始格一步前进两格、恰好经过己方相邻兵可吃的位置时，仅在紧接的下一手可吃过路兵；选中己方兵并点击对方兵经过的空格。兵到达最后一横行时必须升变为后、车、象或马，通过普通玩家可用的面板选择。"),
    ("胜负与和棋", "将死或对手认输获胜。无合法走法且未被将军是逼和；双方约定和棋、子力不足、五次重复、75回合无吃子或兵移动时自动和棋，末步将死优先。轮到自己时，可在面板认领当前局面三次重复或50回合无吃子和兵移动的和棋；系统会复验。结束5秒后返回大厅，保留终局棋面，直到切换游戏或开始新局。"),
    ("设置与计时", "大厅的同一设置页可即时选择配色、棋盘方向、黑白方分配、人机难度、可走格提示及每人无限制、5、10、15、20、25或30分钟。自行选边时坐到所选颜色一侧，人机对局由电脑执另一色；随机模式由系统分配黑白。开局自动安排对应一侧的座位，始终白方先走。计时显示在棋盘上方，只扣当前行棋方；升变等待计时，移动动画暂停计时，无加秒。超时一般判负；对手已无任何可能将死的局面则和棋。"),
    ("权限与中止", "正常游玩无需管理员权限。玩家离线会中止本场并返回大厅；/reload保留局面和时钟，旧面板请按Q重开。可用桌边结束投票中止。管理员可在桌旁执行 /function chess:admin/abort。"),
]
rules = {"type": "minecraft:notice", "title": {"text": "国际象棋 · 游戏规则", "color": "gold", "bold": True}, "body": [], "pause": False}
for title, content in sections:
    rules["body"].append({"type": "minecraft:plain_message", "width": 480, "contents": [{"text": title + "\n", "color": "aqua", "bold": True}, {"text": content, "color": "white"}]})
put("rules/show", "dialog show @a[tag=ct.rules_actor,limit=1] " + js(rules))

advancement = {"criteria": {"click": {"trigger": "minecraft:player_interacted_with_entity", "conditions": {"entity": [{"condition": "minecraft:entity_properties", "entity": "this", "predicate": {"minecraft:entity_type": "minecraft:interaction"}}, {"condition": "minecraft:entity_scores", "entity": "this", "scores": {"ch_sq": {"min": 0, "max": 63}}}]}}}, "rewards": {"function": "chess:input/click_dispatch"}}
adv_path = PACK / "data/chess/advancement/click_cell.json"
adv_path.parent.mkdir(parents=True, exist_ok=True)
adv_path.write_text(json.dumps(advancement, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

# 独立 GameTest 世界调用这些宏，检查所有 Dialog 的 codec 和动态模板。
sample_ui = {"phase": "轮到白方行棋。", "buttons": [{"label": {"text": "认输"}, "action": {"type": "minecraft:run_command", "command": "trigger ch_action set 101"}}], "code": 101, "label": "认输", "color": "red"}
checks = ["# 仅供独立 GameTest 世界使用，不加入生产 tick。", "say CHESS_DIALOGS_BEGIN", "data merge storage chess:ui " + js(sample_ui),
          "function chess:ui/show with storage chess:ui", "say CHESS_DIALOG_PANEL_COMPILED",
          'data modify storage chess:ui buttons set value []',
          'function chess:ui/show with storage chess:ui', 'say CHESS_DIALOG_NOTICE_COMPILED',
          'data modify storage chess:ui buttons set value ' + js(sample_ui['buttons']),
          "function chess:ui/promotion_show with storage chess:ui", "say CHESS_DIALOG_PROMOTION_COMPILED",
          "function chess:ui/button_append with storage chess:ui", "scoreboard players set #ui_setting_base ch_ctx 100000000"]
for name, values in [("DEFAULT", (0,0,0,0,10,2,1)), ("MINIMUM", (0,0,0,0,0,1,0)), ("MAXIMUM", (4,3,1,1,30,3,1))]:
    sample_settings = dict(zip(("board", "palette", "orient", "first", "time", "level", "hints"), values))
    sample_settings["close"] = 100000000
    checks += ["data merge storage chess:settings " + js(sample_settings), "function chess:settings/root", "say CHESS_DIALOG_SETTING_" + name + "_COMPILED"]
checks += ["function chess:rules/show", "say CHESS_DIALOG_RULES_COMPILED", "say CHESS_DIALOGS_END"]
(PACK / "tools/test_chess_dialogs.mcfunction").write_text("\n".join(checks) + "\n", encoding="utf-8")
print("Chess input / dialogs / settings / rules generated")
