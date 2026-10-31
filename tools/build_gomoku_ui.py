"""生成五子棋输入、Dialog、桌内设置和规则，不修改规则引擎或公共牌桌。"""
from pathlib import Path
import json


PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / "data/gomoku/function"


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
clear @s minecraft:paper[minecraft:custom_data~{gomoku:{tool:1b}}]
execute store result storage gomoku:input table int 1 run scoreboard players get @s gm_table
function gomoku:input/give_tool with storage gomoku:input
''')
put("input/give_tool", '''
$function gomoku:input/place_tool {table:$(table),slot:8,action:0,name:"五子棋 · 对局菜单",model:"minecraft:book"}
''')
put("input/place_tool", '''
$execute unless items entity @s hotbar.$(slot) * run return run item replace entity @s hotbar.$(slot) with minecraft:paper[minecraft:item_name="$(name)",minecraft:item_model="$(model)",minecraft:custom_data={gomoku:{tool:1b,action:$(action),table:$(table)}},minecraft:max_stack_size=1]
$give @s minecraft:paper[minecraft:item_name="$(name)",minecraft:item_model="$(model)",minecraft:custom_data={gomoku:{tool:1b,action:$(action),table:$(table)}},minecraft:max_stack_size=1]
''')
put("input/clear", '''
# 由 player/clear_state 调用；离座会使全部旧面板、旧设置窗口失效。
clear @s minecraft:paper[minecraft:custom_data~{gomoku:{tool:1b}}]
scoreboard players reset @s gm_action
scoreboard players reset @s gm_settings
scoreboard players reset @s gm_drop
scoreboard players reset @s gm_seen
scoreboard players reset @s gm_ui_load
scoreboard players reset @s gm_ui_tmp
scoreboard players reset @s gm_set_table
scoreboard players reset @s gm_setnonce
scoreboard players reset @s gm_setepoch
scoreboard players reset @s gm_nonce
scoreboard players reset @s gm_coord
scoreboard players reset @s gm_coordnonce
scoreboard players reset @s gm_coordepoch
scoreboard players reset @s gm_coordload
scoreboard players reset @s gm_coordtable
tag @s remove gm.actor
tag @s remove gm.clicker
tag @s remove gm.dropper
''')
put("input/tick", '''
# 精确消费 interaction 记录，最大延迟一刻；不靠“最近的格子”猜测点击目标。
execute as @e[type=minecraft:interaction,tag=gm.cell] if data entity @s interaction at @s run function gomoku:input/cell
execute as @a[tag=gm.player,scores={gm_drop=1..}] at @s run function gomoku:input/drop
execute as @a[tag=gm.player,scores={gm_action=1..}] at @s run function gomoku:input/submit
execute as @a[scores={gm_settings=1..}] at @s run function gomoku:settings/save
execute as @a[tag=gm.player,scores={gm_coord=1..}] at @s run function gomoku:input/coordinate_submit
''')
put("input/click_dispatch", '''
# advancement 只恢复下次右键资格；输入在 tick 中读该格记录的最后右键者。
# 这样不会依赖 advancement 触发与 interaction NBT 写入的先后顺序。
advancement revoke @s only gomoku:click_cell
''')
put("input/cell", '''
scoreboard players operation #ui_click_table gm_ctx = @s ct_id
scoreboard players operation #target gm_ctx = @s gm_sq
tag @a[tag=gm.actor] remove gm.actor
execute on target if entity @s[type=minecraft:player] run function gomoku:input/cell_player
data remove entity @s interaction
tag @a[tag=gm.actor] remove gm.actor
''')
put("input/cell_player", '''
execute unless entity @s[tag=ct.player,tag=gm.player] run return 0
execute unless score @s ct_id = #ui_click_table gm_ctx run return 0
execute unless score @s gm_table = #ui_click_table gm_ctx run return 0
function gomoku:input/context
execute unless entity @s[tag=gm.actor] run return 0
execute unless entity @e[tag=gm.current,scores={gm_state=1},limit=1] run return 0
execute as @e[tag=gm.current,limit=1] at @s run function gomoku:game/click
''')
put("input/context", '''
# 玩家入口同时核验通用归属、游戏归属与本桌控制器。
tag @a[tag=gm.actor] remove gm.actor
tag @e[tag=gm.current] remove gm.current
execute unless entity @s[tag=ct.player,tag=gm.player] run return 0
execute unless score @s ct_id = @s gm_table run return 0
scoreboard players operation #ui_table gm_ctx = @s gm_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=gm.controller,scores={ct_game=14,ct_state=1}] if score @s ct_id = #ui_table gm_ctx run tag @s add gm.current
execute unless entity @e[tag=gm.current,limit=1] run return 0
tag @s add gm.actor
execute as @e[tag=gm.current,limit=1] at @s run function gomoku:system/context
''')
put("input/drop", '''
scoreboard players set @s gm_drop 0
tag @a[tag=gm.dropper] remove gm.dropper
tag @s add gm.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:paper[minecraft:custom_data~{gomoku:{tool:1b}}] run function gomoku:input/check_drop
tag @s remove gm.dropper
''')
put("input/check_drop", '''
scoreboard players set #ui_drop_owner gm_ctx 0
execute on origin if entity @s[tag=gm.dropper,tag=gm.player] run scoreboard players set #ui_drop_owner gm_ctx 1
execute unless score #ui_drop_owner gm_ctx matches 1 run return 0
scoreboard players set #ui_tool gm_ctx 0
execute store result score #ui_tool gm_ctx run data get entity @s Item.components."minecraft:custom_data".gomoku.action
kill @s
execute as @a[tag=gm.dropper,limit=1] run function gomoku:input/give
execute as @a[tag=gm.dropper,limit=1] at @s run function gomoku:ui/quick
''')
put("input/invalid", '''
tellraw @s {text:"[五子棋] 这个窗口已过期或当前操作不可用，请按Q重新打开面板。",color:"yellow"}
tag @a[tag=gm.actor] remove gm.actor
''')
put("input/submit", '''
# epoch*100 + 动作。回合、阶段或重载变化后，旧窗口不能提交操作。
scoreboard players operation @s gm_ui_tmp = @s gm_action
scoreboard players set @s gm_action 0
scoreboard players enable @s gm_action
function gomoku:input/context
execute unless entity @s[tag=gm.actor] run return run function gomoku:input/invalid
execute unless score @s gm_ui_load = #ui_load gm_ctx run return run function gomoku:input/invalid
scoreboard players set #ui_100 gm_ctx 100
scoreboard players operation #ui_epoch gm_ctx = @s gm_ui_tmp
scoreboard players operation #ui_epoch gm_ctx /= #ui_100 gm_ctx
execute unless score #ui_epoch gm_ctx = @s gm_seen run return run function gomoku:input/invalid
execute unless score #ui_epoch gm_ctx = @e[tag=gm.current,limit=1] gm_epoch run return run function gomoku:input/invalid
scoreboard players operation #ui_action gm_ctx = @s gm_ui_tmp
scoreboard players operation #ui_action gm_ctx %= #ui_100 gm_ctx
execute unless score #ui_action gm_ctx matches 1..10 run return run function gomoku:input/invalid
execute if score #ui_action gm_ctx matches 5 run return run function gomoku:input/invalid
execute if score #ui_action gm_ctx matches 1 unless entity @e[tag=gm.current,scores={gm_state=1..2},limit=1] run return run function gomoku:input/invalid
execute if score #ui_action gm_ctx matches 9 unless entity @e[tag=gm.current,scores={gm_state=1..2},limit=1] run return run function gomoku:input/invalid
execute if score #ui_action gm_ctx matches 2..8 unless entity @e[tag=gm.current,scores={gm_state=1},limit=1] run return run function gomoku:input/invalid
execute if score #ui_action gm_ctx matches 1 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/resign
execute if score #ui_action gm_ctx matches 2 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/offer_draw
execute if score #ui_action gm_ctx matches 3 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/accept_draw
execute if score #ui_action gm_ctx matches 4 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/decline_draw
execute if score #ui_action gm_ctx matches 6 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/offer_undo
execute if score #ui_action gm_ctx matches 7 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/accept_undo
execute if score #ui_action gm_ctx matches 8 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/decline_undo
execute if score #ui_action gm_ctx matches 9 run function gomoku:ui/resign
execute if score #ui_action gm_ctx matches 10 run function gomoku:ui/coordinates
tag @a[tag=gm.actor] remove gm.actor
''')
put("ui/refresh", '''
# 更新可用输入，不逐刻强制弹窗。
function gomoku:system/context
scoreboard players set @a[tag=gm.audience] gm_action 0
scoreboard players enable @a[tag=gm.audience] gm_action
''')
put("ui/begin", '''
scoreboard players operation @s gm_seen = @e[tag=gm.current,limit=1] gm_epoch
scoreboard players operation @s gm_ui_load = #ui_load gm_ctx
scoreboard players operation #ui_base gm_ctx = @s gm_seen
scoreboard players set #ui_100 gm_ctx 100
scoreboard players operation #ui_base gm_ctx *= #ui_100 gm_ctx
data modify storage gomoku:ui buttons set value []
scoreboard players set @s gm_action 0
scoreboard players enable @s gm_action
''')
put("ui/open", '''
function gomoku:input/context
execute unless entity @s[tag=gm.actor] run return 0
function gomoku:ui/begin
data modify storage gomoku:ui phase set value "等待对手行棋。"
execute unless entity @e[tag=gm.current,scores={gm_bot=0},limit=1] run data modify storage gomoku:ui phase set value "等待电脑行棋。"
execute if score @s gm_side = @e[tag=gm.current,limit=1] gm_turn run data modify storage gomoku:ui phase set value "轮到你行棋。"
execute if entity @e[tag=gm.current,scores={gm_state=2},limit=1] run data modify storage gomoku:ui phase set value "棋子移动动画中，请稍候。"
execute if entity @e[tag=gm.current,scores={gm_state=4},limit=1] run data modify storage gomoku:ui phase set value "本局正在结算。"
execute if entity @e[tag=gm.current,scores={gm_state=1,gm_undo=0},limit=1] run function gomoku:ui/button {code:6,label:"悔棋",color:"yellow"}
execute if entity @e[tag=gm.current,scores={gm_state=1},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_undo unless entity @e[tag=gm.current,scores={gm_undo=0},limit=1] run function gomoku:ui/button {code:7,label:"同意悔棋",color:"green"}
execute if entity @e[tag=gm.current,scores={gm_state=1},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_undo unless entity @e[tag=gm.current,scores={gm_undo=0},limit=1] run function gomoku:ui/button {code:8,label:"拒绝悔棋",color:"gray"}
execute if entity @e[tag=gm.current,scores={gm_state=1,gm_draw=0},limit=1] run function gomoku:ui/button {code:2,label:"和棋",color:"yellow"}
execute if entity @e[tag=gm.current,scores={gm_state=1,gm_draw=1},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_draw run function gomoku:ui/button {code:3,label:"接受和棋",color:"green"}
execute if entity @e[tag=gm.current,scores={gm_state=1,gm_draw=-1},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_draw run function gomoku:ui/button {code:3,label:"接受和棋",color:"green"}
execute if entity @e[tag=gm.current,scores={gm_state=1,gm_draw=1},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_draw run function gomoku:ui/button {code:4,label:"拒绝和棋",color:"gray"}
execute if entity @e[tag=gm.current,scores={gm_state=1,gm_draw=-1},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_draw run function gomoku:ui/button {code:4,label:"拒绝和棋",color:"gray"}
execute if entity @e[tag=gm.current,scores={gm_state=1..2},limit=1] run function gomoku:ui/button {code:9,label:"认输",color:"red"}
execute if entity @e[tag=gm.current,scores={gm_state=1},limit=1] if score @s gm_side = @e[tag=gm.current,limit=1] gm_turn run function gomoku:ui/button {code:10,label:"坐标落子",color:"aqua"}
execute if entity @e[tag=gm.current,scores={gm_state=1},limit=1] unless entity @e[tag=gm.current,scores={gm_undo=0},limit=1] if score @s gm_side = @e[tag=gm.current,limit=1] gm_undo run data modify storage gomoku:ui phase set value "已申请悔棋，等待回应。"
execute if entity @e[tag=gm.current,scores={gm_state=1},limit=1] unless entity @e[tag=gm.current,scores={gm_undo=0},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_undo run data modify storage gomoku:ui phase set value "对手申请悔棋。"
execute if entity @e[tag=gm.current,scores={gm_state=1},limit=1] unless entity @e[tag=gm.current,scores={gm_draw=0},limit=1] if score @s gm_side = @e[tag=gm.current,limit=1] gm_draw run data modify storage gomoku:ui phase set value "已提出和棋，等待回应。"
execute if entity @e[tag=gm.current,scores={gm_state=1},limit=1] unless entity @e[tag=gm.current,scores={gm_draw=0},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_draw run data modify storage gomoku:ui phase set value "对手提出和棋。"
function gomoku:ui/show with storage gomoku:ui
tag @a[tag=gm.actor] remove gm.actor
''')
put("ui/quick", '''
function gomoku:input/context
execute unless entity @s[tag=gm.actor] run return 0
execute if score #ui_tool gm_ctx matches 1 if entity @e[tag=gm.current,scores={gm_state=1..2},limit=1] run return run function gomoku:ui/resign
execute unless entity @e[tag=gm.current,scores={gm_state=1},limit=1] run return run function gomoku:ui/open
execute unless score #ui_tool gm_ctx matches 2 unless score #ui_tool gm_ctx matches 6 run return run function gomoku:ui/open
function gomoku:ui/begin
execute if score #ui_tool gm_ctx matches 6 run function gomoku:ui/undo_buttons
execute if score #ui_tool gm_ctx matches 2 run function gomoku:ui/draw_buttons
function gomoku:ui/show with storage gomoku:ui
tag @a[tag=gm.actor] remove gm.actor
''')
put("ui/resign", '''
# 认输在行棋和动画阶段均可使用；始终经过确认按钮。
function gomoku:ui/begin
data modify storage gomoku:ui phase set value "确认认输？"
function gomoku:ui/button {code:1,label:"确认认输",color:"red"}
function gomoku:ui/show with storage gomoku:ui
tag @a[tag=gm.actor] remove gm.actor
''')
put("ui/undo_buttons", '''
data modify storage gomoku:ui phase set value "悔棋"
execute if entity @e[tag=gm.current,scores={gm_undo=0},limit=1] run function gomoku:ui/button {code:6,label:"申请悔棋",color:"yellow"}
execute unless entity @e[tag=gm.current,scores={gm_undo=0},limit=1] if score @s gm_side = @e[tag=gm.current,limit=1] gm_undo run data modify storage gomoku:ui phase set value "悔棋申请已发出，等待对手回应。"
execute unless entity @e[tag=gm.current,scores={gm_undo=0},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_undo run function gomoku:ui/button {code:7,label:"同意悔棋",color:"green"}
execute unless entity @e[tag=gm.current,scores={gm_undo=0},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_undo run function gomoku:ui/button {code:8,label:"拒绝悔棋",color:"gray"}
''')
put("ui/draw_buttons", '''
data modify storage gomoku:ui phase set value "和棋"
execute if entity @e[tag=gm.current,scores={gm_draw=0},limit=1] run function gomoku:ui/button {code:2,label:"提出和棋",color:"yellow"}
execute unless entity @e[tag=gm.current,scores={gm_draw=0},limit=1] if score @s gm_side = @e[tag=gm.current,limit=1] gm_draw run data modify storage gomoku:ui phase set value "和棋申请已发出，等待对手回应。"
execute unless entity @e[tag=gm.current,scores={gm_draw=0},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_draw run function gomoku:ui/button {code:3,label:"同意和棋",color:"green"}
execute unless entity @e[tag=gm.current,scores={gm_draw=0},limit=1] unless score @s gm_side = @e[tag=gm.current,limit=1] gm_draw run function gomoku:ui/button {code:4,label:"拒绝和棋",color:"gray"}
''')
put("ui/button", '''
$scoreboard players set #ui_code gm_ctx $(code)
scoreboard players operation #ui_code gm_ctx += #ui_base gm_ctx
execute store result storage gomoku:ui code int 1 run scoreboard players get #ui_code gm_ctx
$data modify storage gomoku:ui label set value "$(label)"
$data modify storage gomoku:ui color set value "$(color)"
function gomoku:ui/button_append with storage gomoku:ui
''')
put("ui/button_append", '''
$data modify storage gomoku:ui buttons append value {label:{text:"$(label)",color:"$(color)"},width:150,action:{type:"minecraft:run_command",command:"trigger gm_action set $(code)"}}
''')
panel = {
    "type": "minecraft:multi_action", "title": {"text": "五子棋 · 对局面板", "color": "gold"},
    "body": [msg("$(phase)", "yellow")],
    "columns": 2, "actions": "__BUTTONS__", "exit_action": {"label": {"text": "返回棋盘"}}, "pause": False}
put("ui/show", '''
# multi_action 至少需要一个按钮；先分发，避免空列表导致宏整条命令解析失败。
execute if data storage gomoku:ui buttons[0] run return run function gomoku:ui/actions_show with storage gomoku:ui
function gomoku:ui/notice_show with storage gomoku:ui
''')
put("ui/actions_show", "$dialog show @s " + js(panel).replace('"__BUTTONS__"', '$(buttons)'))
notice = {"type": "minecraft:notice", "title": panel["title"],
          "body": panel["body"], "pause": False}
put("ui/notice_show", "$dialog show @s " + js(notice))

put('ui/coordinates', '''
function gomoku:input/context
execute unless entity @s[tag=gm.actor] run return 0
execute unless entity @e[tag=gm.current,scores={gm_state=1},limit=1] run return 0
execute unless score @s gm_side = @e[tag=gm.current,limit=1] gm_turn run return 0
# 四位nonce + 行 + 0 + 列；行列1～19的十进制串无歧义，最长九位。
execute if score #coord_serial gm_ctx matches 9999.. run scoreboard players add #ui_load gm_ctx 1
execute unless score #coord_serial gm_ctx matches 999..9998 run scoreboard players set #coord_serial gm_ctx 999
scoreboard players add #coord_serial gm_ctx 1
scoreboard players operation @s gm_coordnonce = #coord_serial gm_ctx
scoreboard players operation @s gm_coordepoch = @e[tag=gm.current,limit=1] gm_epoch
scoreboard players operation @s gm_coordload = #ui_load gm_ctx
scoreboard players operation @s gm_coordtable = @s gm_table
scoreboard players set @s gm_coord 0
scoreboard players enable @s gm_coord
execute store result storage gomoku:coordinates nonce int 1 run scoreboard players get @s gm_coordnonce
execute store result storage gomoku:coordinates size int 1 run scoreboard players get @e[tag=gm.current,limit=1] gm_size
data modify storage gomoku:coordinates row set value "$(row)"
data modify storage gomoku:coordinates col set value "$(col)"
function gomoku:ui/coordinates_show with storage gomoku:coordinates
tag @a[tag=gm.actor] remove gm.actor
''')
coordinate_dialog = {
    'type':'minecraft:confirmation','title':{'text':'五子棋 · 坐标落子','color':'gold'},
    'body':[msg('列从黑方视角左到右，行从黑方一侧向对面。')],
    'inputs':[{'type':'minecraft:number_range','key':'row','label':{'text':'行'},'start':1,'end':'__SIZE__','step':1,'initial':1,'width':300},
              {'type':'minecraft:number_range','key':'col','label':{'text':'列（A=1，B=2……）'},'start':1,'end':'__SIZE__','step':1,'initial':1,'width':300}],
    'yes':{'label':{'text':'落子','color':'green'},'action':{'type':'minecraft:dynamic/run_command','template':'trigger gm_coord set $(nonce)$(row)0$(col)'}},
    'no':{'label':{'text':'取消'}},'pause':False}
put('ui/coordinates_show','$dialog show @s '+js(coordinate_dialog).replace('"__SIZE__"','$(size)'))
coordinate_submit='''
scoreboard players operation #coord_input gm_ctx = @s gm_coord
scoreboard players reset @s gm_coord
function gomoku:input/context
execute unless entity @s[tag=gm.actor] run return run function gomoku:input/invalid
execute unless score @s gm_coordload = #ui_load gm_ctx run return run function gomoku:input/invalid
execute unless score @s gm_coordtable = @s gm_table run return run function gomoku:input/invalid
execute unless score @s gm_coordepoch = @e[tag=gm.current,limit=1] gm_epoch run return run function gomoku:input/invalid
execute unless entity @e[tag=gm.current,scores={gm_state=1},limit=1] run return run function gomoku:input/invalid
execute unless score @s gm_side = @e[tag=gm.current,limit=1] gm_turn run return run function gomoku:input/invalid
execute unless score @s gm_coordnonce matches 1000..9999 run return run function gomoku:input/invalid
scoreboard players set #coord_suffix gm_ctx -1
'''.strip().splitlines()
for factor in (1000,10000,100000):
    coordinate_submit += [f'scoreboard players set #coord_factor gm_ctx {factor}',
        'scoreboard players operation #coord_nonce gm_ctx = #coord_input gm_ctx',
        'scoreboard players operation #coord_nonce gm_ctx /= #coord_factor gm_ctx',
        'execute if score #coord_nonce gm_ctx = @s gm_coordnonce run scoreboard players operation #coord_suffix gm_ctx = #coord_input gm_ctx',
        'execute if score #coord_nonce gm_ctx = @s gm_coordnonce run scoreboard players operation #coord_suffix gm_ctx %= #coord_factor gm_ctx']
coordinate_submit += ['scoreboard players set @s gm_coordnonce 0', 'scoreboard players set #target gm_ctx -1']
for row in range(1,20):
    for col in range(1,20):
        coordinate_submit.append(f'execute if score #coord_suffix gm_ctx matches {row}0{col} run scoreboard players set #target gm_ctx {(row-1)*19+col-1}')
coordinate_submit += ['execute unless score #target gm_ctx matches 0..360 run return run function gomoku:input/invalid',
    'execute as @e[tag=gm.current,limit=1] at @s run function gomoku:game/coordinate_move',
    'tag @a[tag=gm.actor] remove gm.actor']
put('input/coordinate_submit','\n'.join(coordinate_submit))
put('game/coordinate_move','''
function gomoku:game/actor_guard
execute unless score #actor_ok gm_ctx matches 1 run return 0
execute unless score @s gm_state matches 1 run return 0
execute unless score @e[tag=gm.actor,limit=1] gm_side = @s gm_turn run return 0
scoreboard players operation #to gm_ctx = #target gm_ctx
function gomoku:engine/check_move
execute unless score #legal gm_ctx matches 1 run return run function gomoku:game/illegal
function gomoku:game/snapshot
function gomoku:engine/try_move
''')
from build_gomoku_settings import build as build_settings
build_settings(ROOT)

sections = [
    ("人数与目标", "支持1～2名玩家；单人自动匹配电脑，设置可选简单、普通、困难。黑方先行，在横、竖或斜线上连成五枚同色棋子即获胜，六枚及以上长连同样获胜。暂无禁手。棋盘支持13×13、15×15、19×19，默认15×15。"),
    ("落子", "右键空交点落子。设置可开启同一交点右键两次确认；改点会转移预选。手持快捷栏最后一格的对局菜单按Q，可打开坐标落子，按行列精确选点。动画期间锁定操作。最后一手标记与棋盘坐标均可关闭。"),
    ("对局菜单", "按Q可申请悔棋、和棋或认输。双人悔棋与和棋须对手同意，认输需本人确认。人机自动同意练习悔棋与和棋；悔棋退回你上一次落子前，连同电脑应手撤回，并恢复时钟。"),
    ("结束", "五连、对手超时或认输即获胜；棋盘下满仍无人五连，或双方同意则和棋。结束5秒后返回大厅并保留终局，重新开局或切换游戏时清空。"),
    ("设置与计时", "设置都在一页，点击立即生效。可调棋盘大小、配色、方向、黑白分配、人机难度、最后一手标记、坐标和落子确认。每人可选无限制或5～30分钟，仅扣当前落子方时间，落子动画暂停，无加秒。按座位选边或随机分配后自动换座，黑方始终先手。"),
    ("恢复与管理", "正常游玩无需管理员。玩家离线会中止本场。/reload保留棋局与时钟，旧菜单按Q重开。管理员可在桌旁执行 /function gomoku:admin/abort。"),
]
rules = {"type": "minecraft:notice", "title": {"text": "五子棋 · 游戏规则", "color": "gold", "bold": True}, "body": [], "pause": False}
for title, content in sections:
    rules["body"].append({"type": "minecraft:plain_message", "width": 480, "contents": [{"text": title + "\n", "color": "aqua", "bold": True}, {"text": content, "color": "white"}]})
put("rules/show", "dialog show @a[tag=ct.rules_actor,limit=1] " + js(rules))

advancement = {"criteria": {"click": {"trigger": "minecraft:player_interacted_with_entity", "conditions": {"entity": [{"condition": "minecraft:entity_properties", "entity": "this", "predicate": {"minecraft:entity_type": "minecraft:interaction"}}, {"condition": "minecraft:entity_scores", "entity": "this", "scores": {"gm_sq": {"min": 0, "max": 360}}}]}}}, "rewards": {"function": "gomoku:input/click_dispatch"}}
adv_path = PACK / "data/gomoku/advancement/click_cell.json"
adv_path.parent.mkdir(parents=True, exist_ok=True)
adv_path.write_text(json.dumps(advancement, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

# 独立 GameTest 世界调用这些宏，检查所有 Dialog 的 codec 和动态模板。
sample_ui = {"phase": "轮到黑方行棋。", "buttons": [{"label": {"text": "认输"}, "action": {"type": "minecraft:run_command", "command": "trigger gm_action set 101"}}], "code": 101, "label": "认输", "color": "black"}
checks = ["# 仅供独立 GameTest 世界使用，不加入生产 tick。", "say GOMOKU_DIALOGS_BEGIN", "data merge storage gomoku:ui " + js(sample_ui),
          "function gomoku:ui/show with storage gomoku:ui", "say GOMOKU_DIALOG_PANEL_COMPILED",
          'data modify storage gomoku:ui buttons set value []',
          'function gomoku:ui/show with storage gomoku:ui', 'say GOMOKU_DIALOG_NOTICE_COMPILED',
          'data modify storage gomoku:ui buttons set value ' + js(sample_ui['buttons']),
          "function gomoku:ui/button_append with storage gomoku:ui", "scoreboard players set #ui_setting_base gm_ctx 100000000"]
for name, values in [("DEFAULT", (15,0,0,0,0,10,2,1,1,0)), ("MINIMUM", (13,0,0,0,0,0,1,0,0,0)), ("MAXIMUM", (19,1,0,1,1,30,3,1,1,1))]:
    sample_settings = dict(zip(("size", "board", "palette", "orient", "first", "time", "level", "mark", "coords", "confirm"), values))
    sample_settings["close"] = 100000000
    checks += ["data merge storage gomoku:settings " + js(sample_settings), "function gomoku:settings/root", "say GOMOKU_DIALOG_SETTING_" + name + "_COMPILED"]
checks += ['data merge storage gomoku:coordinates {nonce:1000,size:19,row:"$(row)",col:"$(col)"}',
           'function gomoku:ui/coordinates_show with storage gomoku:coordinates',
           "function gomoku:rules/show", "say GOMOKU_DIALOG_RULES_COMPILED", "say GOMOKU_DIALOGS_END"]
(PACK / "tools/test_gomoku_dialogs.mcfunction").write_text("\n".join(checks) + "\n", encoding="utf-8")
# 单棋盘点击入口独立维护；须在旧逐格入口生成之后覆盖。
from build_gomoku_input import build as build_input
build_input()
print("Gomoku input / dialogs / settings / rules generated")
