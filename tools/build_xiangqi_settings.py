"""生成中国象棋的单页即时设置；原版输入控件不提供值变化时的提交回调。"""
from pathlib import Path
import json

ROOT = Path(__file__).resolve().parents[1] / "data/xiangqi/function"


def build(root: Path = ROOT):
    def put(name, text):
        path = root / (name + ".mcfunction")
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text.strip() + "\n", encoding="utf-8")

    def js(value):
        return json.dumps(value, ensure_ascii=False, separators=(",", ":"))

    put("settings/open", '''
execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 13 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #ui_setting_table xq_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,limit=1] ct_id = #ui_setting_table xq_ctx run return 0
function xiangqi:settings/begin
function xiangqi:settings/root
''')
    put("settings/begin", '''
# 六位nonce、字段一位、数值两位，最大999999801，小于有符号整数上限。
execute if score #setting_serial xq_ctx matches 999999.. run scoreboard players add #ui_load xq_ctx 1
execute unless score #setting_serial xq_ctx matches 99999..999998 run scoreboard players set #setting_serial xq_ctx 99999
scoreboard players add #setting_serial xq_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] xq_setnonce = #setting_serial xq_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] xq_nonce = #ui_load xq_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] xq_set_table = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,limit=1] xq_setepoch = @s xq_epoch
scoreboard players set @a[tag=ct.settings_actor,limit=1] xq_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] xq_settings
function xiangqi:settings/prepare
''')
    put("settings/prepare", '''
scoreboard players set #ui_1000 xq_ctx 1000
scoreboard players operation #ui_setting_base xq_ctx = #setting_serial xq_ctx
scoreboard players operation #ui_setting_base xq_ctx *= #ui_1000 xq_ctx
execute store result storage xiangqi:settings close int 1 run scoreboard players get #ui_setting_base xq_ctx
execute store result storage xiangqi:settings board int 1 run scoreboard players get @s xq_board
execute store result storage xiangqi:settings palette int 1 run scoreboard players get @s xq_palette
execute store result storage xiangqi:settings orient int 1 run scoreboard players get @s xq_orient
execute store result storage xiangqi:settings first int 1 run scoreboard players get @s xq_first
execute store result storage xiangqi:settings time int 1 run scoreboard players get @s xq_time
execute store result storage xiangqi:settings level int 1 run scoreboard players get @s xq_level
execute store result storage xiangqi:settings hints int 1 run scoreboard players get @s xq_hints
execute store result storage xiangqi:settings variant int 1 run scoreboard players get @s xq_variant
''')
    fields = [
        (1, "board", "棋盘配色", [(0, "经典"), (1, "木色")]),
        (2, "palette", "棋子配色", [(0, "经典"), (1, "木色")]),
        (3, "orient", "棋盘方向", [(0, "南北向 · 红方南侧"), (1, "东西向 · 红方西侧")]),
        (4, "first", "红黑方分配", [(1, "按座位自行选边"), (0, "随机分配红黑")]),
        (5, "time", "每人计时", [(0, "无限制")] + [(n, f"{n}分钟") for n in range(5, 31, 5)]),
        (6, "level", "单人人机难度", [(1, "简单"), (2, "普通"), (3, "困难")]),
        (7, "hints", "可走格提示", [(0, "关闭"), (1, "开启")]),
        (8, "variant", "玩法", [(0, "标准象棋"), (1, "揭棋")]),
    ]
    lines = []
    for field, key, label, choices in fields:
        row = key + "_row"
        lines.append(f'data modify storage xiangqi:settings {row} set value ' + js({"text": label + "\n", "color": "white", "extra": []}))
        for value, label in choices:
            lines.append('function xiangqi:settings/choice ' + js({"key": key, "row": row, "value": value, "code": field * 100 + value, "label": label}))
    lines.append('function xiangqi:settings/root_show with storage xiangqi:settings')
    put("settings/root", "\n".join(lines))
    put("settings/choice", '''
$execute store result score #ui_setting_current xq_ctx run data get storage xiangqi:settings $(key)
$data modify storage xiangqi:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #ui_setting_code xq_ctx $(code)
scoreboard players operation #ui_setting_code xq_ctx += #ui_setting_base xq_ctx
execute store result storage xiangqi:settings code int 1 run scoreboard players get #ui_setting_code xq_ctx
$execute unless score #ui_setting_current xq_ctx matches $(value) run function xiangqi:settings/command with storage xiangqi:settings
$execute if score #ui_setting_current xq_ctx matches $(value) run data modify storage xiangqi:settings option.color set value "gold"
$execute if score #ui_setting_current xq_ctx matches $(value) run data modify storage xiangqi:settings option.bold set value true
$data modify storage xiangqi:settings $(row).extra append from storage xiangqi:settings option
''')
    put("settings/command", '$data modify storage xiangqi:settings option.click_event set value {action:"run_command",command:"trigger xq_settings set $(code)"}')
    # multi_action 要求 actions 非空；正文链接 + 一个完成按钮应使用 notice。
    dialog = {
        "type": "minecraft:notice", "title": {"text": "中国象棋 · 游戏设置", "color": "gold"},
        "body": [{"type": "minecraft:plain_message", "width": 460, "contents": {"text": "【牌桌皮肤 · 点击选择】", "color": "aqua", "underlined": True, "click_event": {"action": "run_command", "command": "trigger ct_skin_pick set 4"}}}]
                + [{"type": "minecraft:plain_message", "width": 460, "contents": "__" + key + "_row__"} for _, key, _, _ in fields],
        "action": {"label": {"text": "完成"}, "width": 140, "action": {"type": "minecraft:run_command", "command": "trigger xq_settings set $(close)"}},
        "pause": False, "can_close_with_escape": True, "after_action": "none",
    }
    show = js(dialog)
    for _, key, _, _ in fields:
        show = show.replace('"__' + key + '_row__"', '$(' + key + '_row)')
    put("settings/root_show", '$dialog show @a[tag=ct.settings_actor,limit=1] ' + show)
    put("settings/invalid", '''
tellraw @s {text:"[中国象棋] 设置窗口已过期或输入无效，请重新打开本桌的游戏设置。",color:"yellow"}
tag @e[tag=xq.setting_table] remove xq.setting_table
''')
    # 保留旧8/9位后缀解码，所有新按钮均生成一致的9位码。
    put("settings/save", '''
scoreboard players operation #ui_setting_input xq_ctx = @s xq_settings
scoreboard players reset @s xq_settings
execute unless entity @s[tag=ct.player] run return run function xiangqi:settings/invalid
execute unless score @s xq_nonce = #ui_load xq_ctx run return run function xiangqi:settings/invalid
execute unless score @s ct_id = @s xq_set_table run return run function xiangqi:settings/invalid
execute unless score #ui_setting_input xq_ctx matches 10000000..999999999 run return run function xiangqi:settings/invalid
scoreboard players set #ui_10 xq_ctx 10
scoreboard players set #ui_100 xq_ctx 100
scoreboard players operation #ui_setting_nonce xq_ctx = #ui_setting_input xq_ctx
execute if score #ui_setting_input xq_ctx matches ..99999999 run scoreboard players operation #ui_setting_nonce xq_ctx /= #ui_10 xq_ctx
execute if score #ui_setting_input xq_ctx matches 100000000.. run scoreboard players operation #ui_setting_nonce xq_ctx /= #ui_100 xq_ctx
scoreboard players operation #ui_setting_field xq_ctx = #ui_setting_nonce xq_ctx
scoreboard players operation #ui_setting_field xq_ctx %= #ui_10 xq_ctx
scoreboard players operation #ui_setting_nonce xq_ctx /= #ui_10 xq_ctx
execute unless score #ui_setting_nonce xq_ctx = @s xq_setnonce run return run function xiangqi:settings/invalid
scoreboard players operation #ui_setting_value xq_ctx = #ui_setting_input xq_ctx
execute if score #ui_setting_input xq_ctx matches ..99999999 run scoreboard players operation #ui_setting_value xq_ctx %= #ui_10 xq_ctx
execute if score #ui_setting_input xq_ctx matches 100000000.. run scoreboard players operation #ui_setting_value xq_ctx %= #ui_100 xq_ctx
tag @e[tag=xq.setting_table] remove xq.setting_table
scoreboard players operation #ui_setting_table xq_ctx = @s xq_set_table
scoreboard players operation #ui_setting_epoch xq_ctx = @s xq_setepoch
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=13,ct_state=0}] if score @s ct_id = #ui_setting_table xq_ctx if score @s xq_epoch = #ui_setting_epoch xq_ctx run tag @s add xq.setting_table
execute unless entity @e[tag=xq.setting_table,limit=1] run return run function xiangqi:settings/invalid
execute unless score #ui_setting_field xq_ctx matches 0..8 run return run function xiangqi:settings/invalid
execute if score #ui_setting_field xq_ctx matches 0 unless score #ui_setting_value xq_ctx matches 0 run return run function xiangqi:settings/invalid
execute if score #ui_setting_field xq_ctx matches 1..2 unless score #ui_setting_value xq_ctx matches 0..1 run return run function xiangqi:settings/invalid
execute if score #ui_setting_field xq_ctx matches 3..4 unless score #ui_setting_value xq_ctx matches 0..1 run return run function xiangqi:settings/invalid
execute if score #ui_setting_field xq_ctx matches 5 unless score #ui_setting_value xq_ctx matches 0..30 run return run function xiangqi:settings/invalid
execute if score #ui_setting_field xq_ctx matches 6 unless score #ui_setting_value xq_ctx matches 1..3 run return run function xiangqi:settings/invalid
execute if score #ui_setting_field xq_ctx matches 7 unless score #ui_setting_value xq_ctx matches 0..1 run return run function xiangqi:settings/invalid
execute if score #ui_setting_field xq_ctx matches 8 unless score #ui_setting_value xq_ctx matches 0..1 run return run function xiangqi:settings/invalid
scoreboard players operation #ui_setting_mod xq_ctx = #ui_setting_value xq_ctx
scoreboard players set #ui_5 xq_ctx 5
scoreboard players operation #ui_setting_mod xq_ctx %= #ui_5 xq_ctx
execute if score #ui_setting_field xq_ctx matches 5 unless score #ui_setting_mod xq_ctx matches 0 run return run function xiangqi:settings/invalid
scoreboard players set @s xq_setnonce 0
execute if score #ui_setting_field xq_ctx matches 0 run return run function xiangqi:settings/close
execute if score #ui_setting_field xq_ctx matches 1 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_board = #ui_setting_value xq_ctx
execute if score #ui_setting_field xq_ctx matches 2 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_palette = #ui_setting_value xq_ctx
execute if score #ui_setting_field xq_ctx matches 3 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_orient = #ui_setting_value xq_ctx
execute if score #ui_setting_field xq_ctx matches 4 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_first = #ui_setting_value xq_ctx
execute if score #ui_setting_field xq_ctx matches 5 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_time = #ui_setting_value xq_ctx
execute if score #ui_setting_field xq_ctx matches 6 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_level = #ui_setting_value xq_ctx
execute if score #ui_setting_field xq_ctx matches 7 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_hints = #ui_setting_value xq_ctx
execute if score #ui_setting_field xq_ctx matches 8 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_variant = #ui_setting_value xq_ctx
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
# 外观立即重建本桌预览；一次刷新后绑定新epoch，其他旧窗口也随之失效。
execute if score #ui_setting_field xq_ctx matches 1..3 as @e[tag=xq.setting_table,limit=1] at @s run function xiangqi:game/preview
# 切换玩法要重摆初始棋面；外观设置仍可查看保留的终局。
execute if score #ui_setting_field xq_ctx matches 8 run data remove entity @e[tag=xq.setting_table,limit=1] data.xiangqi.review
execute if score #ui_setting_field xq_ctx matches 8 as @e[tag=xq.setting_table,limit=1] at @s run function xiangqi:game/preview
execute as @e[tag=xq.setting_table,limit=1] at @s run function xiangqi:settings/open
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @e[tag=xq.setting_table] remove xq.setting_table
''')
    put("settings/close", '''
function xiangqi:settings/clear_session
dialog clear @s
tag @s remove ct.settings_actor
tag @e[tag=xq.setting_table] remove xq.setting_table
''')
    put("settings/clear_session", '''
scoreboard players reset @s xq_settings
scoreboard players reset @s xq_setnonce
scoreboard players reset @s xq_nonce
scoreboard players reset @s xq_set_table
scoreboard players reset @s xq_setepoch
''')
    put("settings/invalidate_table", '''
scoreboard players operation #ui_setting_table xq_ctx = @s ct_id
execute as @a if score @s xq_set_table = #ui_setting_table xq_ctx run function xiangqi:settings/clear_session
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
