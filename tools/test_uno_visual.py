"""在独立 26.2 GameTest 世界检查 UNO 桌面牌的真实 NBT 与正背几何。

复用 test_uno 的隔离世界启动器，不修改生产存档或资源模型。测试四座、
八座各座位及起始牌；从 Minecraft 日志取回 transformation，再计算包含
ItemDisplayRenderer 固有 Y180 在内的正背法线、牌心、厚度及文字方向。
"""

from __future__ import annotations

import argparse
import itertools
import json
import math
import re
import tempfile
import uuid
from pathlib import Path

import test_uno


CONTROLLER = '@e[type=minecraft:marker,tag=uv.controller,limit=1]'


class VisualFixtures(test_uno.Fixtures):
    def build(self) -> None:
        self.file('pass', ['scoreboard players add #passed ut 1', '$say UNO_TEST_PASS $(name)'])
        self.file('fail', ['scoreboard players add #failed ut 1', '$say UNO_TEST_FAIL $(name)'])
        self.file('bootstrap', '''
scoreboard objectives add ut dummy
scoreboard players set #passed ut 0
scoreboard players set #failed ut 0
schedule function uno_test:case/visual 1t
''')
        self.file('controller', '''
tag @s add uv.controller
scoreboard players set @s ct_id 101
scoreboard players set @s ct_capacity 4
scoreboard players set @s ct_state 0
''')
        self.file('capture', '''
data modify storage uno_test:visual snapshot set from entity @s transformation
function uno_test:record with storage uno_test:visual
''')
        self.file('record', '$say UNO_VISUAL_TRANSFORM $(id) $(snapshot)')
        self.file('foreign', '''
tag @s add un.face
tag @s add uv.foreign
scoreboard players set @s ct_id 202
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:uno/r8"}},item_display:"none",transformation:{translation:[0.040625f,0f,-0.040625f],left_rotation:[0.7071068f,0f,0f,0.7071068f],right_rotation:[0f,0f,0f,1f],scale:[0.65f,0.65f,0.65f]}}
''')

        commands = ['execute positioned 0 64 0 summon minecraft:marker run function uno_test:controller',
                    f'execute as {CONTROLLER} at @s run function uno:visual/ensure_box',
                    'data modify storage uno_test:visual box set from entity @e[tag=un.box,scores={ct_id=101},limit=1] transformation',
                    'execute positioned 24 65 0 summon minecraft:item_display run function uno_test:foreign']
        variants = [(0, 4)] + [(seat, cap) for cap in (4, 8) for seat in range(1, cap + 1)]
        for seat, cap in variants:
            name = f'seat{seat}_{cap}'
            face = f'@e[type=minecraft:item_display,tag=un.face,scores={{ct_id=101,un_seat={seat}}},limit=1]'
            commands += [f'scoreboard players set {CONTROLLER} ct_capacity {cap}',
                         'scoreboard players set #card un_ctx 7',
                         f'scoreboard players set #seat un_ctx {seat}',
                         f'execute as {CONTROLLER} at @s run function uno:visual/play']
            commands += self.check(f'entity {face}', name + '_spawned')
            commands += self.check(f'data entity {face} {{item:{{components:{{"minecraft:item_model":"card:uno/r7"}}}}}}', name + '_uses_front_model')
            commands += self.check(f'data entity {face} {{item_display:"none",transformation:{{right_rotation:[0f,1f,0f,0f]}}}}', name + '_renderer_flip_cancelled')
            commands += self.check(f'data entity {face} {{Tags:["un.face_up_v2"]}}', name + '_spawn_has_migration_tag')
            commands += [f'data modify storage uno_test:visual left set from entity {face} transformation.left_rotation',
                         f'data modify storage uno_test:visual item set from entity {face} item',
                         f'data modify entity {face} transformation.right_rotation set value [0f,0f,0f,1f]',
                         f'data modify entity {face} transformation.translation[1] set value 0f',
                         f'tag {face} remove un.face_up_v2',
                         f'execute as {CONTROLLER} at @s run function uno:visual/repair_faces']
            commands += self.check(f'data entity {face} {{Tags:["un.face_up_v2"],transformation:{{right_rotation:[0f,1f,0f,0f]}}}}', name + '_old_entity_migrated')
            commands += [f'execute store result score #height ut run data get entity {face} transformation.translation[1] 1000000']
            commands += self.score('#height', 'ut', '40624..40625', name + '_migration_restores_surface_height')
            for field, path in (('left', 'transformation.left_rotation'), ('item', 'item')):
                commands += [f'execute store success score #changed ut run data modify storage uno_test:visual {field} set from entity {face} {path}']
                commands += self.score('#changed', 'ut', 0, name + '_migration_keeps_' + field)
            commands += [f'data modify storage uno_test:visual stable set from entity {face} transformation',
                         f'execute as {face} run function uno:visual/repair_face',
                         f'execute store success score #changed ut run data modify storage uno_test:visual stable set from entity {face} transformation']
            commands += self.score('#changed', 'ut', 0, name + '_migration_idempotent')
            commands += [f'data modify storage uno_test:visual id set value "{name}"',
                         f'execute as {face} run function uno_test:capture']
        commands += self.check('data entity @e[tag=uv.foreign,limit=1] {transformation:{right_rotation:[0f,0f,0f,1f]}}', 'migration_does_not_change_other_table')
        commands += self.check('entity @e[tag=uv.foreign,tag=!un.face_up_v2,limit=1]', 'migration_does_not_tag_other_table')
        commands += self.count('@e[type=minecraft:item_display,tag=un.box,scores={ct_id=101}]', 1, 'visual_keeps_one_box')
        commands += ['execute as @e[type=minecraft:item_display,tag=un.box,scores={ct_id=101},limit=1] run function uno:visual/repair_face',
                     'execute store success score #box_changed ut run data modify storage uno_test:visual box set from entity @e[tag=un.box,scores={ct_id=101},limit=1] transformation']
        commands += self.score('#box_changed', 'ut', 0, 'visual_does_not_flip_box')
        commands += self.status_commands()
        commands += ['say UNO_TEST_FINISHED']
        self.case('visual', commands)

    def status_commands(self) -> list[str]:
        """真实执行世界文字更新；marker CustomName沿同一loot上下文固化。"""
        self.file('other_controller', '''
tag @s add uv.other_controller
scoreboard players set @s ct_id 202
scoreboard players set @s ct_capacity 8
scoreboard players set @s ct_state 0
scoreboard players set @s un_turn 8
''')
        self.file('status_person', '''
tag @s add un.player
tag @s add ct.player
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s un_table $(table)
$scoreboard players set @s un_seat $(seat)
$scoreboard players set @s un_count $(count)
$scoreboard players set @s un_score $(score)
$data merge entity @s {CustomName:$(name)}
''')
        other = '@e[type=minecraft:marker,tag=uv.other_controller,limit=1]'
        status_a = '@e[type=minecraft:text_display,tag=un.status,scores={ct_id=101},limit=1]'
        status_b = '@e[type=minecraft:text_display,tag=un.status,scores={ct_id=202},limit=1]'
        special_name = '测试O\'"\\名'
        commands = ['execute positioned 24 64 0 summon minecraft:marker run function uno_test:other_controller',
                    f'scoreboard players set {CONTROLLER} un_turn 3']
        for table, seat, count, score, name in [(101, 8, 1, 30, special_name), (202, 8, 9, 100, '桌乙-8'),
                                              (101, 3, 4, 20, '桌甲-3'), (202, 1, 2, 90, '桌乙-1'), (101, 1, 7, 10, '桌甲-1')]:
            args = {'table': table, 'seat': seat, 'count': count, 'score': score, 'name': {'text': name}}
            x = 0 if table == 101 else 24
            commands += [f'execute positioned {x} 64 0 summon minecraft:marker run function uno_test:status_person ' + json.dumps(args, ensure_ascii=False)]
        commands += [f'execute as {CONTROLLER} at @s run function uno:visual/update_status',
                     f'execute as {other} at @s run function uno:visual/update_status']
        commands += self.count('@e[type=minecraft:text_display,tag=un.status,scores={ct_id=101}]', 1, 'status_one_display_table_a')
        commands += self.count('@e[type=minecraft:text_display,tag=un.status,scores={ct_id=202}]', 1, 'status_one_display_table_b')
        for display, row, expected_name, label in [(status_a, 1, '桌甲-1', 'a_first'), (status_a, 2, '桌甲-3', 'a_second'),
                                                   (status_a, 3, special_name, 'a_last'), (status_b, 1, '桌乙-1', 'b_first'), (status_b, 2, '桌乙-8', 'b_last')]:
            # text_display codec会把无样式的{text:名字}压缩为NBT字符串。
            path = f'text.extra[{row}].extra[1].extra[0]'
            commands += self.check(f'data entity {display} {path}', 'status_name_exists_' + label)
            commands += ['data modify storage uno_test:visual expected_name set value ' + json.dumps(expected_name, ensure_ascii=False),
                         f'execute store success score #name_changed ut run data modify storage uno_test:visual expected_name set from entity {display} {path}']
            commands += self.score('#name_changed', 'ut', 0, 'status_resolved_sorted_name_' + label)
        commands += self.check(f'data entity {status_a} text.extra[1].extra[{{text:" · 7张 · 10分"}}]', 'status_initial_counts_and_score')
        commands += self.check(f'data entity {status_a} text.extra[2].extra[{{text:" ▶"}}]', 'status_initial_current_arrow')
        commands += [f'execute store result score #lines ut run data get entity {status_a} text.extra']
        commands += self.score('#lines', 'ut', 4, 'status_table_a_has_only_own_three_players')
        commands += [f'execute store result score #lines ut run data get entity {status_b} text.extra']
        commands += self.score('#lines', 'ut', 3, 'status_table_b_has_only_own_two_players')
        commands += [f'execute store success score #raw_selector ut run data get entity {status_a} text.extra[].extra[].extra[].selector']
        commands += self.score('#raw_selector', 'ut', 0, 'status_names_are_static_components')
        commands += self.count('@e[type=minecraft:item_display,tag=un.name_resolver]', 0, 'status_name_resolver_leaves_no_entities')
        commands += [f'data modify storage uno_test:visual status_uuid set from entity {status_a} UUID',
                     f'data modify storage uno_test:visual other_text set from entity {status_b} text',
                     'scoreboard players set @e[tag=un.player,scores={ct_id=101,un_seat=1},limit=1] un_count 3',
                     'scoreboard players set @e[tag=un.player,scores={ct_id=101,un_seat=1},limit=1] un_score 40',
                     f'scoreboard players set {CONTROLLER} un_turn 8',
                     f'execute as {CONTROLLER} at @s run function uno:visual/update_status']
        commands += self.check(f'data entity {status_a} text.extra[1].extra[{{text:" · 3张 · 40分"}}]', 'status_updated_counts_and_score')
        commands += self.check(f'data entity {status_a} text.extra[3].extra[{{text:" ▶"}}]', 'status_arrow_moves_to_current_player')
        commands += [f'execute store success score #previous_arrow ut run data get entity {status_a} text.extra[2].extra[{{text:" ▶"}}]']
        commands += self.score('#previous_arrow', 'ut', 0, 'status_previous_arrow_cleared')
        commands += [f'execute store success score #changed ut run data modify storage uno_test:visual status_uuid set from entity {status_a} UUID']
        commands += self.score('#changed', 'ut', 0, 'status_updates_same_entity')
        commands += [f'execute store success score #changed ut run data modify storage uno_test:visual other_text set from entity {status_b} text']
        commands += self.score('#changed', 'ut', 0, 'status_update_does_not_change_other_table')
        commands += [f'data merge entity {status_a} {{text:{{text:"UNO · 最新出牌：8号座"}},Pos:[0d,65.55d,0d]}}',
                     f'execute as {CONTROLLER} at @s run function uno:visual/update_status']
        commands += ['data modify storage uno_test:visual expected_name set value "桌甲-1"',
                     f'execute store success score #name_changed ut run data modify storage uno_test:visual expected_name set from entity {status_a} text.extra[1].extra[1].extra[0]']
        commands += self.score('#name_changed', 'ut', 0, 'status_replaces_legacy_latest_card_label')
        commands += [f'execute store result score #height ut run data get entity {status_a} Pos[1] 1000']
        commands += self.score('#height', 'ut', '65899..65900', 'status_moves_legacy_label_slightly_higher')
        commands += [f'execute store success score #changed ut run data modify storage uno_test:visual status_uuid set from entity {status_a} UUID']
        commands += self.score('#changed', 'ut', 0, 'status_legacy_upgrade_keeps_entity')
        return commands


