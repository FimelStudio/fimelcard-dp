"""生成 UNO 的 BetterTitle 私有手牌 HUD 和配套字体。

沿用斗地主的内置 fimel_title 面板，不逐刻重建手牌。资源字体只引用
UNO 导出器生成的普通／高亮牌面；不会改变 BetterTitle 或上游字体。
"""
from __future__ import annotations

import argparse
import json
from pathlib import Path
from textwrap import dedent


PACK = Path(__file__).resolve().parents[1]
DEST = PACK / "data/uno/function/hud"
NAMES = [c + r for c in "rygb" for r in [str(n) for n in range(10)] + ["skip", "reverse", "plus2"]] + ["wild", "wild_plus4"]

# 斗地主实际使用 hand_0 的 height/ascent=56、默认原点 y=0。UNO 常规
# 手牌沿用其真实大小。BetterTitle 的正 y 向上，不能按屏幕坐标的方向使用。
# 牌面 y=12、数量 y=0：按各自字体 ascent 计算，数量在牌下方留出 5px。
# 多牌型逐步压紧并缩小，保持最多三行，最小 320×240 GUI 仍能显示全部。
# height, glyph_advance, card_gap, count_gap, card_tail, count_lead, count_tail
LAYOUTS = {
    "hud": (56, 34, 3, 25, 0, 11, -11),       # 1～8 型：完整牌面，最多 296px
    "hud_dense": (56, 34, -18, 4, 18, 2, 16), # 9～18 型：同尺寸交叠，最多 306px
    "hud_medium": (40, 25, -9, 4, 9, 2, 7),   # 19～36 型：两行，最多 297px
    "hud_small": (32, 20, -4, 4, 4, 2, 2),    # 37～54 型：三行，最多 292px
}


def put(name: str, commands: str) -> None:
    target = DEST / (name + ".mcfunction")
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text("\n".join(line.lstrip() for line in dedent(commands).strip().splitlines()) + "\n", encoding="utf-8")


