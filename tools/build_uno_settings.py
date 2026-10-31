"""生成 UNO 单页即时设置；26.2 原版输入控件没有值改变时的提交回调。"""

from pathlib import Path
import json


DEFAULT_ROOT = Path(__file__).resolve().parents[1] / "data/uno/function"


def build(root: Path = DEFAULT_ROOT) -> None:
    def put(name: str, text: str) -> None:
        path = root / (name + ".mcfunction")
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text.strip() + "\n", encoding="utf-8")

    def js(value: object) -> str:
        return json.dumps(value, ensure_ascii=False, separators=(",", ":"))

    put("settings/open", '''
function uno:game/init_table
execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 11 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #ui_setting_table un_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,limit=1] ct_id = #ui_setting_table un_ctx run return 0
function uno:settings/begin
function uno:settings/root with storage uno:settings
''')
    put("settings/begin", '''
# nonce*100000 + 字段*1000 + 数值；字段0退出、1模式、2局数、3目标分/100、4自动喊、5质疑、6秒数。
# nonce轮回时同时推进重载代数，避免极旧窗口在序列循环后重新有效。
scoreboard players add #setting_serial un_ctx 1
execute if score #setting_serial un_ctx matches 20001.. run scoreboard players add #ui_load un_ctx 1
execute if score #setting_serial un_ctx matches 20001.. run scoreboard players set #setting_serial un_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] un_setnonce = #setting_serial un_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] un_nonce = #ui_load un_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] un_set_table = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] un_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] un_settings
function uno:settings/prepare
''')
    put("settings/prepare", '''
# 控制器上的六项持久设置是唯一真值；storage只负责本次窗口的组件构造。
scoreboard players set #ui_100000 un_ctx 100000
scoreboard players operation #ui_setting_base un_ctx = #setting_serial un_ctx
scoreboard players operation #ui_setting_base un_ctx *= #ui_100000 un_ctx
execute store result storage uno:settings close int 1 run scoreboard players get #ui_setting_base un_ctx
execute store result storage uno:settings mode int 1 run scoreboard players get @s un_mode
execute store result storage uno:settings rounds int 1 run scoreboard players get @s un_rounds
execute store result storage uno:settings target int 1 run scoreboard players get @s un_target
execute store result storage uno:settings auto int 1 run scoreboard players get @s un_auto
execute store result storage uno:settings challenge int 1 run scoreboard players get @s un_challenge
scoreboard players operation #ui_sec un_ctx = @s un_window
scoreboard players set #ui_20 un_ctx 20
scoreboard players operation #ui_sec un_ctx /= #ui_20 un_ctx
execute store result storage uno:settings seconds int 1 run scoreboard players get #ui_sec un_ctx
scoreboard players operation #ui_targethundreds un_ctx = @s un_target
scoreboard players set #ui_100 un_ctx 100
scoreboard players operation #ui_targethundreds un_ctx /= #ui_100 un_ctx
execute store result storage uno:settings target_hundreds int 1 run scoreboard players get #ui_targethundreds un_ctx
''')

    # 原版number_range/boolean/single_option只在动作按钮提交时发送值。
    # 这里以同一页的点击选项和加减控件实现真正的即时生效，不伪造on_change字段。
    lines: list[str] = []
    fields = [
        (1, "mode", "比赛模式", [(0, "单局"), (1, "固定局数"), (2, "目标积分")]),
        (2, "rounds", "固定局数（固定局数积分赛）", None),
        (3, "target", "目标积分（目标积分赛）", None),
        (4, "auto", "自动喊 UNO", [(0, "手动喊"), (1, "自动喊")]),
        (5, "challenge", "+4 质疑", [(1, "允许质疑"), (0, "禁止违规 +4")]),
        (6, "window", "抓 UNO 时长（手动喊 UNO）", None),
    ]
    for field, key, label, choices in fields:
        row = key + "_row"
        lines.append(f'data modify storage uno:settings {row} set value {js({"text": label + chr(10), "color": "white", "extra": []})}')
        if choices is not None:
            for value, choice_label in choices:
                lines.append('function uno:settings/choice ' + js({"key": key, "row": row, "value": value, "code": field * 1000 + value, "label": choice_label}))
        else:
            value_key = {2: "rounds", 3: "target_hundreds", 6: "seconds"}[field]
            low, high = {2: (1, 32), 3: (1, 10), 6: (1, 5)}[field]
            deltas = [-5, -1, 1, 5] if field in (2, 3) else [-1, 1]
            for delta in deltas:
                if delta > 0 and not any(x > 0 and x < delta for x in deltas):
                    number = {2: "$(rounds) 局", 3: "$(target) 分", 6: "$(seconds) 秒"}[field]
                    lines.append(f'$data modify storage uno:settings {row}.extra append value ' + js({"text": "  " + number + "  ", "color": "gold", "bold": True}))
                magnitude = abs(delta) * (100 if field == 3 else 1)
                button_label = ("−" if delta < 0 else "+") + str(magnitude)
                lines.append('function uno:settings/step ' + js({"key": value_key, "row": row, "offset": field * 1000, "delta": delta, "min": low, "max": high, "label": button_label}))
    lines.append('function uno:settings/root_show with storage uno:settings')
    put("settings/root", "\n".join(lines))

    put("settings/choice", '''
$execute store result score #ui_setting_current un_ctx run data get storage uno:settings $(key)
$data modify storage uno:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #ui_setting_code un_ctx $(code)
scoreboard players operation #ui_setting_code un_ctx += #ui_setting_base un_ctx
execute store result storage uno:settings code int 1 run scoreboard players get #ui_setting_code un_ctx
$execute unless score #ui_setting_current un_ctx matches $(value) run function uno:settings/command with storage uno:settings
$execute if score #ui_setting_current un_ctx matches $(value) run data modify storage uno:settings option.color set value "gold"
$execute if score #ui_setting_current un_ctx matches $(value) run data modify storage uno:settings option.bold set value true
$data modify storage uno:settings $(row).extra append from storage uno:settings option
''')
    put("settings/step", '''
$execute store result score #ui_setting_current un_ctx run data get storage uno:settings $(key)
scoreboard players operation #ui_setting_value un_ctx = #ui_setting_current un_ctx
$scoreboard players set #ui_setting_delta un_ctx $(delta)
scoreboard players operation #ui_setting_value un_ctx += #ui_setting_delta un_ctx
$execute if score #ui_setting_value un_ctx matches ..$(min) run scoreboard players set #ui_setting_value un_ctx $(min)
$execute if score #ui_setting_value un_ctx matches $(max).. run scoreboard players set #ui_setting_value un_ctx $(max)
$data modify storage uno:settings option set value {text:" [$(label)] ",color:"aqua"}
scoreboard players operation #ui_setting_code un_ctx = #ui_setting_base un_ctx
$scoreboard players add #ui_setting_code un_ctx $(offset)
scoreboard players operation #ui_setting_code un_ctx += #ui_setting_value un_ctx
execute store result storage uno:settings code int 1 run scoreboard players get #ui_setting_code un_ctx
execute unless score #ui_setting_value un_ctx = #ui_setting_current un_ctx run function uno:settings/command with storage uno:settings
execute if score #ui_setting_value un_ctx = #ui_setting_current un_ctx run data modify storage uno:settings option.color set value "dark_gray"
$data modify storage uno:settings $(row).extra append from storage uno:settings option
''')
    put("settings/command", '''
$data modify storage uno:settings option.click_event set value {action:"run_command",command:"trigger un_settings set $(code)"}
''')
    # multi_action 要求 actions 非空；正文链接 + 一个完成按钮应使用 notice。
    dialog = {
        "type": "minecraft:notice",
        "title": {"text": "UNO · 游戏设置", "color": "gold"},
        "body": [{"type": "minecraft:plain_message", "width": 460, "contents": {"text": "【牌桌皮肤 · 点击选择】", "color": "aqua", "underlined": True, "click_event": {"action": "run_command", "command": "trigger ct_skin_pick set 4"}}}]
                + [{"type": "minecraft:plain_message", "width": 460, "contents": "__" + key + "_row__"} for _, key, _, _ in fields],
        "action": {"label": {"text": "完成"}, "width": 140, "action": {"type": "minecraft:run_command", "command": "trigger un_settings set $(close)"}},
        "pause": False, "can_close_with_escape": True, "after_action": "none",
    }
    show = js(dialog)
    for _, key, _, _ in fields:
        show = show.replace('"__' + key + '_row__"', "$(" + key + "_row)")
    put("settings/root_show", "$dialog show @a[tag=ct.settings_actor,limit=1] " + show)
    put("settings/invalid", '''
tellraw @s {text:"[UNO] 设置窗口已过期或输入无效，请重新打开本桌的游戏设置。",color:"yellow"}
tag @e[tag=un.setting_table] remove un.setting_table
''')
    put("settings/save", '''
scoreboard players operation #ui_setting_input un_ctx = @s un_settings
scoreboard players reset @s un_settings
execute unless entity @s[tag=ct.player] run return run function uno:settings/invalid
execute unless score @s un_nonce = #ui_load un_ctx run return run function uno:settings/invalid
execute unless score @s ct_id = @s un_set_table run return run function uno:settings/invalid
scoreboard players set #ui_100000 un_ctx 100000
scoreboard players operation #ui_setting_nonce un_ctx = #ui_setting_input un_ctx
scoreboard players operation #ui_setting_nonce un_ctx /= #ui_100000 un_ctx
execute unless score #ui_setting_nonce un_ctx = @s un_setnonce run return run function uno:settings/invalid
scoreboard players set @s un_setnonce 0
scoreboard players operation #ui_setting_input un_ctx %= #ui_100000 un_ctx
scoreboard players set #ui_1000 un_ctx 1000
scoreboard players operation #ui_setting_field un_ctx = #ui_setting_input un_ctx
scoreboard players operation #ui_setting_field un_ctx /= #ui_1000 un_ctx
scoreboard players operation #ui_setting_value un_ctx = #ui_setting_input un_ctx
scoreboard players operation #ui_setting_value un_ctx %= #ui_1000 un_ctx
tag @e[tag=un.setting_table] remove un.setting_table
scoreboard players operation #ui_setting_table un_ctx = @s un_set_table
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=11,ct_state=0}] if score @s ct_id = #ui_setting_table un_ctx run tag @s add un.setting_table
execute unless entity @e[tag=un.setting_table,limit=1] run return run function uno:settings/invalid
execute unless score #ui_setting_field un_ctx matches 0..6 run return run function uno:settings/invalid
execute if score #ui_setting_field un_ctx matches 0 unless score #ui_setting_value un_ctx matches 0 run return run function uno:settings/invalid
execute if score #ui_setting_field un_ctx matches 1 unless score #ui_setting_value un_ctx matches 0..2 run return run function uno:settings/invalid
execute if score #ui_setting_field un_ctx matches 2 unless score #ui_setting_value un_ctx matches 1..32 run return run function uno:settings/invalid
execute if score #ui_setting_field un_ctx matches 3 unless score #ui_setting_value un_ctx matches 1..10 run return run function uno:settings/invalid
execute if score #ui_setting_field un_ctx matches 4..5 unless score #ui_setting_value un_ctx matches 0..1 run return run function uno:settings/invalid
execute if score #ui_setting_field un_ctx matches 6 unless score #ui_setting_value un_ctx matches 1..5 run return run function uno:settings/invalid
execute if score #ui_setting_field un_ctx matches 0 run return run function uno:settings/close
execute if score #ui_setting_field un_ctx matches 1 run scoreboard players operation @e[tag=un.setting_table,limit=1] un_mode = #ui_setting_value un_ctx
execute if score #ui_setting_field un_ctx matches 2 run scoreboard players operation @e[tag=un.setting_table,limit=1] un_rounds = #ui_setting_value un_ctx
execute if score #ui_setting_field un_ctx matches 3 run scoreboard players set #ui_factor un_ctx 100
execute if score #ui_setting_field un_ctx matches 3 run scoreboard players operation #ui_setting_value un_ctx *= #ui_factor un_ctx
execute if score #ui_setting_field un_ctx matches 3 run scoreboard players operation @e[tag=un.setting_table,limit=1] un_target = #ui_setting_value un_ctx
execute if score #ui_setting_field un_ctx matches 4 run scoreboard players operation @e[tag=un.setting_table,limit=1] un_auto = #ui_setting_value un_ctx
execute if score #ui_setting_field un_ctx matches 5 run scoreboard players operation @e[tag=un.setting_table,limit=1] un_challenge = #ui_setting_value un_ctx
execute if score #ui_setting_field un_ctx matches 6 run scoreboard players set #ui_factor un_ctx 20
execute if score #ui_setting_field un_ctx matches 6 run scoreboard players operation #ui_setting_value un_ctx *= #ui_factor un_ctx
execute if score #ui_setting_field un_ctx matches 6 run scoreboard players operation @e[tag=un.setting_table,limit=1] un_window = #ui_setting_value un_ctx
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
execute as @e[tag=un.setting_table,limit=1] at @s run function uno:settings/open
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @e[tag=un.setting_table] remove un.setting_table
''')
    put("settings/close", '''
dialog clear @s
tag @s remove ct.settings_actor
tag @e[tag=un.setting_table] remove un.setting_table
''')
    put("settings/clear_session", '''
# 玩家入口：用于大厅离座及切换游戏，使旧设置窗口永久失效。
scoreboard players reset @s un_settings
scoreboard players reset @s un_setnonce
scoreboard players reset @s un_nonce
scoreboard players reset @s un_set_table
''')
    put("settings/invalidate_table", '''
# 控制器入口；清本桌所有设置会话，不影响邻桌或持久规则值。
scoreboard players operation #ui_setting_table un_ctx = @s ct_id
execute as @a if score @s un_set_table = #ui_setting_table un_ctx run function uno:settings/clear_session
''')

    # 仅清理由本生成器替代的旧分项页面，不涉及其余命名空间或玩家数据。
    obsolete = ["button", "button_append", "page"]
    obsolete += ["page_" + key + suffix for key in ("mode", "rounds", "target", "auto", "challenge", "window") for suffix in ("", "_show")]
    for name in obsolete:
        path = root / "settings" / (name + ".mcfunction")
        if path.exists():
            path.unlink()


if __name__ == "__main__":
    build()
    print("UNO single-page instant settings generated")