def rotate(q: list[float], v: tuple[float, float, float] | list[float]) -> list[float]:
    x, y, z, w = q
    vx, vy, vz = v
    return [
        (1 - 2 * (y*y + z*z)) * vx + 2 * (x*y - z*w) * vy + 2 * (x*z + y*w) * vz,
        2 * (x*y + z*w) * vx + (1 - 2 * (x*x + z*z)) * vy + 2 * (y*z - x*w) * vz,
        2 * (x*z - y*w) * vx + 2 * (y*z + x*w) * vy + (1 - 2 * (x*x + y*y)) * vz,
    ]


def vector(snbt: str, name: str) -> list[float]:
    match = re.search(r'\b' + name + r':\s*\[([^]]+)\]', snbt)
    if not match:
        raise AssertionError(f'missing {name}: {snbt}')
    return [float(value.strip().rstrip('fFdD')) for value in match.group(1).split(',')]


def geometry(log: str) -> dict[str, object]:
    snapshots = dict(re.findall(r'UNO_VISUAL_TRANSFORM (seat\d+_[48]) (\{[^\r\n]+\})', log))
    expected_names = {'seat0_4'} | {f'seat{seat}_{cap}' for cap in (4, 8) for seat in range(1, cap + 1)}
    assert snapshots.keys() == expected_names, f'missing snapshots: {expected_names - snapshots.keys()}'
    result = {}
    for name, snbt in snapshots.items():
        translation = vector(snbt, 'translation')
        left, right, scale = (vector(snbt, key) for key in ('left_rotation', 'right_rotation', 'scale'))

        def direction(v: tuple[float, float, float]) -> list[float]:
            # The renderer's Y180 is applied first to model vertices/normals.
            return rotate(left, rotate(right, (-v[0], v[1], -v[2])))

        def point(v: tuple[float, float, float]) -> list[float]:
            # Baked item models use block units centred on (8,8,8).
            centred = [(value - 8) / 16 for value in v]
            renderer = [-centred[0], centred[1], -centred[2]]
            turned = rotate(right, renderer)
            turned = [value * factor for value, factor in zip(turned, scale)]
            turned = rotate(left, turned)
            return [value + offset for value, offset in zip(turned, translation)]

        front, back = direction((0, 0, -1)), direction((0, 0, 1))
        assert math.dist(front, (0, 1, 0)) < 1e-5, (name, 'front not up', front)
        assert math.dist(back, (0, -1, 0)) < 1e-5, (name, 'back not down', back)
        centre = point((7, 9, 8.5))
        assert abs(centre[0]) < 1e-6 and abs(centre[2]) < 1e-6, (name, 'off-centre', centre)
        vertices = [point(vertex) for vertex in itertools.product((1, 13), (0, 18), (8, 9))]
        bottom, top = min(v[1] for v in vertices), max(v[1] for v in vertices)
        assert abs(bottom) < 1e-6 and abs(top - .040625) < 1e-6, (name, 'surface height', bottom, top)
        seat, capacity = (int(value) for value in name.removeprefix('seat').split('_'))
        if not seat or (capacity == 4 and seat == 1) or (capacity == 8 and seat <= 2):
            expected_up = (0, 0, 1)
        elif (capacity == 4 and seat == 2) or (capacity == 8 and seat <= 4):
            expected_up = (-1, 0, 0)
        elif (capacity == 4 and seat == 3) or (capacity == 8 and seat <= 6):
            expected_up = (0, 0, -1)
        else:
            expected_up = (1, 0, 0)
        assert math.dist(direction((0, 1, 0)), expected_up) < 1e-5, (name, 'text points away from table centre')
        result[name] = {'front': [round(x, 7) for x in front], 'bottom': round(bottom, 7), 'top': round(top, 7)}
    return result


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pack', type=Path, default=test_uno.PACK)
    parser.add_argument('--minecraft-root', type=Path, default=Path('D:/PCL2/MinecraftPcl'))
    parser.add_argument('--version', default='26.2-Fabric_0.19.3')
    parser.add_argument('--java', type=Path)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    args.output = args.output or Path(tempfile.gettempdir()) / ('fimel-uno-visual-' + uuid.uuid4().hex[:10])
    test_uno.Fixtures = VisualFixtures
    status = test_uno.run(args)
    if status:
        return status
    result = geometry((args.output / 'game.log').read_text(encoding='utf-8'))
    (args.output / 'visual-geometry.json').write_text(json.dumps(result, indent=2), encoding='utf-8')
    print(f'UNO visual geometry: {len(result)} positions; front/back, centre, thickness and seat text orientation passed.')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
