"""Build the chess board, embedded NyaaWorks pieces and table display functions.

Run from anywhere.  Pillow is required.  After the first export the preserved
models in resourcepack/.source/chess make rebuilding independent of NyaaWorks.
All world positions are relative to the cardtable controller.
"""
from __future__ import annotations

import copy
import hashlib
import itertools
import json
import math
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[1]
GAME = ROOT / "data/chess/function/visual"
VERSION = ROOT.parents[3]
RP = VERSION / "resourcepacks/fimelcard-rp"
UPSTREAM = VERSION / "resourcepacks/NyaaWorks喵工坊-r2.2-fixed/assets/minecraft/models/item/nw/chess"
SOURCE = RP / ".source/chess"
ASSETS = RP / "assets/card"
PIECES = {1: "pawn", 2: "knight", 3: "bishop", 4: "rook", 5: "queen", 6: "king"}
BOARDS = {
    "classic": ("#eeeae0", "#383b40", "#e9e6df", "#33363a"),
    "green": ("#eeeed2", "#769656", "#d5ddbb", "#425735"),
    "wood": ("#f0d9b5", "#b58863", "#d5ba93", "#654b37"),
    "blue": ("#dee3e6", "#8ca2ad", "#d3dce0", "#435661"),
    "purple": ("#e8e1ee", "#9277ac", "#d5c9e2", "#574368"),
}
PALETTES = {
    "ebony": ("#f0e8d6", "#30333a"),
    "walnut": ("#e5bd83", "#704832"),
    "ice": ("#e8f6ff", "#37678e"),
    "jade": ("#f2e7bf", "#327e68"),
}
LAYOUTS = {4: {"step": .27, "piece_scale": .39}, 8: {"step": .37, "piece_scale": .53}}
SEAT_EDGES = {4: {1: 2, 2: 3, 3: 0, 4: 1}, 8: {1: 2, 2: 2, 3: 3, 4: 3, 5: 0, 6: 0, 7: 1, 8: 1}}


def text_file(path: Path, contents: str):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(contents.strip() + "\n", encoding="utf-8")


def json_file(path: Path, obj):
    text_file(path, json.dumps(obj, ensure_ascii=False, indent=2))


def function(name: str, contents: str):
    text_file(GAME / (name + ".mcfunction"), contents)


def f(value: float):
    return f"{value:.7f}".rstrip("0").rstrip(".") if value else "0.0"


def nbt_vector(values):
    return "[" + ",".join(f(v) + "f" for v in values) + "]"


def rotate(x, z, orient):
    return (-z, x) if orient else (x, z)


