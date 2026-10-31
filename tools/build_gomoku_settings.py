"""生成五子棋的单页即时设置；原版输入控件不提供值变化时的提交回调。"""
from pathlib import Path
import json

ROOT = Path(__file__).resolve().parents[1] / "data/gomoku/function"


def build(root: Path = ROOT):
    def put(name, text):
        path = root / (name + ".mcfunction")
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text.strip() + "\n", encoding="utf-8")

    def js(value):
        return json.dumps(value, ensure_ascii=False, separators=(",", ":"))

    put("settings/open", '''
execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 14 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #ui_setting_table gm_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,limit=1] ct_id = #ui_setting_table gm_ctx run return 0
function gomoku:settings/begin
function gomoku:settings/root
''')
    put("settings/begin", '''
# 六位nonce、字段一位、数值两位，最大999999701，小于有符号整数上限。
execute if score #setting_serial gm_ctx matches 99999.. run scoreboard players add #ui_load gm_ctx 1
execute unless score #setting_serial gm_ctx matches 9999..99998 run scoreboard players set #setting_serial gm_ctx 9999
scoreboard players add #setting_serial gm_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] gm_setnonce = #setting_serial gm_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] gm_nonce = #ui_load gm_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] gm_set_table = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,limit=1] gm_setepoch = @s gm_epoch
scoreboard players set @a[tag=ct.settings_actor,limit=1] gm_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] gm_settings
function gomoku:settings/prepare
''')
    put("settings/prepare", '''
scoreboard players set #ui_10000 gm_ctx 10000
scoreboard players operation #ui_setting_base gm_ctx = #setting_serial gm_ctx
scoreboard players operation #ui_setting_base gm_ctx *= #ui_10000 gm_ctx
execute store result storage gomoku:settings close int 1 run scoreboard players get #ui_setting_base gm_ctx
execute store result storage gomoku:settings board int 1 run scoreboard players get @s gm_board
execute store result storage gomoku:settings palette int 1 run scoreboard players get @s gm_palette
execute store result storage gomoku:settings orient int 1 run scoreboard players get @s gm_orient
execute store result storage gomoku:settings first int 1 run scoreboard players get @s gm_first
execute store result storage gomoku:settings time int 1 run scoreboard players get @s gm_time
execute store result storage gomoku:settings level int 1 run scoreboard players get @s gm_level
execute store result storage gomoku:settings size int 1 run scoreboard players get @s gm_size
execute store result storage gomoku:settings mark int 1 run scoreboard players get @s gm_mark
execute store result storage gomoku:settings coords int 1 run scoreboard players get @s gm_coords
execute store result storage gomoku:settings confirm int 1 run scoreboard players get @s gm_confirm
''')
    fields = [
        (1, "size", "棋盘大小", [(13,"13×13"),(15,"15×15"),(19,"19×19")]),
        (2, "board", "棋盘配色", [(0,"经典"),(1,"木色")]),
        (4, "orient", "棋盘方向", [(0,"黑方南侧"),(1,"黑方西侧")]),
        (5, "first", "黑白方分配", [(0,"随机分配"),(1,"按座位自行选边")]),
        (6, "time", "每人计时", [(0,"无限制")]+[(n,f"{n}分钟") for n in range(5,31,5)]),
        (7, "level", "单人人机难度", [(1,"简单"),(2,"普通"),(3,"困难")]),
        (8, "mark", "最后一手标记", [(0,"关闭"),(1,"开启")]),
        (9, "coords", "棋盘坐标", [(0,"隐藏"),(1,"显示")]),
        (10, "confirm", "右键落子确认", [(0,"一次落子"),(1,"同点两次确认")]),
    ]
    lines = []
    for field, key, label, choices in fields:
        row = key + "_row"
        lines.append(f'data modify storage gomoku:settings {row} set value ' + js({"text": label + "\n", "color": "white", "extra": []}))
        for value, label in choices:
            lines.append('function gomoku:settings/choice ' + js({"key": key, "row": row, "value": value, "code": field * 100 + value, "label": label}))
    lines.append('function gomoku:settings/root_show with storage gomoku:settings')
    put("settings/root", "\n".join(lines))
    put("settings/choice", '''
$execute store result score #ui_setting_current gm_ctx run data get storage gomoku:settings $(key)
$data modify storage gomoku:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #ui_setting_code gm_ctx $(code)
scoreboard players operation #ui_setting_code gm_ctx += #ui_setting_base gm_ctx
execute store result storage gomoku:settings code int 1 run scoreboard players get #ui_setting_code gm_ctx
$execute unless score #ui_setting_current gm_ctx matches $(value) run function gomoku:settings/command with storage gomoku:settings
$execute if score #ui_setting_current gm_ctx matches $(value) run data modify storage gomoku:settings option.color set value "gold"
$execute if score #ui_setting_current gm_ctx matches $(value) run data modify storage gomoku:settings option.bold set value true
$data modify storage gomoku:settings $(row).extra append from storage gomoku:settings option
''')
    put("settings/command", '$data modify storage gomoku:settings option.click_event set value {action:"run_command",command:"trigger gm_settings set $(code)"}')
    # multi_action 要求 actions 非空；正文链接 + 一个完成按钮应使用 notice。
    dialog = {
        "type": "minecraft:notice", "title": {"text": "五子棋 · 游戏设置", "color": "gold"},
        "body": [{"type": "minecraft:plain_message", "width": 460, "contents": {"text": "【牌桌皮肤 · 点击选择】", "color": "aqua", "underlined": True, "click_event": {"action": "run_command", "command": "trigger ct_skin_pick set 4"}}}]
                + [{"type": "minecraft:plain_message", "width": 460, "contents": "__" + key + "_row__"} for _, key, _, _ in fields],
        "action": {"label": {"text": "完成"}, "width": 140, "action": {"type": "minecraft:run_command", "command": "trigger gm_settings set $(close)"}},
        "pause": False, "can_close_with_escape": True, "after_action": "none",
    }
    show = js(dialog)
    for _, key, _, _ in fields:
        show = show.replace('"__' + key + '_row__"', '$(' + key + '_row)')
    put("settings/root_show", '$dialog show @a[tag=ct.settings_actor,limit=1] ' + show)
    put("settings/invalid", '''
tellraw @s {text:"[五子棋] 设置窗口已过期或输入无效，请重新打开本桌的游戏设置。",color:"yellow"}
tag @e[tag=gm.setting_table] remove gm.setting_table
''')
    # 所有设置按钮统一九位编码，关闭值为0。
    put("settings/save", '''
scoreboard players operation #ui_setting_input gm_ctx = @s gm_settings
scoreboard players reset @s gm_settings
execute unless entity @s[tag=ct.player] run return run function gomoku:settings/invalid
execute unless score @s gm_nonce = #ui_load gm_ctx run return run function gomoku:settings/invalid
execute unless score @s ct_id = @s gm_set_table run return run function gomoku:settings/invalid
execute unless score #ui_setting_input gm_ctx matches 100000000..999999999 run return run function gomoku:settings/invalid
scoreboard players set #ui_100 gm_ctx 100
scoreboard players set #ui_10000 gm_ctx 10000
scoreboard players operation #ui_setting_nonce gm_ctx = #ui_setting_input gm_ctx
scoreboard players operation #ui_setting_nonce gm_ctx /= #ui_10000 gm_ctx
execute unless score #ui_setting_nonce gm_ctx = @s gm_setnonce run return run function gomoku:settings/invalid
scoreboard players operation #ui_setting_field gm_ctx = #ui_setting_input gm_ctx
scoreboard players operation #ui_setting_field gm_ctx /= #ui_100 gm_ctx
scoreboard players operation #ui_setting_field gm_ctx %= #ui_100 gm_ctx
scoreboard players operation #ui_setting_value gm_ctx = #ui_setting_input gm_ctx
scoreboard players operation #ui_setting_value gm_ctx %= #ui_100 gm_ctx
tag @e[tag=gm.setting_table] remove gm.setting_table
scoreboard players operation #ui_setting_table gm_ctx = @s gm_set_table
scoreboard players operation #ui_setting_epoch gm_ctx = @s gm_setepoch
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=14,ct_state=0}] if score @s ct_id = #ui_setting_table gm_ctx if score @s gm_epoch = #ui_setting_epoch gm_ctx run tag @s add gm.setting_table
execute unless entity @e[tag=gm.setting_table,limit=1] run return run function gomoku:settings/invalid
execute unless score #ui_setting_field gm_ctx matches 0..10 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 0 unless score #ui_setting_value gm_ctx matches 0 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 1 unless score #ui_setting_value gm_ctx matches 13 unless score #ui_setting_value gm_ctx matches 15 unless score #ui_setting_value gm_ctx matches 19 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 2 unless score #ui_setting_value gm_ctx matches 0..1 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 3 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 4 unless score #ui_setting_value gm_ctx matches 0 unless score #ui_setting_value gm_ctx matches 1 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 5 unless score #ui_setting_value gm_ctx matches 0 unless score #ui_setting_value gm_ctx matches 1 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 6 unless score #ui_setting_value gm_ctx matches 0 unless score #ui_setting_value gm_ctx matches 5 unless score #ui_setting_value gm_ctx matches 10 unless score #ui_setting_value gm_ctx matches 15 unless score #ui_setting_value gm_ctx matches 20 unless score #ui_setting_value gm_ctx matches 25 unless score #ui_setting_value gm_ctx matches 30 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 7 unless score #ui_setting_value gm_ctx matches 1 unless score #ui_setting_value gm_ctx matches 2 unless score #ui_setting_value gm_ctx matches 3 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 8 unless score #ui_setting_value gm_ctx matches 0 unless score #ui_setting_value gm_ctx matches 1 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 9 unless score #ui_setting_value gm_ctx matches 0 unless score #ui_setting_value gm_ctx matches 1 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 10 unless score #ui_setting_value gm_ctx matches 0 unless score #ui_setting_value gm_ctx matches 1 run return run function gomoku:settings/invalid
scoreboard players set @s gm_setnonce 0
execute if score #ui_setting_field gm_ctx matches 0 run return run function gomoku:settings/close
execute if score #ui_setting_field gm_ctx matches 1 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_size = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 2 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_board = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 3 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_palette = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 4 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_orient = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 5 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_first = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 6 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_time = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 7 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_level = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 8 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_mark = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 9 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_coords = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 10 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_confirm = #ui_setting_value gm_ctx
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
# 外观立即重建本桌预览；一次刷新后绑定新epoch，其他旧窗口也随之失效。
execute if score #ui_setting_field gm_ctx matches 1 as @e[tag=gm.setting_table,limit=1] run data remove entity @s data.gomoku.review
execute if score #ui_setting_field gm_ctx matches 8..9 as @e[tag=gm.setting_table,limit=1] at @s run function gomoku:game/preview
execute if score #ui_setting_field gm_ctx matches 1..4 as @e[tag=gm.setting_table,limit=1] at @s run function gomoku:game/preview
execute as @e[tag=gm.setting_table,limit=1] at @s run function gomoku:settings/open
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @e[tag=gm.setting_table] remove gm.setting_table
''')
    put("settings/close", '''
function gomoku:settings/clear_session
dialog clear @s
tag @s remove ct.settings_actor
tag @e[tag=gm.setting_table] remove gm.setting_table
''')
    put("settings/clear_session", '''
scoreboard players reset @s gm_settings
scoreboard players reset @s gm_setnonce
scoreboard players reset @s gm_nonce
scoreboard players reset @s gm_set_table
scoreboard players reset @s gm_setepoch
''')
    put("settings/invalidate_table", '''
scoreboard players operation #ui_setting_table gm_ctx = @s ct_id
execute as @a if score @s gm_set_table = #ui_setting_table gm_ctx run function gomoku:settings/clear_session
''')
    # 仅删除被本页替代的旧设置函数，路径固定在本命名空间内。
    obsolete = ["button", "button_append", "page", "first_name", "time_name"]
    obsolete += ["page_" + key + suffix for key in ("board", "palette", "orient", "first", "time") for suffix in ("", "_show")]
    obsolete.append("page_first4_show")
    for name in obsolete:
        path = root / "settings" / (name + ".mcfunction")
        if path.exists():
            path.unlink()


if __name__ == "__main__":
    build()
    print("Chess single-page instant settings generated")