def functions() -> None:
    put("activate", """
        # 一个玩家只分配一个可重用的 UNO 面板，退出时清空该面板。
        execute unless data storage fimel_title:io panels run function fimel_title:code/load
        execute if entity @s[tag=un.hud_active] run return 0
        scoreboard players set @s un_prev_panel 0
        execute if score @s fbt_panel matches 1.. run scoreboard players operation @s un_prev_panel = @s fbt_panel
        execute unless entity @s[tag=fimel.anim_text.replace.actionbar] run tag @s add un.owns_actionbar
        tag @s add fimel.anim_text.replace.actionbar
        function fimel_title:new_panel {id:"@s un_panel"}
        tag @s add un.hud_active
    """)
    put("deactivate", """
        # 仅清 UNO 自己的面板；别的游戏或外部面板已经接管时不覆盖它。
        execute if score @s un_panel matches 1.. run function uno:hud/empty
        execute if entity @s[tag=un.hud_active] if score @s fbt_panel = @s un_panel run function uno:hud/restore
        execute if entity @s[tag=un.owns_actionbar] run tag @s remove fimel.anim_text.replace.actionbar
        tag @s remove un.owns_actionbar
        tag @s remove un.hud_active
        scoreboard players reset @s un_prev_panel
    """)
    put("empty", """
        data modify storage fimel_title:io panel_buffer set value []
        scoreboard players operation panel_id fbt_io = @s un_panel
        function fimel_title:replace_panel
    """)
    put("restore", """
        scoreboard players set @s fbt_panel 0
        execute if score @s un_prev_panel matches 1.. run scoreboard players operation @s fbt_panel = @s un_prev_panel
        title @s actionbar {text:""}
    """)
    put("refresh", """
        # 控制器入口；真实手牌已提交后，每名玩家只构建自己的面板。
        function uno:system/context
        execute as @a[tag=un.audience] run function uno:hud/update
        scoreboard players set @s un_hud_dirty 0
    """)
    put("flush", """
        # take 只置脏；多张罚摸或起手同一刻最多刷新一次，避免重复扫牌。
        execute if score @s un_hud_dirty matches 1 if score @s un_state matches 1..5 run function uno:hud/refresh
    """)
    put("update", """
        # UI 的玩家入口也可调用。保留 un.actor、un.current、un.selected。
        execute unless entity @s[type=minecraft:player,tag=un.player,tag=ct.player] run return 0
        execute unless score @s ct_id = @s un_table run return 0
        scoreboard players operation #hud_table un_ctx = @s un_table
        execute unless entity @e[type=minecraft:marker,tag=un.current,scores={ct_game=11,un_state=1..5},limit=1] run return 0
        execute unless score @e[tag=un.current,limit=1] ct_id = #hud_table un_ctx run return 0
        function uno:hud/build
    """)
    put("build", """
        # 每个计数和牌型只来自本玩家、本桌的真实 marker，绝不复用别人的列表。
        execute unless entity @s[tag=un.hud_active] run function uno:hud/activate
        scoreboard players operation #hud_table un_ctx = @s un_table
        scoreboard players operation #hud_seat un_ctx = @s un_seat
        scoreboard players operation #hud_pick un_ctx = @s un_pick
        tag @e[tag=un.hudhand] remove un.hudhand
        execute as @e[type=minecraft:marker,tag=un.card] if score @s ct_id = #hud_table un_ctx if score @s un_owner = #hud_seat un_ctx run tag @s add un.hudhand
        data modify storage uno:hud rows set value [{cards:{text:"",shadow_color:0,extra:[]},counts:{text:"",shadow_color:0,extra:[]}},{cards:{text:"",shadow_color:0,extra:[]},counts:{text:"",shadow_color:0,extra:[]}},{cards:{text:"",shadow_color:0,extra:[]},counts:{text:"",shadow_color:0,extra:[]}}]
        scoreboard players set #hud_col un_ctx 0
        scoreboard players set #hud_row un_ctx 0
        scoreboard players set #hud_types un_ctx 0
        function uno:hud/cards
        tag @e[tag=un.hudhand] remove un.hudhand
        data modify storage fimel_title:io panel_buffer set value []
        data modify storage fimel_title:io text_buffer set value []
        data modify storage fimel_title:io neg_text_buffer set value []
        # 正 y 向上：数量独立位于牌下方，多行向上延伸并留出上下行间距。
        execute if score #hud_types un_ctx matches 1.. run function uno:hud/line {row:0,y:12,count_y:0}
        execute if score #hud_types un_ctx matches 19..36 run function uno:hud/line {row:1,y:68,count_y:56}
        execute if score #hud_types un_ctx matches 37.. run function uno:hud/line {row:1,y:60,count_y:48}
        execute if score #hud_types un_ctx matches 37.. run function uno:hud/line {row:2,y:108,count_y:96}
        execute if score #hud_types un_ctx matches 0 run function uno:hud/no_cards
        function uno:hud/status
        scoreboard players operation panel_id fbt_io = @s un_panel
        function fimel_title:replace_panel
        scoreboard players operation @s fbt_panel = @s un_panel
    """)
    put("cards", "\n".join(
        f"scoreboard players set #hud_count un_ctx 0\n"
        f"execute as @e[type=minecraft:marker,tag=un.hudhand,scores={{un_card={index}}}] run scoreboard players add #hud_count un_ctx 1\n"
        f"execute if score #hud_count un_ctx matches 1.. run function uno:hud/card {{id:{index},glyph:\"{chr(0xE600 + index)}\",selected:\"{chr(0xE700 + index)}\"}}"
        for index in range(54)))
    put("card", """
        execute if score #hud_col un_ctx matches 18 run function uno:hud/next_row
        execute store result storage uno:hud row int 1 run scoreboard players get #hud_row un_ctx
        execute store result storage uno:hud count int 1 run scoreboard players get #hud_count un_ctx
        $data modify storage uno:hud card set value {text:"$(glyph)",color:"white"}
        $execute if score #hud_pick un_ctx matches $(id) run data modify storage uno:hud card.text set value "$(selected)"
        function uno:hud/append with storage uno:hud
        scoreboard players add #hud_col un_ctx 1
        scoreboard players add #hud_types un_ctx 1
    """)
    put("next_row", """
        scoreboard players add #hud_row un_ctx 1
        scoreboard players set #hud_col un_ctx 0
    """)
    put("append", """
        $data modify storage uno:hud rows[$(row)].cards.extra append from storage uno:hud card
        $data modify storage uno:hud rows[$(row)].cards.extra append value {text:"\uE7F0"}
        $data modify storage uno:hud rows[$(row)].counts.extra append value {text:"x$(count)",color:"white"}
        $data modify storage uno:hud rows[$(row)].counts.extra append value {text:"\uE7F1"}
    """)
    put("line", """
        $data modify storage fimel_title:io text set from storage uno:hud rows[$(row)].cards
        # 交叠行最后一张保留完整牌面宽度，避免居中时偏右或裁掉末牌。
        data modify storage fimel_title:io text.extra append value {text:"\uE7F2"}
        $data modify storage fimel_title:io y set value $(y).0d
        function uno:hud/text_cards
        $data modify storage fimel_title:io text set from storage uno:hud rows[$(row)].counts
        data modify storage fimel_title:io text.extra prepend value {text:"\uE7F3"}
        data modify storage fimel_title:io text.extra append value {text:"\uE7F4"}
        $data modify storage fimel_title:io y set value $(count_y).0d
        function uno:hud/text_cards
    """)
    put("text_cards", """
        data modify storage fimel_title:io font set value "card:uno/hud"
        data modify storage fimel_title:io neg_font set value "card:uno/hud_neg"
        execute if score #hud_types un_ctx matches 9..18 run data modify storage fimel_title:io font set value "card:uno/hud_dense"
        execute if score #hud_types un_ctx matches 9..18 run data modify storage fimel_title:io neg_font set value "card:uno/hud_dense_neg"
        execute if score #hud_types un_ctx matches 19..36 run data modify storage fimel_title:io font set value "card:uno/hud_medium"
        execute if score #hud_types un_ctx matches 19..36 run data modify storage fimel_title:io neg_font set value "card:uno/hud_medium_neg"
        execute if score #hud_types un_ctx matches 37..54 run data modify storage fimel_title:io font set value "card:uno/hud_small"
        execute if score #hud_types un_ctx matches 37..54 run data modify storage fimel_title:io neg_font set value "card:uno/hud_small_neg"
        function uno:hud/text
    """)
    put("text_default", """
        data modify storage fimel_title:io font set value "minecraft:default_mod"
        data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
        function uno:hud/text
    """)
    put("text", """
        data modify storage fimel_title:io x set value 0.0d
        data modify storage fimel_title:io dx set value 0.0d
        data modify storage fimel_title:io dy set value 0.0d
        data modify storage fimel_title:io align set value "middle"
        data modify storage fimel_title:io origin set value "default"
        function fimel_title:new_text
    """)
    put("no_cards", """
        data modify storage fimel_title:io text set value {text:"暂无手牌",color:"gray",shadow_color:0}
        execute if score @e[tag=un.current,limit=1] un_state matches 1 run data modify storage fimel_title:io text.text set value "正在发牌…"
        data modify storage fimel_title:io y set value 12.0d
        function uno:hud/text_default
    """)
    put("status", """
        data modify storage fimel_title:io text set value {text:"UNO · ",color:"gold",shadow_color:0,extra:[]}
        execute if score @e[tag=un.current,limit=1] un_state matches 1 run data modify storage fimel_title:io text.extra append value {text:"正在发牌",color:"yellow"}
        execute if score @e[tag=un.current,limit=1] un_state matches 2 if score @s un_seat = @e[tag=un.current,limit=1] un_turn run data modify storage fimel_title:io text.extra append value {text:"轮到你",color:"green"}
        execute if score @e[tag=un.current,limit=1] un_state matches 2 unless score @s un_seat = @e[tag=un.current,limit=1] un_turn run data modify storage fimel_title:io text.extra append value {text:"等待出牌",color:"gray"}
        execute if score @e[tag=un.current,limit=1] un_state matches 3 run data modify storage fimel_title:io text.extra append value {text:"抓 UNO／补喊窗口",color:"yellow"}
        execute if score @e[tag=un.current,limit=1] un_state matches 4 run data modify storage fimel_title:io text.extra append value {text:"等待接受／质疑 +4",color:"yellow"}
        execute if score @e[tag=un.current,limit=1] un_state matches 5 run data modify storage fimel_title:io text.extra append value {text:"本局结束",color:"gold"}
        data modify storage fimel_title:io text.extra append value {text:" · ",color:"dark_gray"}
        execute if score @e[tag=un.current,limit=1] un_color matches 0 run data modify storage fimel_title:io text.extra append value {text:"红色",color:"red"}
        execute if score @e[tag=un.current,limit=1] un_color matches 1 run data modify storage fimel_title:io text.extra append value {text:"黄色",color:"yellow"}
        execute if score @e[tag=un.current,limit=1] un_color matches 2 run data modify storage fimel_title:io text.extra append value {text:"绿色",color:"green"}
        execute if score @e[tag=un.current,limit=1] un_color matches 3 run data modify storage fimel_title:io text.extra append value {text:"蓝色",color:"blue"}
        execute if score @e[tag=un.current,limit=1] un_dir matches 1 run data modify storage fimel_title:io text.extra append value {text:" · 顺时针",color:"gray"}
        execute if score @e[tag=un.current,limit=1] un_dir matches -1 run data modify storage fimel_title:io text.extra append value {text:" · 逆时针",color:"gray"}
        data modify storage fimel_title:io y set value 76.0d
        execute if score #hud_types un_ctx matches 0 run data modify storage fimel_title:io y set value 36.0d
        execute if score #hud_types un_ctx matches 19..36 run data modify storage fimel_title:io y set value 120.0d
        execute if score #hud_types un_ctx matches 37..54 run data modify storage fimel_title:io y set value 152.0d
        function uno:hud/text_default
    """)