def square_position(square, capacity, orient):
    step = LAYOUTS[capacity]["step"]
    return rotate((square % 8 - 3.5) * step, (3.5 - square // 8) * step, orient)


def hit_dimensions(piece, capacity):
    """Return a narrow hitbox covering every transformed source-model corner."""
    model = json.loads((SOURCE / "nyaaworks" / f"chess_white_{PIECES[abs(piece)]}.json").read_text(encoding="utf-8"))
    points = []
    for element in model["elements"]:
        for corner in itertools.product(*zip(element["from"], element["to"])):
            point = list(corner)
            rotation = element.get("rotation", {})
            angle = math.radians(rotation.get("angle", 0))
            origin = rotation.get("origin", [8, 8, 8])
            i, j = {"x": (1, 2), "y": (2, 0), "z": (0, 1)}[rotation.get("axis", "y")]
            a, b = point[i] - origin[i], point[j] - origin[j]
            point[i] = origin[i] + a * math.cos(angle) - b * math.sin(angle)
            point[j] = origin[j] + a * math.sin(angle) + b * math.cos(angle)
            points.append(point)
    scale = LAYOUTS[capacity]["piece_scale"]
    radius = max(abs(point[index] - 8) for point in points for index in (0, 2)) / 16 * scale
    height = max(point[1] for point in points) / 16 * scale
    return radius * 2 + .006, height + .015


def export_resourcepack():
    """Keep upstream meshes and replace their vanilla-block materials locally."""
    manifest = {"source": "NyaaWorks 喵工坊 r2.2 / 16bit制作组", "models": []}
    for side in ("white", "black"):
        for piece in PIECES.values():
            original_name = f"chess_{side}_{piece}.json"
            preserved = SOURCE / "nyaaworks" / original_name
            if preserved.exists():
                model_text = preserved.read_text(encoding="utf-8")
            else:
                model_text = (UPSTREAM / original_name).read_text(encoding="utf-8")
                text_file(preserved, model_text)
            original = json.loads(model_text)
            manifest["models"].append({"file": original_name, "sha256": hashlib.sha256(model_text.encode("utf-8")).hexdigest(), "original_textures": original.get("textures", {})})
            # Geometry is intentionally retained, including the recognisable
            # horse profile.  "none" display avoids upstream furniture scaling.
            for palette in PALETTES:
                resource = f"chess/{palette}/{side}_{piece}"
                model = copy.deepcopy(original)
                model["textures"] = {key: f"card:item/chess/{palette}/{side}" for key in original["textures"]}
                model["gui_light"] = "front"
                json_file(ASSETS / f"models/item/{resource}.json", model)
                json_file(ASSETS / f"items/{resource}.json", {"model": {"type": "minecraft:model", "model": f"card:item/{resource}"}})
    json_file(SOURCE / "source_manifest.json", manifest)

    for palette, colors in PALETTES.items():
        for side, color in zip(("white", "black"), colors):
            base = tuple(bytes.fromhex(color[1:]))
            image = Image.new("RGB", (16, 16), base)
            # Restrained pixel grain keeps the original block-model faces
            # readable at table scale without adding noisy high-frequency art.
            for y in range(16):
                for x in range(16):
                    grain = ((x * 17 + y * 11) % 7) - 3
                    if palette == "walnut":
                        grain += 4 if y % 5 == 0 else -1
                    image.putpixel((x, y), tuple(max(0, min(255, v + grain)) for v in base))
            target = ASSETS / f"textures/item/chess/{palette}/{side}.png"
            target.parent.mkdir(parents=True, exist_ok=True)
            image.save(target)

    font = ImageFont.load_default(size=10)
    for name, (light, dark, border, ink) in BOARDS.items():
        image = Image.new("RGB", (280, 280), border)
        draw = ImageDraw.Draw(image)
        for rank in range(8):
            for file in range(8):
                # a8 is light; h1 is light, as required by the rules.
                fill = light if (rank + file) % 2 == 0 else dark
                x, y = 12 + file * 32, 12 + rank * 32
                draw.rectangle((x, y, x + 31, y + 31), fill=fill)
        draw.rectangle((11, 11, 268, 268), outline=ink, width=1)
        for index in range(8):
            center = 28 + 32 * index
            top_label = Image.new("RGB", (12, 12), border)
            ImageDraw.Draw(top_label).text((6, 6), chr(97 + index), font=font, fill=ink, anchor="mm")
            image.paste(top_label.rotate(180), (center - 6, 0))
            draw.text((center, 274), chr(97 + index), font=font, fill=ink, anchor="mm")
            draw.text((5, center), str(8 - index), font=font, fill=ink, anchor="mm")
            right_label = Image.new("RGB", (12, 12), border)
            ImageDraw.Draw(right_label).text((6, 6), str(8 - index), font=font, fill=ink, anchor="mm")
            image.paste(right_label.rotate(180), (268, center - 6))
        # Opposite-side labels must not erase the thin playing-area outline.
        draw.rectangle((11, 11, 268, 268), outline=ink, width=1)
        target = ASSETS / f"textures/item/chess/board_{name}.png"
        target.parent.mkdir(parents=True, exist_ok=True)
        image.save(target)
        # A single textured mesh replaces 64 extra block displays.  The label
        # border is exactly 12/256 of the playing area on each side.
        texture = f"card:item/chess/board_{name}"
        json_file(ASSETS / f"models/item/chess/board_{name}.json", {
            "textures": {"board": texture, "particle": texture},
            "elements": [{"from": [0, 0, 0], "to": [16, .05, 16], "faces": {face: {"texture": "#board", "uv": [0, 0, 16, 16]} for face in ("up", "down", "north", "east", "south", "west")}}],
        })
        json_file(ASSETS / f"items/chess/board_{name}.json", {"model": {"type": "minecraft:model", "model": f"card:item/chess/board_{name}"}})

    # Selected-square outline is native mesh geometry, with no texture to load.
    elements = []
    for start, end in [([0, 0, 0], [16, .05, .8]), ([0, 0, 15.2], [16, .05, 16]), ([0, 0, .8], [.8, .05, 15.2]), ([15.2, 0, .8], [16, .05, 15.2])]:
        elements.append({"from": start, "to": end, "faces": {face: {"texture": "#gold"} for face in ("up", "down", "north", "east", "south", "west")}})
    json_file(ASSETS / "models/item/chess/selection.json", {"textures": {"gold": "minecraft:block/gold_block", "particle": "minecraft:block/gold_block"}, "elements": elements})
    json_file(ASSETS / "items/chess/selection.json", {"model": {"type": "minecraft:model", "model": "card:item/chess/selection"}})
    # Legal destinations use the same clean outline geometry in emerald green.
    json_file(ASSETS / "models/item/chess/hint.json", {"textures": {"gold": "minecraft:block/emerald_block", "particle": "minecraft:block/emerald_block"}, "elements": elements})
    json_file(ASSETS / "items/chess/hint.json", {"model": {"type": "minecraft:model", "model": "card:item/chess/hint"}})
    # A compact, deterministic contact sheet makes palette review possible
    # without copying preview-only files into runtime assets.
    preview = Image.new("RGB", (280 * len(BOARDS), 312), "#24262b")
    draw = ImageDraw.Draw(preview)
    for index, name in enumerate(BOARDS):
        preview.paste(Image.open(ASSETS / f"textures/item/chess/board_{name}.png"), (280 * index, 24))
        draw.text((280 * index + 140, 11), name, anchor="mm", fill="white")
    SOURCE.mkdir(parents=True, exist_ok=True)
    preview.save(SOURCE / "board-palettes.png")


def export_functions():
    from build_chess_hints import build as build_hints
    build_hints(ROOT)
    function("context", """
# 同步调用专用上下文；不得将 #vis_* 跨刻使用。
scoreboard players operation #vis_table ch_ctx = @s ct_id
scoreboard players operation #vis_cap ch_ctx = @s ct_capacity
scoreboard players operation #vis_orient ch_ctx = @s ch_orient
scoreboard players operation #vis_palette ch_ctx = @s ch_palette
scoreboard players operation #vis_board ch_ctx = @s ch_board
scoreboard players operation #vis_white ch_ctx = @s ch_white
scoreboard players operation #vis_black ch_ctx = @s ch_black
data modify storage chess:visual palette set value "ebony"
data modify storage chess:visual board set value "classic"
""" + "\n".join(f'execute if score #vis_palette ch_ctx matches {index} run data modify storage chess:visual palette set value "{name}"' for index, name in enumerate(PALETTES)) + "\n" + "\n".join(f'execute if score #vis_board ch_ctx matches {index} run data modify storage chess:visual board set value "{name}"' for index, name in enumerate(BOARDS)) + "\n" + "\n".join([
        "scoreboard players operation #vis_wedge ch_ctx = #vis_orient ch_ctx",
        "scoreboard players operation #vis_bedge ch_ctx = #vis_orient ch_ctx",
        "scoreboard players add #vis_bedge ch_ctx 2",
    ] + [f"execute if score #vis_cap ch_ctx matches {cap} if score #vis_{side} ch_ctx matches {seat} run scoreboard players set #vis_{edge_side}edge ch_ctx {edge}" for cap,edges in SEAT_EDGES.items() for seat,edge in edges.items() for side,edge_side in [("white","w"),("black","b")]] + [
        "scoreboard players set #vis_overlap ch_ctx 0",
        "execute if score #vis_wedge ch_ctx = #vis_bedge ch_ctx run scoreboard players set #vis_overlap ch_ctx 1",
    ]))
    function("clear", """
scoreboard players operation #vis_table ch_ctx = @s ct_id
execute as @e[tag=ch.visual] if score @s ct_id = #vis_table ch_ctx run kill @s
""")
    function("clear_board", """
# 刷新布局不影响时钟，不删除规则棋格 marker 或其他桌的任何实体。
scoreboard players operation #vis_table ch_ctx = @s ct_id
execute as @e[tag=ch.visual,tag=!ch.clock] if score @s ct_id = #vis_table ch_ctx run kill @s
""")
    function("setup", """
# 新局／新预览入口；重载已有对局请使用 refresh。
data modify entity @s data.chess.captured set value []
scoreboard players set @s ch_wcapt 0
scoreboard players set @s ch_bcapt 0
function chess:visual/refresh
""")
    function("refresh", """
function chess:visual/clear_board
function chess:visual/context
scoreboard players set #vis_duration ch_ctx 0
execute positioned ~ ~1.02 ~ summon minecraft:item_display run function chess:visual/board with storage chess:visual
execute if score #vis_cap ch_ctx matches 4 if score #vis_orient ch_ctx matches 0 run function chess:visual/cells4_0
execute if score #vis_cap ch_ctx matches 4 if score #vis_orient ch_ctx matches 1 run function chess:visual/cells4_1
execute if score #vis_cap ch_ctx matches 8 if score #vis_orient ch_ctx matches 0 run function chess:visual/cells8_0
execute if score #vis_cap ch_ctx matches 8 if score #vis_orient ch_ctx matches 1 run function chess:visual/cells8_1
execute as @e[type=minecraft:marker,tag=ch.square] if score @s ct_id = #vis_table ch_ctx unless score @s ch_piece matches 0 run function chess:visual/spawn_man
data modify storage chess:visual restore set from entity @s data.chess.captured
execute if data storage chess:visual restore[0] run function chess:visual/restore_captured
function chess:visual/select
""")
    function("board", """
# ItemDisplayRenderer 在模型前固定旋转 Y 180°；右旋抵消它，保留上表面 UV 与逻辑格一致。
tag @s add ch.visual
tag @s add ch.board_display
scoreboard players operation @s ct_id = #vis_table ch_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:chess/board_$(board)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f}
""" + "\n".join(f'execute if score #vis_cap ch_ctx matches {cap} if score #vis_orient ch_ctx matches {orient} run data merge entity @s {{transformation:{{translation:{nbt_vector([0, cfg["step"] * 8 * 280 / 256 * .5, 0])},left_rotation:{nbt_vector([0, -math.sin(orient*math.pi/4), 0, math.cos(orient*math.pi/4)])},right_rotation:[0f,1f,0f,0f],scale:' + nbt_vector([cfg["step"] * 8 * 280 / 256]*3) + '}}' for cap,cfg in LAYOUTS.items() for orient in range(2)))
    function("cell", """
tag @s add ch.visual
tag @s add ch.cell
tag @s add ch.tile
scoreboard players operation @s ct_id = #vis_table ch_ctx
scoreboard players operation @s ch_sq = #vis_sq ch_ctx
data merge entity @s {height:0.025f,response:1b}
execute if score #vis_cap ch_ctx matches 4 run data merge entity @s {width:0.266f}
execute if score #vis_cap ch_ctx matches 8 run data merge entity @s {width:0.366f}
""")
    for cap in LAYOUTS:
        for orient in range(2):
            lines = []
            for square in range(64):
                x,z=square_position(square,cap,orient)
                lines += [f"scoreboard players set #vis_sq ch_ctx {square}", f"execute positioned ~{f(x)} ~1.025 ~{f(z)} summon minecraft:interaction run function chess:visual/cell"]
            function(f"cells{cap}_{orient}", "\n".join(lines))

    function("spawn_man", """
scoreboard players operation #vis_piece ch_ctx = @s ch_piece
scoreboard players operation #vis_sq ch_ctx = @s ch_sq
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function chess:visual/man_init
function chess:visual/spawn_hit with storage chess:visual
""")
    function("spawn_hit", '$execute positioned ~$(x) ~1.035 ~$(z) summon minecraft:interaction run function chess:visual/hit_init')
    function("hit_init", """
tag @s add ch.visual
tag @s add ch.cell
tag @s add ch.piece_hit
scoreboard players operation @s ct_id = #vis_table ch_ctx
scoreboard players operation @s ch_sq = #vis_sq ch_ctx
scoreboard players operation @s ch_piece = #vis_piece ch_ctx
data merge entity @s {response:1b}
function chess:visual/hit_shape
""")
    shape = []
    for cap in LAYOUTS:
        for piece in PIECES:
            width, height = hit_dimensions(piece, cap)
            for sign in (1, -1):
                shape.append(f'execute if score #vis_cap ch_ctx matches {cap} if score @s ch_piece matches {piece * sign} run data merge entity @s {{width:{f(width)}f,height:{f(height)}f}}')
    function("hit_shape", "\n".join(shape))
    function("move_hit", """
# 执行位置继承桌心；只将本桌该棋子的命中区迁到已提交的终点。
$tp @s ~$(x) ~1.035 ~$(z)
scoreboard players operation @s ch_sq = #vis_sq ch_ctx
scoreboard players operation @s ch_piece = #vis_piece ch_ctx
function chess:visual/hit_shape
""")
    function("man_init", """
tag @s add ch.visual
tag @s add ch.man
scoreboard players operation @s ct_id = #vis_table ch_ctx
scoreboard players operation @s ch_sq = #vis_sq ch_ctx
scoreboard players operation @s ch_piece = #vis_piece ch_ctx
scoreboard players set @s ch_owner 0
scoreboard players set @s ch_slot -1
data merge entity @s {item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f}
function chess:visual/man_model
function chess:visual/man_pose
""")
    model_lines=[]
    for side,sign in [("white",1),("black",-1)]:
        for value,name in PIECES.items():
            model_lines.append(f'execute if score @s ch_piece matches {sign*value} run data modify storage chess:visual man set value "{side}_{name}"')
    model_lines += ["function chess:visual/set_model with storage chess:visual"]
    function("man_model", "\n".join(model_lines))
    function("set_model", '$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:chess/$(palette)/$(man)"}}}')

    pose_lines=["scoreboard players operation #vis_sq ch_ctx = @s ch_sq", "execute store result storage chess:visual duration int 1 run scoreboard players get #vis_duration ch_ctx"]
    coordinate_routes = []
    for cap,config in LAYOUTS.items():
        scale=config["piece_scale"]
        pose_lines += [f'execute if score #vis_cap ch_ctx matches {cap} run data modify storage chess:visual scale set value {f(scale)}', f'execute if score #vis_cap ch_ctx matches {cap} run data modify storage chess:visual lift set value {f(scale*.5)}']
        for orient in range(2):
            coordinates = []
            for square in range(64):
                x,z=square_position(square,cap,orient)
                coordinates.append(f'execute if score #vis_sq ch_ctx matches {square} run data modify storage chess:visual coord set value {{x:{f(x)},z:{f(z)}}}')
            function(f"coordinates{cap}_{orient}", "\n".join(coordinates))
            coordinate_routes.append(f"execute if score #vis_cap ch_ctx matches {cap} if score #vis_orient ch_ctx matches {orient} run function chess:visual/coordinates{cap}_{orient}")
    function("resolve_square", "\n".join(coordinate_routes))
    pose_lines += ["function chess:visual/resolve_square", "data modify storage chess:visual x set from storage chess:visual coord.x", "data modify storage chess:visual z set from storage chess:visual coord.z", "function chess:visual/man_rotation", "function chess:visual/set_pose with storage chess:visual"]
    function("man_pose", "\n".join(pose_lines))
    rotation=["# 王额外水平旋转 90°，马额外水平旋转 180°；统一处理摆放、移动、吃子及重建。"]
    for orient in range(2):
        for side,score in [(1,"1.."),(-1,"..-1")]:
            yaw=(-90 if side==1 else 90)-orient*90
            rotation.append(f'execute if score #vis_orient ch_ctx matches {orient} if score @s ch_piece matches {score} run data modify storage chess:visual rotation set value {{qy:{f(math.sin(math.radians(yaw/2)))},qw:{f(math.cos(math.radians(yaw/2)))}}}')
            king_yaw = yaw + 90
            rotation.append(f'execute if score #vis_orient ch_ctx matches {orient} if score @s ch_piece matches {side * 6} run data modify storage chess:visual rotation set value {{qy:{f(math.sin(math.radians(king_yaw/2)))},qw:{f(math.cos(math.radians(king_yaw/2)))}}}')
            knight_yaw = yaw + 180
            rotation.append(f'execute if score #vis_orient ch_ctx matches {orient} if score @s ch_piece matches {side * 2} run data modify storage chess:visual rotation set value {{qy:{f(math.sin(math.radians(knight_yaw/2)))},qw:{f(math.cos(math.radians(knight_yaw/2)))}}}')
    rotation += ["data modify storage chess:visual qy set from storage chess:visual rotation.qy", "data modify storage chess:visual qw set from storage chess:visual rotation.qw"]
    function("man_rotation", "\n".join(rotation))
    function("set_pose", '$data merge entity @s {start_interpolation:0,interpolation_duration:$(duration),transformation:{translation:[$(x)f,$(lift)f,$(z)f],left_rotation:[0f,$(qy)f,0f,$(qw)f],right_rotation:[0f,0f,0f,1f],scale:[$(scale)f,$(scale)f,$(scale)f]}}')

    function("select", """
function chess:visual/context
execute as @e[tag=ch.highlight] if score @s ct_id = #vis_table ch_ctx run kill @s
scoreboard players operation #vis_sq ch_ctx = @s ch_sel
execute if score #vis_sq ch_ctx matches 0..63 positioned ~ ~1.035 ~ summon minecraft:item_display run function chess:visual/highlight
function chess:hints/refresh
""")
    highlight=["tag @s add ch.visual", "tag @s add ch.highlight", "scoreboard players operation @s ct_id = #vis_table ch_ctx", "scoreboard players operation @s ch_sq = #vis_sq ch_ctx", 'data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:chess/selection"}},item_display:"none",brightness:{block:15,sky:15},Glowing:1b,glow_color_override:16766720,shadow_radius:0f,view_range:24f}']
    for cap,cfg in LAYOUTS.items():
        for orient in range(2):
            for square in range(64):
                x,z=square_position(square,cap,orient)
                highlight.append(f'execute if score #vis_cap ch_ctx matches {cap} if score #vis_orient ch_ctx matches {orient} if score #vis_sq ch_ctx matches {square} run data merge entity @s {{transformation:{{translation:{nbt_vector([x,cfg["step"]*.5,z])},scale:' + nbt_vector([cfg["step"]]*3) + '}}')
    function("highlight", "\n".join(highlight))

    function("move", """
# 规则 marker 已提交；显示实体仍停在旧位置。所有临时状态在本函数链中消费。
function chess:visual/context
scoreboard players set #vis_duration ch_ctx 8
scoreboard players set #vis_capture ch_ctx -1
scoreboard players set #vis_rook_from ch_ctx -1
scoreboard players set #vis_rook_to ch_ctx -1
scoreboard players set #vis_promotion ch_ctx 0
execute store result score #vis_from ch_ctx run data get entity @s data.chess.last.from
execute store result score #vis_to ch_ctx run data get entity @s data.chess.last.to
execute store result score #vis_piece ch_ctx run data get entity @s data.chess.last.piece
execute store result score #vis_taken ch_ctx run data get entity @s data.chess.last.captured
execute store result score #vis_capture ch_ctx run data get entity @s data.chess.last.capture_sq
execute store result score #vis_rook_from ch_ctx run data get entity @s data.chess.last.rook_from
execute store result score #vis_rook_to ch_ctx run data get entity @s data.chess.last.rook_to
execute store result score #vis_promotion ch_ctx run data get entity @s data.chess.last.promotion
scoreboard players set #vis_owner ch_ctx 1
execute if score #vis_piece ch_ctx matches ..-1 run scoreboard players set #vis_owner ch_ctx -1
execute unless score #vis_taken ch_ctx matches 0 if score #vis_capture ch_ctx matches 0..63 run function chess:visual/capture
execute as @e[type=minecraft:item_display,tag=ch.man,tag=!ch.captured] if score @s ct_id = #vis_table ch_ctx if score @s ch_sq = #vis_from ch_ctx run function chess:visual/move_man
execute if score #vis_rook_from ch_ctx matches 0..63 as @e[type=minecraft:item_display,tag=ch.man,tag=!ch.captured] if score @s ct_id = #vis_table ch_ctx if score @s ch_sq = #vis_rook_from ch_ctx run function chess:visual/move_rook
function chess:visual/select
""")
    function("move_man", """
tag @s add ch.moving
scoreboard players operation @s ch_sq = #vis_to ch_ctx
execute if score #vis_promotion ch_ctx matches ..-1 run scoreboard players operation #vis_promotion ch_ctx *= #vis_owner ch_ctx
execute if score #vis_promotion ch_ctx matches 2..5 run scoreboard players operation @s ch_piece = #vis_promotion ch_ctx
execute if score #vis_promotion ch_ctx matches 2..5 run scoreboard players operation @s ch_piece *= #vis_owner ch_ctx
function chess:visual/man_model
function chess:visual/man_pose
scoreboard players operation #vis_piece ch_ctx = @s ch_piece
execute as @e[type=minecraft:interaction,tag=ch.piece_hit] if score @s ct_id = #vis_table ch_ctx if score @s ch_sq = #vis_from ch_ctx run function chess:visual/move_hit with storage chess:visual
""")
    function("move_rook", """
tag @s add ch.moving
scoreboard players operation @s ch_sq = #vis_rook_to ch_ctx
function chess:visual/man_pose
scoreboard players operation #vis_piece ch_ctx = @s ch_piece
execute as @e[type=minecraft:interaction,tag=ch.piece_hit] if score @s ct_id = #vis_table ch_ctx if score @s ch_sq = #vis_rook_from ch_ctx run function chess:visual/move_hit with storage chess:visual
""")
    function("finish_move", """
scoreboard players operation #vis_table ch_ctx = @s ct_id
execute as @e[tag=ch.man,tag=ch.moving] if score @s ct_id = #vis_table ch_ctx run tag @s remove ch.moving
""")
    function("capture", """
scoreboard players set #vis_slot ch_ctx 0
execute if score #vis_owner ch_ctx matches 1 run scoreboard players operation #vis_slot ch_ctx = @s ch_wcapt
execute if score #vis_owner ch_ctx matches -1 run scoreboard players operation #vis_slot ch_ctx = @s ch_bcapt
data modify storage chess:visual captured set value {piece:0,owner:0,slot:0}
execute store result storage chess:visual captured.piece int 1 run scoreboard players get #vis_taken ch_ctx
execute store result storage chess:visual captured.owner int 1 run scoreboard players get #vis_owner ch_ctx
execute store result storage chess:visual captured.slot int 1 run scoreboard players get #vis_slot ch_ctx
data modify entity @s data.chess.captured append from storage chess:visual captured
execute if score #vis_owner ch_ctx matches 1 run scoreboard players add @s ch_wcapt 1
execute if score #vis_owner ch_ctx matches -1 run scoreboard players add @s ch_bcapt 1
execute as @e[type=minecraft:interaction,tag=ch.piece_hit] if score @s ct_id = #vis_table ch_ctx if score @s ch_sq = #vis_capture ch_ctx run kill @s
execute as @e[type=minecraft:item_display,tag=ch.man,tag=!ch.captured] if score @s ct_id = #vis_table ch_ctx if score @s ch_sq = #vis_capture ch_ctx run function chess:visual/capture_man
""")
    function("capture_man", """
tag @s add ch.captured
tag @s add ch.moving
scoreboard players set @s ch_sq -1
scoreboard players operation @s ch_owner = #vis_owner ch_ctx
scoreboard players operation @s ch_slot = #vis_slot ch_ctx
function chess:visual/captured_pose
""")
    function("restore_captured", """
execute store result score #vis_piece ch_ctx run data get storage chess:visual restore[0].piece
execute store result score #vis_owner ch_ctx run data get storage chess:visual restore[0].owner
execute store result score #vis_slot ch_ctx run data get storage chess:visual restore[0].slot
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function chess:visual/restore_man
data remove storage chess:visual restore[0]
execute if data storage chess:visual restore[0] run function chess:visual/restore_captured
""")
    function("restore_man", """
tag @s add ch.visual
tag @s add ch.man
tag @s add ch.captured
scoreboard players operation @s ct_id = #vis_table ch_ctx
scoreboard players operation @s ch_piece = #vis_piece ch_ctx
scoreboard players operation @s ch_owner = #vis_owner ch_ctx
scoreboard players operation @s ch_slot = #vis_slot ch_ctx
scoreboard players set @s ch_sq -1
data merge entity @s {item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f}
function chess:visual/man_model
function chess:visual/captured_pose
""")
    # Translate real seat to the edge at that viewer's right.  Edge 0=east,
    # 1=south, 2=west, 3=north.  Preview/no-seat falls back to board sides.
    captures=["scoreboard players operation #vis_slot ch_ctx = @s ch_slot", "scoreboard players operation #vis_owner ch_ctx = @s ch_owner", "execute store result storage chess:visual duration int 1 run scoreboard players get #vis_duration ch_ctx", "execute if score #vis_owner ch_ctx matches 1 run scoreboard players operation #vis_edge ch_ctx = #vis_wedge ch_ctx", "execute if score #vis_owner ch_ctx matches -1 run scoreboard players operation #vis_edge ch_ctx = #vis_bedge ch_ctx"]
    for cap,cfg in LAYOUTS.items():
        scale=.205 if cap==4 else .275
        captures += [f'execute if score #vis_cap ch_ctx matches {cap} run data modify storage chess:visual scale set value {f(scale)}', f'execute if score #vis_cap ch_ctx matches {cap} run data modify storage chess:visual lift set value {f(scale*.5)}']
        # At most 15 men of each army can be captured.  Two narrow rows leave
        # the entire edge and labelled border inside the tabletop footprint.
        for slot in range(15):
            outward=(1.285 if cap==4 else 1.72)+(slot//8)*(.13 if cap==4 else .17)
            along=(slot%8-3.5)*(.27 if cap==4 else .37)
            for edge in range(4):
                x,z=[(outward,along),(-along,outward),(-outward,-along),(along,-outward)][edge]
                captures.append(f'execute if score #vis_cap ch_ctx matches {cap} if score #vis_edge ch_ctx matches {edge} if score #vis_slot ch_ctx matches {slot} run data modify storage chess:visual coord set value {{x:{f(x)},z:{f(z)}}}')
        shared_scale = .10 if cap == 4 else .14
        captures += [f'execute if score #vis_cap ch_ctx matches {cap} if score #vis_overlap ch_ctx matches 1 run data modify storage chess:visual scale set value {f(shared_scale)}', f'execute if score #vis_cap ch_ctx matches {cap} if score #vis_overlap ch_ctx matches 1 run data modify storage chess:visual lift set value {f(shared_scale*.5)}']
        for side in (1,-1):
            for slot in range(15):
                outward=(1.23 if cap==4 else 1.66)+(slot//8 + (2 if side==-1 else 0))*(.075 if cap==4 else .09)
                along=(slot%8-3.5)*cfg['step']
                for edge in range(4):
                    x,z=[(outward,along),(-along,outward),(-outward,-along),(along,-outward)][edge]
                    captures.append(f'execute if score #vis_cap ch_ctx matches {cap} if score #vis_overlap ch_ctx matches 1 if score #vis_owner ch_ctx matches {side} if score #vis_edge ch_ctx matches {edge} if score #vis_slot ch_ctx matches {slot} run data modify storage chess:visual coord set value {{x:{f(x)},z:{f(z)}}}')
    captures += ["data modify storage chess:visual x set from storage chess:visual coord.x", "data modify storage chess:visual z set from storage chess:visual coord.z", "function chess:visual/man_rotation", "function chess:visual/set_pose with storage chess:visual"]
    function("captured_pose", "\n".join(captures))


def export_notes():
    text_file(SOURCE / "README.md", """
# 国际象棋资源与来源

棋子几何来自 **16bit 制作组的 NyaaWorks 喵工坊 r2.2**，源目录为
`assets/minecraft/models/item/nw/chess`。本项目内置白／黑各六种棋子的模型，
原始几何副本保存在 `nyaaworks/`，来源和 SHA-256 见 `source_manifest.json`。
上游作者：[16bit 制作组](https://space.bilibili.com/2907002)。使用时请保留相关来源署名。

本项目调整：以 `none` 展示模式适配桌面大小；新增黑檀黑白、胡桃木、冰蓝、
翡翠四组材质，棋盘新增经典黑白、绿白、木棕、蓝灰、紫白五组常见配色。
新增材质、棋盘和坐标均由脚本绘制，未复制第三方网站的棋盘图片。
`board-palettes.png` 为棋盘配色预览，不属于游戏运行资源。

资源命名为 `card:chess/<palette>/<white|black>_<pawn|knight|bishop|rook|queen|king>`；
棋盘为 `card:chess/board_<classic|green|wood|blue|purple>`。

从数据包目录运行 `python tools/build_chess_visual.py` 重建全部棋盘、材质、
模型及桌面展示函数，需要 Pillow。首次运行可从相邻的 NyaaWorks 资源包读取原始模型；
此后只需本目录保存的原始副本，不要求玩家另外安装 NyaaWorks。

坐标：逻辑 a1=0、h8=63；四座格长 0.27、八座 0.37，棋盘内部边长 2.16／2.96。
外围坐标边框各为格长的 3/8。棋盘底面位于桌心 Y+1.02，棋子底面为 Y+1.04。
方向 0 白方从南向北；方向 1 整盘旋转 90 度，白方从西向东。
棋盘的右旋 Y 180 度抵消原版 ItemDisplayRenderer 的固定 Y 180 度，避免贴图与逻辑坐标反向。
从白方看，字母左至右为 a～h，数字近至远为 1～8，王位于 e1／e8；逻辑棋格与交互位置不变。
王在统一展示变换中额外水平旋转 90 度，马额外水平旋转 180 度；四组配色、黑白双方及移动／吃子／重建状态均一致。
选中格使用金色边框；开启走格提示后，全部合法终点以翡翠绿色发光边框显示。
提示复用规则引擎的只读模拟，包含将军、牵制、易位、吃过路兵和升变合法性。
64 个棋格右键区宽度分别为 0.266／0.366、高度 0.025，不遮挡远处空格。
另为每枚棋子生成一个窄命中区，依据原始几何的旋转包围盒与桌型缩放覆盖完整高度；
王、后顶部同样可点。命中区随行棋／易位同步移动，升变调整尺寸，吃子时移除。

吃子显示保留原棋色，缩小后沿吃子者面向棋盘的右侧桌沿两列排列；没有实际玩家座位的
预览使用棋盘默认白／黑方向。两人若坐在同一桌边，共享右侧边槽并缩小为四条队列。
游戏开局会按阵营自动安排到棋盘对应的相对侧，便于阅读坐标。
行棋、王车易位、被吃棋子移至边槽均使用 8 刻展示变换插值。

## 棋局音效

`assets/card/sounds/chess/` 内置移动、吃子、易位、将军、开局、结束和非法走法
七种音效，事件为 `card:chess.<move|capture|castle|check|start|end|illegal>`。
音频使用 [Chess.com 默认音效](https://www.chess.com/forum/view/general/chessboard-sound-files?page=2)，
来源为 `images.chesscomfiles.com/chess-themes/sounds/_MP3_/default/`。
原始 MP3、每个文件的下载地址与 SHA-256 保存在 `sounds/`，来源归 Chess.com。

运行 `python .source/chess/export_sounds.py` 重建音频，需要 Python 和 FFmpeg；
可用 `--ffmpeg <路径>` 指定编码器。脚本先校验本地原文件，只转换声道、采样率和编码，
不合成或修改音色；仅合并 `sounds.json` 的 `chess.*` 事件及中英文字幕。
运行资源为单声道 44.1 kHz Ogg Vorbis，支持棋盘位置的空间声音；重建无需联网。

数据包在 8 刻动画落位时选取一个音效：将军优先，其次易位、吃子、普通移动；
将死等终局播放结束音。非法走法只提示操作者，其余只发送给本桌双方。
声音使用「方块」通道，可在 Minecraft 声音设置调整音量；更新资源后按 `F3+T`。
""")


if __name__ == "__main__":
    export_resourcepack()
    export_functions()
    export_notes()
    print(f"Built {len(list(GAME.rglob('*.mcfunction')))} chess visual functions and embedded chess resources.")
