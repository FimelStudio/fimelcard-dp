"""生成中国象棋输入、Dialog、桌内设置和规则，不修改规则引擎或公共牌桌。"""
from pathlib import Path
import json


PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / "data/xiangqi/function"


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
clear @s minecraft:paper[minecraft:custom_data~{xiangqi:{tool:1b}}]
execute store result storage xiangqi:input table int 1 run scoreboard players get @s xq_table
function xiangqi:input/give_tool with storage xiangqi:input
''')
put("input/give_tool", '''
$function xiangqi:input/place_tool {table:$(table),slot:8,action:0,name:"中国象棋 · 对局菜单",model:"minecraft:book"}
''')
put("input/place_tool", '''
$execute unless items entity @s hotbar.$(slot) * run return run item replace entity @s hotbar.$(slot) with minecraft:paper[minecraft:item_name="$(name)",minecraft:item_model="$(model)",minecraft:custom_data={xiangqi:{tool:1b,action:$(action),table:$(table)}},minecraft:max_stack_size=1]
$give @s minecraft:paper[minecraft:item_name="$(name)",minecraft:item_model="$(model)",minecraft:custom_data={xiangqi:{tool:1b,action:$(action),table:$(table)}},minecraft:max_stack_size=1]
''')
put("input/clear", '''
# 由 player/clear_state 调用；离座会使全部旧面板、旧设置窗口失效。
clear @s minecraft:paper[minecraft:custom_data~{xiangqi:{tool:1b}}]
scoreboard players reset @s xq_action
scoreboard players reset @s xq_settings
scoreboard players reset @s xq_drop
scoreboard players reset @s xq_seen
scoreboard players reset @s xq_ui_load
scoreboard players reset @s xq_ui_tmp
scoreboard players reset @s xq_set_table
scoreboard players reset @s xq_setnonce
scoreboard players reset @s xq_setepoch
scoreboard players reset @s xq_nonce
tag @s remove xq.actor
tag @s remove xq.clicker
tag @s remove xq.dropper
''')
put("input/tick", '''
# 精确消费 interaction 记录，最大延迟一刻；不靠“最近的格子”猜测点击目标。
execute as @e[type=minecraft:interaction,tag=xq.cell] if data entity @s interaction at @s run function xiangqi:input/cell
execute as @a[tag=xq.player,scores={xq_drop=1..}] at @s run function xiangqi:input/drop
execute as @a[tag=xq.player,scores={xq_action=1..}] at @s run function xiangqi:input/submit
execute as @a[scores={xq_settings=1..}] at @s run function xiangqi:settings/save
''')
put("input/click_dispatch", '''
# advancement 只恢复下次右键资格；输入在 tick 中读该格记录的最后右键者。
# 这样不会依赖 advancement 触发与 interaction NBT 写入的先后顺序。
advancement revoke @s only xiangqi:click_cell
''')
put("input/cell", '''
scoreboard players operation #ui_click_table xq_ctx = @s ct_id
scoreboard players operation #target xq_ctx = @s xq_sq
tag @a[tag=xq.actor] remove xq.actor
execute on target if entity @s[type=minecraft:player] run function xiangqi:input/cell_player
data remove entity @s interaction
tag @a[tag=xq.actor] remove xq.actor
''')
put("input/cell_player", '''
execute unless entity @s[tag=ct.player,tag=xq.player] run return 0
execute unless score @s ct_id = #ui_click_table xq_ctx run return 0
execute unless score @s xq_table = #ui_click_table xq_ctx run return 0
function xiangqi:input/context
execute unless entity @s[tag=xq.actor] run return 0
execute unless entity @e[tag=xq.current,scores={xq_state=1},limit=1] run return 0
execute as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/click
''')
put("input/context", '''
# 玩家入口同时核验通用归属、游戏归属与本桌控制器。
tag @a[tag=xq.actor] remove xq.actor
tag @e[tag=xq.current] remove xq.current
execute unless entity @s[tag=ct.player,tag=xq.player] run return 0
execute unless score @s ct_id = @s xq_table run return 0
scoreboard players operation #ui_table xq_ctx = @s xq_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=xq.controller,scores={ct_game=13,ct_state=1}] if score @s ct_id = #ui_table xq_ctx run tag @s add xq.current
execute unless entity @e[tag=xq.current,limit=1] run return 0
tag @s add xq.actor
execute as @e[tag=xq.current,limit=1] at @s run function xiangqi:system/context
''')
put("input/drop", '''
scoreboard players set @s xq_drop 0
tag @a[tag=xq.dropper] remove xq.dropper
tag @s add xq.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:paper[minecraft:custom_data~{xiangqi:{tool:1b}}] run function xiangqi:input/check_drop
tag @s remove xq.dropper
''')
put("input/check_drop", '''
scoreboard players set #ui_drop_owner xq_ctx 0
execute on origin if entity @s[tag=xq.dropper,tag=xq.player] run scoreboard players set #ui_drop_owner xq_ctx 1
execute unless score #ui_drop_owner xq_ctx matches 1 run return 0
scoreboard players set #ui_tool xq_ctx 0
execute store result score #ui_tool xq_ctx run data get entity @s Item.components."minecraft:custom_data".xiangqi.action
kill @s
execute as @a[tag=xq.dropper,limit=1] run function xiangqi:input/give
execute as @a[tag=xq.dropper,limit=1] at @s run function xiangqi:ui/quick
''')
put("input/invalid", '''
tellraw @s {text:"[中国象棋] 这个窗口已过期或当前操作不可用，请按Q重新打开面板。",color:"yellow"}
tag @a[tag=xq.actor] remove xq.actor
''')
put("input/submit", '''
# epoch*100 + 动作。回合、阶段或重载变化后，旧窗口不能提交操作。
scoreboard players operation @s xq_ui_tmp = @s xq_action
scoreboard players set @s xq_action 0
scoreboard players enable @s xq_action
function xiangqi:input/context
execute unless entity @s[tag=xq.actor] run return run function xiangqi:input/invalid
execute unless score @s xq_ui_load = #ui_load xq_ctx run return run function xiangqi:input/invalid
scoreboard players set #ui_100 xq_ctx 100
scoreboard players operation #ui_epoch xq_ctx = @s xq_ui_tmp
scoreboard players operation #ui_epoch xq_ctx /= #ui_100 xq_ctx
execute unless score #ui_epoch xq_ctx = @s xq_seen run return run function xiangqi:input/invalid
execute unless score #ui_epoch xq_ctx = @e[tag=xq.current,limit=1] xq_epoch run return run function xiangqi:input/invalid
scoreboard players operation #ui_action xq_ctx = @s xq_ui_tmp
scoreboard players operation #ui_action xq_ctx %= #ui_100 xq_ctx
execute unless score #ui_action xq_ctx matches 1..9 run return run function xiangqi:input/invalid
execute if score #ui_action xq_ctx matches 5 run return run function xiangqi:input/invalid
execute if score #ui_action xq_ctx matches 1 unless entity @e[tag=xq.current,scores={xq_state=1..2},limit=1] run return run function xiangqi:input/invalid
execute if score #ui_action xq_ctx matches 9 unless entity @e[tag=xq.current,scores={xq_state=1..2},limit=1] run return run function xiangqi:input/invalid
execute if score #ui_action xq_ctx matches 2..8 unless entity @e[tag=xq.current,scores={xq_state=1},limit=1] run return run function xiangqi:input/invalid
execute if score #ui_action xq_ctx matches 1 as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/resign
execute if score #ui_action xq_ctx matches 2 as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/offer_draw
execute if score #ui_action xq_ctx matches 3 as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/accept_draw
execute if score #ui_action xq_ctx matches 4 as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/decline_draw
execute if score #ui_action xq_ctx matches 6 as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/offer_undo
execute if score #ui_action xq_ctx matches 7 as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/accept_undo
execute if score #ui_action xq_ctx matches 8 as @e[tag=xq.current,limit=1] at @s run function xiangqi:game/decline_undo
execute if score #ui_action xq_ctx matches 9 run function xiangqi:ui/resign
tag @a[tag=xq.actor] remove xq.actor
''')
put("ui/refresh", '''
# 更新可用输入，不逐刻强制弹窗。
function xiangqi:system/context
scoreboard players set @a[tag=xq.audience] xq_action 0
scoreboard players enable @a[tag=xq.audience] xq_action
''')
put("ui/begin", '''
scoreboard players operation @s xq_seen = @e[tag=xq.current,limit=1] xq_epoch
scoreboard players operation @s xq_ui_load = #ui_load xq_ctx
scoreboard players operation #ui_base xq_ctx = @s xq_seen
scoreboard players set #ui_100 xq_ctx 100
scoreboard players operation #ui_base xq_ctx *= #ui_100 xq_ctx
data modify storage xiangqi:ui buttons set value []
scoreboard players set @s xq_action 0
scoreboard players enable @s xq_action
''')
put("ui/open", '''
function xiangqi:input/context
execute unless entity @s[tag=xq.actor] run return 0
function xiangqi:ui/begin
data modify storage xiangqi:ui phase set value "等待对手行棋。"
execute unless entity @e[tag=xq.current,scores={xq_bot=0},limit=1] run data modify storage xiangqi:ui phase set value "等待电脑行棋。"
execute if score @s xq_side = @e[tag=xq.current,limit=1] xq_turn run data modify storage xiangqi:ui phase set value "轮到你行棋。"
execute if entity @e[tag=xq.current,scores={xq_state=2},limit=1] run data modify storage xiangqi:ui phase set value "棋子移动动画中，请稍候。"
execute if entity @e[tag=xq.current,scores={xq_state=4},limit=1] run data modify storage xiangqi:ui phase set value "本局正在结算。"
execute if entity @e[tag=xq.current,scores={xq_state=1,xq_undo=0},limit=1] run function xiangqi:ui/button {code:6,label:"悔棋",color:"yellow"}
execute if entity @e[tag=xq.current,scores={xq_state=1},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_undo unless entity @e[tag=xq.current,scores={xq_undo=0},limit=1] run function xiangqi:ui/button {code:7,label:"同意悔棋",color:"green"}
execute if entity @e[tag=xq.current,scores={xq_state=1},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_undo unless entity @e[tag=xq.current,scores={xq_undo=0},limit=1] run function xiangqi:ui/button {code:8,label:"拒绝悔棋",color:"gray"}
execute if entity @e[tag=xq.current,scores={xq_state=1,xq_draw=0},limit=1] run function xiangqi:ui/button {code:2,label:"和棋",color:"yellow"}
execute if entity @e[tag=xq.current,scores={xq_state=1,xq_draw=1},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run function xiangqi:ui/button {code:3,label:"接受和棋",color:"green"}
execute if entity @e[tag=xq.current,scores={xq_state=1,xq_draw=-1},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run function xiangqi:ui/button {code:3,label:"接受和棋",color:"green"}
execute if entity @e[tag=xq.current,scores={xq_state=1,xq_draw=1},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run function xiangqi:ui/button {code:4,label:"拒绝和棋",color:"gray"}
execute if entity @e[tag=xq.current,scores={xq_state=1,xq_draw=-1},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run function xiangqi:ui/button {code:4,label:"拒绝和棋",color:"gray"}
execute if entity @e[tag=xq.current,scores={xq_state=1..2},limit=1] run function xiangqi:ui/button {code:9,label:"认输",color:"red"}
execute if entity @e[tag=xq.current,scores={xq_state=1},limit=1] unless entity @e[tag=xq.current,scores={xq_undo=0},limit=1] if score @s xq_side = @e[tag=xq.current,limit=1] xq_undo run data modify storage xiangqi:ui phase set value "已申请悔棋，等待回应。"
execute if entity @e[tag=xq.current,scores={xq_state=1},limit=1] unless entity @e[tag=xq.current,scores={xq_undo=0},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_undo run data modify storage xiangqi:ui phase set value "对手申请悔棋。"
execute if entity @e[tag=xq.current,scores={xq_state=1},limit=1] unless entity @e[tag=xq.current,scores={xq_draw=0},limit=1] if score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run data modify storage xiangqi:ui phase set value "已提出和棋，等待回应。"
execute if entity @e[tag=xq.current,scores={xq_state=1},limit=1] unless entity @e[tag=xq.current,scores={xq_draw=0},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run data modify storage xiangqi:ui phase set value "对手提出和棋。"
function xiangqi:ui/show with storage xiangqi:ui
tag @a[tag=xq.actor] remove xq.actor
''')
put("ui/quick", '''
function xiangqi:input/context
execute unless entity @s[tag=xq.actor] run return 0
execute if score #ui_tool xq_ctx matches 1 if entity @e[tag=xq.current,scores={xq_state=1..2},limit=1] run return run function xiangqi:ui/resign
execute unless entity @e[tag=xq.current,scores={xq_state=1},limit=1] run return run function xiangqi:ui/open
execute unless score #ui_tool xq_ctx matches 2 unless score #ui_tool xq_ctx matches 6 run return run function xiangqi:ui/open
function xiangqi:ui/begin
execute if score #ui_tool xq_ctx matches 6 run function xiangqi:ui/undo_buttons
execute if score #ui_tool xq_ctx matches 2 run function xiangqi:ui/draw_buttons
function xiangqi:ui/show with storage xiangqi:ui
tag @a[tag=xq.actor] remove xq.actor
''')
put("ui/resign", '''
# 认输在行棋和动画阶段均可使用；始终经过确认按钮。
function xiangqi:ui/begin
data modify storage xiangqi:ui phase set value "确认认输？"
function xiangqi:ui/button {code:1,label:"确认认输",color:"red"}
function xiangqi:ui/show with storage xiangqi:ui
tag @a[tag=xq.actor] remove xq.actor
''')
put("ui/undo_buttons", '''
data modify storage xiangqi:ui phase set value "悔棋"
execute if entity @e[tag=xq.current,scores={xq_undo=0},limit=1] run function xiangqi:ui/button {code:6,label:"申请悔棋",color:"yellow"}
execute unless entity @e[tag=xq.current,scores={xq_undo=0},limit=1] if score @s xq_side = @e[tag=xq.current,limit=1] xq_undo run data modify storage xiangqi:ui phase set value "悔棋申请已发出，等待对手回应。"
execute unless entity @e[tag=xq.current,scores={xq_undo=0},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_undo run function xiangqi:ui/button {code:7,label:"同意悔棋",color:"green"}
execute unless entity @e[tag=xq.current,scores={xq_undo=0},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_undo run function xiangqi:ui/button {code:8,label:"拒绝悔棋",color:"gray"}
''')
put("ui/draw_buttons", '''
data modify storage xiangqi:ui phase set value "和棋"
execute if entity @e[tag=xq.current,scores={xq_draw=0},limit=1] run function xiangqi:ui/button {code:2,label:"提出和棋",color:"yellow"}
execute unless entity @e[tag=xq.current,scores={xq_draw=0},limit=1] if score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run data modify storage xiangqi:ui phase set value "和棋申请已发出，等待对手回应。"
execute unless entity @e[tag=xq.current,scores={xq_draw=0},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run function xiangqi:ui/button {code:3,label:"同意和棋",color:"green"}
execute unless entity @e[tag=xq.current,scores={xq_draw=0},limit=1] unless score @s xq_side = @e[tag=xq.current,limit=1] xq_draw run function xiangqi:ui/button {code:4,label:"拒绝和棋",color:"gray"}
''')
put("ui/button", '''
$scoreboard players set #ui_code xq_ctx $(code)
scoreboard players operation #ui_code xq_ctx += #ui_base xq_ctx
execute store result storage xiangqi:ui code int 1 run scoreboard players get #ui_code xq_ctx
$data modify storage xiangqi:ui label set value "$(label)"
$data modify storage xiangqi:ui color set value "$(color)"
function xiangqi:ui/button_append with storage xiangqi:ui
''')
put("ui/button_append", '''
$data modify storage xiangqi:ui buttons append value {label:{text:"$(label)",color:"$(color)"},width:150,action:{type:"minecraft:run_command",command:"trigger xq_action set $(code)"}}
''')
panel = {
    "type": "minecraft:multi_action", "title": {"text": "中国象棋 · 对局面板", "color": "gold"},
    "body": [msg("$(phase)", "yellow")],
    "columns": 2, "actions": "__BUTTONS__", "exit_action": {"label": {"text": "返回棋盘"}}, "pause": False}
put("ui/show", '''
# multi_action 至少需要一个按钮；先分发，避免空列表导致宏整条命令解析失败。
execute if data storage xiangqi:ui buttons[0] run return run function xiangqi:ui/actions_show with storage xiangqi:ui
function xiangqi:ui/notice_show with storage xiangqi:ui
''')
put("ui/actions_show", "$dialog show @s " + js(panel).replace('"__BUTTONS__"', '$(buttons)'))
notice = {"type": "minecraft:notice", "title": panel["title"],
          "body": panel["body"], "pause": False}
put("ui/notice_show", "$dialog show @s " + js(notice))
from build_xiangqi_settings import build as build_settings
build_settings(ROOT)

sections = [
    ("人数与目标", "支持1～2名玩家；一人开始自动对战电脑，设置中可选简单、普通、困难。两人时正常对弈。红方先行，双方各16枚棋子，目标是将死或困毙对方。"),
    ("操作", "右键己方棋子选中，再右键落点移动或吃子；选另一枚己方棋子会切换选择。可走点默认发光，可在设置关闭。被吃棋子放在吃子者右侧。手持最后一格的对局菜单按Q，可悔棋、和棋或认输；双人悔棋与和棋须对手同意，人机自动同意，悔棋退回到你上次行棋前。"),
    ("各子走法", "车直走，不可越子；马走日，受蹩马腿限制；炮移动同车，吃子须隔恰好一个炮架；相／象走田，受塞象眼限制且不能过河；仕／士斜走一格且不出九宫；帅／将直走一格且不出九宫；兵／卒过河前只前进一格，过河后可横走一格，不能后退。两将不得在无隔子的同一直线上照面，任何走法都不能使己方帅／将被吃。"),
    ("结束与和棋", "将死、困毙、对手超时或认输即获胜。双方同意、双方均无车马炮兵等进攻子力、连续120着（双方合计）未吃子时和棋；重复局面按本包简化规则处理：单方持续将军者判负，其他三次重复和棋，不裁定长捉、将军扣除等正式竞赛细则。结束5秒后返回大厅并保留终局棋面，重新开局或切换游戏才重摆。"),
    ("设置与计时", "单页点击设置立即生效；可调棋盘与棋子配色、方向、红黑方分配、人机难度、落点提示及每人无限制或5～30分钟计时。按座位选边或随机分配，开局自动坐到对应侧。只扣行棋方时间，移动动画暂停，无加秒。"),
    ("中止", "正常游玩无需管理员。玩家离线会中止本场。/reload保留棋局与时钟，旧菜单请按Q重开。管理员可在桌旁执行 /function xiangqi:admin/abort。"),
]
rules = {"type": "minecraft:notice", "title": {"text": "中国象棋 · 游戏规则", "color": "gold", "bold": True}, "body": [], "pause": False}
for title, content in sections:
    rules["body"].append({"type": "minecraft:plain_message", "width": 480, "contents": [{"text": title + "\n", "color": "aqua", "bold": True}, {"text": content, "color": "white"}]})
put("rules/show", "dialog show @a[tag=ct.rules_actor,limit=1] " + js(rules))

advancement = {"criteria": {"click": {"trigger": "minecraft:player_interacted_with_entity", "conditions": {"entity": [{"condition": "minecraft:entity_properties", "entity": "this", "predicate": {"minecraft:entity_type": "minecraft:interaction"}}, {"condition": "minecraft:entity_scores", "entity": "this", "scores": {"xq_sq": {"min": 0, "max": 89}}}]}}}, "rewards": {"function": "xiangqi:input/click_dispatch"}}
adv_path = PACK / "data/xiangqi/advancement/click_cell.json"
adv_path.parent.mkdir(parents=True, exist_ok=True)
adv_path.write_text(json.dumps(advancement, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

# 独立 GameTest 世界调用这些宏，检查所有 Dialog 的 codec 和动态模板。
sample_ui = {"phase": "轮到红方行棋。", "buttons": [{"label": {"text": "认输"}, "action": {"type": "minecraft:run_command", "command": "trigger xq_action set 101"}}], "code": 101, "label": "认输", "color": "red"}
checks = ["# 仅供独立 GameTest 世界使用，不加入生产 tick。", "say XIANGQI_DIALOGS_BEGIN", "data merge storage xiangqi:ui " + js(sample_ui),
          "function xiangqi:ui/show with storage xiangqi:ui", "say XIANGQI_DIALOG_PANEL_COMPILED",
          'data modify storage xiangqi:ui buttons set value []',
          'function xiangqi:ui/show with storage xiangqi:ui', 'say XIANGQI_DIALOG_NOTICE_COMPILED',
          'data modify storage xiangqi:ui buttons set value ' + js(sample_ui['buttons']),
          "function xiangqi:ui/button_append with storage xiangqi:ui", "scoreboard players set #ui_setting_base xq_ctx 100000000"]
for name, values in [("DEFAULT", (0,0,0,0,10,2,1)), ("MINIMUM", (0,0,0,0,0,1,0)), ("MAXIMUM", (4,3,1,1,30,3,1))]:
    sample_settings = dict(zip(("board", "palette", "orient", "first", "time", "level", "hints"), values))
    sample_settings["close"] = 100000000
    checks += ["data merge storage xiangqi:settings " + js(sample_settings), "function xiangqi:settings/root", "say XIANGQI_DIALOG_SETTING_" + name + "_COMPILED"]
checks += ["function xiangqi:rules/show", "say XIANGQI_DIALOG_RULES_COMPILED", "say XIANGQI_DIALOGS_END"]
(PACK / "tools/test_xiangqi_dialogs.mcfunction").write_text("\n".join(checks) + "\n", encoding="utf-8")
print("Xiangqi input / dialogs / settings / rules generated")