def fonts(resource_pack: Path) -> None:
    target = resource_pack / "assets/card/font/uno"
    target.mkdir(parents=True, exist_ok=True)
    definitions = {}
    for layout, (height, advance, gap, count_gap, tail, lead_count, tail_count) in LAYOUTS.items():
        spacing = dict(zip("\uE7F0\uE7F1\uE7F2\uE7F3\uE7F4", (gap, count_gap, tail, lead_count, tail_count)))
        providers = []
        # BetterTitle 的居中回绕字体必须等于真实 advance 的负二分之一；
        # 交叠使用的负间距在回绕字体中对应正值。
        advances = {glyph: -width / 2 for glyph, width in spacing.items()}
        for base, prefix in [(0xE600, ""), (0xE700, "selected/")]:
            for index, name in enumerate(NAMES):
                glyph = chr(base + index)
                providers.append({"type": "bitmap", "file": f"card:font/uno/{prefix}{name}.png", "height": height, "ascent": height, "chars": [glyph]})
                advances[glyph] = -advance / 2
        providers += [{"type": "space", "advances": spacing}, {"type": "reference", "id": "minecraft:default_mod"}]
        definitions[layout + ".json"] = {"providers": providers}
        definitions[layout + "_neg.json"] = {"providers": [{"type": "space", "advances": advances}, {"type": "reference", "id": "minecraft:default_neg"}]}
    for name, definition in definitions.items():
        (target / name).write_text(json.dumps(definition, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--resource-pack", type=Path, default=PACK.parents[3] / "resourcepacks/fimelcard-rp")
    args = parser.parse_args()
    functions()
    fonts(args.resource_pack)
    print("Generated UNO BetterTitle HUD functions and fonts.")


if __name__ == "__main__":
    main()
