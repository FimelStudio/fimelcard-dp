"""生成国际象棋的单页即时设置；原版输入控件不提供值变化时的提交回调。"""
from pathlib import Path
import json

ROOT = Path(__file__).resolve().parents[1] / "data/chess/function"


def build(root: Path = ROOT):
    def put(name, text):
        path = root / (name + ".mcfunction")
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text.strip() + "\n", encoding="utf-8")

    def js(value):
        return json.dumps(value, ensure_ascii=False, separators=(",", ":"))

    put("settings/open", '''
execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 12 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #ui_setting_table ch_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,limit=1] ct_id = #ui_setting_table ch_ctx run return 0
function chess:settings/begin
function chess:settings/root
''')
    put("settings/begin", '''
# 六位nonce、字段一位、数值两位，最大999999701，小于有符号整数上限。
execute if score #setting_serial ch_ctx matches 999999.. run scoreboard players add #ui_load ch_ctx 1
execute unless score #setting_serial ch_ctx matches 99999..999998 run scoreboard players set #setting_serial ch_ctx 99999
scoreboard players add #setting_serial ch_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ch_setnonce = #setting_serial ch_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ch_nonce = #ui_load ch_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ch_set_table = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ch_setepoch = @s ch_epoch
scoreboard players set @a[tag=ct.settings_actor,limit=1] ch_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] ch_settings
function chess:settings/prepare
''')
    put("settings/prepare", '''
scoreboard players set #ui_1000 ch_ctx 1000
scoreboard players operation #ui_setting_base ch_ctx = #setting_serial ch_ctx
scoreboard players operation #ui_setting_base ch_ctx *= #ui_1000 ch_ctx
execute store result storage chess:settings close int 1 run scoreboard players get #ui_setting_base ch_ctx
execute store result storage chess:settings board int 1 run scoreboard players get @s ch_board
execute store result storage chess:settings palette int 1 run scoreboard players get @s ch_palette
execute store result storage chess:settings orient int 1 run scoreboard players get @s ch_orient
execute store result storage chess:settings first int 1 run scoreboard players get @s ch_first
execute store result storage chess:settings time int 1 run scoreboard players get @s ch_time
execute store result storage chess:settings level int 1 run scoreboard players get @s ch_level
execute store result storage chess:settings hints int 1 run scoreboard players get @s ch_hints
''')
    fields = [
        (1, "board", "棋盘配色", [(0, "经典黑白"), (1, "清新绿"), (2, "胡桃木"), (3, "海洋蓝"), (4, "薰衣草紫")]),
        (2, "palette", "棋子配色", [(0, "黑白"), (1, "木色"), (2, "冰蓝"), (3, "翡翠玉")]),
        (3, "orient", "棋盘方向", [(0, "南北向 · 白方南侧"), (1, "东西向 · 白方西侧")]),
        (4, "first", "黑白方分配", [(1, "按座位自行选边"), (0, "随机分配黑白")]),
        (5, "time", "每人计时", [(0, "无限制")] + [(n, f"{n}分钟") for n in range(5, 31, 5)]),
        (6, "level", "单人人机难度", [(1, "简单"), (2, "普通"), (3, "困难")]),
        (7, "hints", "可走格提示", [(0, "关闭"), (1, "开启")]),
    ]
    lines = []
    for field, key, label, choices in fields:
        row = key + "_row"
        lines.append(f'data modify storage chess:settings {row} set value ' + js({"text": label + "\n", "color": "white", "extra": []}))
        for value, label in choices:
            lines.append('function chess:settings/choice ' + js({"key": key, "row": row, "value": value, "code": field * 100 + value, "label": label}))
    lines.append('function chess:settings/root_show with storage chess:settings')
    put("settings/root", "\n".join(lines))
    put("settings/choice", '''
$execute store result score #ui_setting_current ch_ctx run data get storage chess:settings $(key)
$data modify storage chess:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #ui_setting_code ch_ctx $(code)
scoreboard players operation #ui_setting_code ch_ctx += #ui_setting_base ch_ctx
execute store result storage chess:settings code int 1 run scoreboard players get #ui_setting_code ch_ctx
$execute unless score #ui_setting_current ch_ctx matches $(value) run function chess:settings/command with storage chess:settings
$execute if score #ui_setting_current ch_ctx matches $(value) run data modify storage chess:settings option.color set value "gold"
$execute if score #ui_setting_current ch_ctx matches $(value) run data modify storage chess:settings option.bold set value true
$data modify storage chess:settings $(row).extra append from storage chess:settings option
''')
    put("settings/command", '$data modify storage chess:settings option.click_event set value {action:"run_command",command:"trigger ch_settings set $(code)"}')
    # multi_action 要求 actions 非空；正文链接 + 一个完成按钮应使用 notice。
    dialog = {
        "type": "minecraft:notice", "title": {"text": "国际象棋 · 游戏设置", "color": "gold"},
        "body": [{"type": "minecraft:plain_message", "width": 460, "contents": {"text": "【牌桌皮肤 · 点击选择】", "color": "aqua", "underlined": True, "click_event": {"action": "run_command", "command": "trigger ct_skin_pick set 4"}}}]
                + [{"type": "minecraft:plain_message", "width": 460, "contents": "__" + key + "_row__"} for _, key, _, _ in fields],
        "action": {"label": {"text": "完成"}, "width": 140, "action": {"type": "minecraft:run_command", "command": "trigger ch_settings set $(close)"}},
        "pause": False, "can_close_with_escape": True, "after_action": "none",
    }
    show = js(dialog)
    for _, key, _, _ in fields:
        show = show.replace('"__' + key + '_row__"', '$(' + key + '_row)')
    put("settings/root_show", '$dialog show @a[tag=ct.settings_actor,limit=1] ' + show)
    put("settings/invalid", '''
tellraw @s {text:"[国际象棋] 设置窗口已过期或输入无效，请重新打开本桌的游戏设置。",color:"yellow"}
tag @e[tag=ch.setting_table] remove ch.setting_table
''')
    # 保留旧8/9位后缀解码，所有新按钮均生成一致的9位码。
    put("settings/save", '''
scoreboard players operation #ui_setting_input ch_ctx = @s ch_settings
scoreboard players reset @s ch_settings
execute unless entity @s[tag=ct.player] run return run function chess:settings/invalid
execute unless score @s ch_nonce = #ui_load ch_ctx run return run function chess:settings/invalid
execute unless score @s ct_id = @s ch_set_table run return run function chess:settings/invalid
execute unless score #ui_setting_input ch_ctx matches 10000000..999999999 run return run function chess:settings/invalid
scoreboard players set #ui_10 ch_ctx 10
scoreboard players set #ui_100 ch_ctx 100
scoreboard players operation #ui_setting_nonce ch_ctx = #ui_setting_input ch_ctx
execute if score #ui_setting_input ch_ctx matches ..99999999 run scoreboard players operation #ui_setting_nonce ch_ctx /= #ui_10 ch_ctx
execute if score #ui_setting_input ch_ctx matches 100000000.. run scoreboard players operation #ui_setting_nonce ch_ctx /= #ui_100 ch_ctx
scoreboard players operation #ui_setting_field ch_ctx = #ui_setting_nonce ch_ctx
scoreboard players operation #ui_setting_field ch_ctx %= #ui_10 ch_ctx
scoreboard players operation #ui_setting_nonce ch_ctx /= #ui_10 ch_ctx
execute unless score #ui_setting_nonce ch_ctx = @s ch_setnonce run return run function chess:settings/invalid
scoreboard players operation #ui_setting_value ch_ctx = #ui_setting_input ch_ctx
execute if score #ui_setting_input ch_ctx matches ..99999999 run scoreboard players operation #ui_setting_value ch_ctx %= #ui_10 ch_ctx
execute if score #ui_setting_input ch_ctx matches 100000000.. run scoreboard players operation #ui_setting_value ch_ctx %= #ui_100 ch_ctx
tag @e[tag=ch.setting_table] remove ch.setting_table
scoreboard players operation #ui_setting_table ch_ctx = @s ch_set_table
scoreboard players operation #ui_setting_epoch ch_ctx = @s ch_setepoch
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=12,ct_state=0}] if score @s ct_id = #ui_setting_table ch_ctx if score @s ch_epoch = #ui_setting_epoch ch_ctx run tag @s add ch.setting_table
execute unless entity @e[tag=ch.setting_table,limit=1] run return run function chess:settings/invalid
execute unless score #ui_setting_field ch_ctx matches 0..7 run return run function chess:settings/invalid
execute if score #ui_setting_field ch_ctx matches 0 unless score #ui_setting_value ch_ctx matches 0 run return run function chess:settings/invalid
execute if score #ui_setting_field ch_ctx matches 1 unless score #ui_setting_value ch_ctx matches 0..4 run return run function chess:settings/invalid
execute if score #ui_setting_field ch_ctx matches 2 unless score #ui_setting_value ch_ctx matches 0..3 run return run function chess:settings/invalid
execute if score #ui_setting_field ch_ctx matches 3..4 unless score #ui_setting_value ch_ctx matches 0..1 run return run function chess:settings/invalid
execute if score #ui_setting_field ch_ctx matches 5 unless score #ui_setting_value ch_ctx matches 0..30 run return run function chess:settings/invalid
execute if score #ui_setting_field ch_ctx matches 6 unless score #ui_setting_value ch_ctx matches 1..3 run return run function chess:settings/invalid
execute if score #ui_setting_field ch_ctx matches 7 unless score #ui_setting_value ch_ctx matches 0..1 run return run function chess:settings/invalid
scoreboard players operation #ui_setting_mod ch_ctx = #ui_setting_value ch_ctx
scoreboard players set #ui_5 ch_ctx 5
scoreboard players operation #ui_setting_mod ch_ctx %= #ui_5 ch_ctx
execute if score #ui_setting_field ch_ctx matches 5 unless score #ui_setting_mod ch_ctx matches 0 run return run function chess:settings/invalid
scoreboard players set @s ch_setnonce 0
execute if score #ui_setting_field ch_ctx matches 0 run return run function chess:settings/close
execute if score #ui_setting_field ch_ctx matches 1 run scoreboard players operation @e[tag=ch.setting_table,limit=1] ch_board = #ui_setting_value ch_ctx
execute if score #ui_setting_field ch_ctx matches 2 run scoreboard players operation @e[tag=ch.setting_table,limit=1] ch_palette = #ui_setting_value ch_ctx
execute if score #ui_setting_field ch_ctx matches 3 run scoreboard players operation @e[tag=ch.setting_table,limit=1] ch_orient = #ui_setting_value ch_ctx
execute if score #ui_setting_field ch_ctx matches 4 run scoreboard players operation @e[tag=ch.setting_table,limit=1] ch_first = #ui_setting_value ch_ctx
execute if score #ui_setting_field ch_ctx matches 5 run scoreboard players operation @e[tag=ch.setting_table,limit=1] ch_time = #ui_setting_value ch_ctx
execute if score #ui_setting_field ch_ctx matches 6 run scoreboard players operation @e[tag=ch.setting_table,limit=1] ch_level = #ui_setting_value ch_ctx
execute if score #ui_setting_field ch_ctx matches 7 run scoreboard players operation @e[tag=ch.setting_table,limit=1] ch_hints = #ui_setting_value ch_ctx
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
# 外观立即重建本桌预览；一次刷新后绑定新epoch，其他旧窗口也随之失效。
execute if score #ui_setting_field ch_ctx matches 1..3 as @e[tag=ch.setting_table,limit=1] at @s run function chess:game/preview
execute as @e[tag=ch.setting_table,limit=1] at @s run function chess:settings/open
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @e[tag=ch.setting_table] remove ch.setting_table
''')
    put("settings/close", '''
function chess:settings/clear_session
dialog clear @s
tag @s remove ct.settings_actor
tag @e[tag=ch.setting_table] remove ch.setting_table
''')
    put("settings/clear_session", '''
scoreboard players reset @s ch_settings
scoreboard players reset @s ch_setnonce
scoreboard players reset @s ch_nonce
scoreboard players reset @s ch_set_table
scoreboard players reset @s ch_setepoch
''')
    put("settings/invalidate_table", '''
scoreboard players operation #ui_setting_table ch_ctx = @s ct_id
execute as @a if score @s ch_set_table = #ui_setting_table ch_ctx run function chess:settings/clear_session
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
