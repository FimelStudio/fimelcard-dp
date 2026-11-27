"""原版 26.2 GameTest 中验证 UNO HUD，复用完整 UNO 行为测试环境。

仅在测试的临时世界中用 marker 直接执行构建函数并检查实际生成的
BetterTitle 面板。生产玩家入口仍严格要求 player；另检查实际字体的屏幕边界，
不替代客户端画面验收。
"""
from __future__ import annotations

import sys
import json
import re

import test_uno as base


def check_layout_geometry():
    """读取实际字体和位移字符，检查四层堆叠、换行和居中宽度。"""
    pack = base.PACK.parents[3] / 'resourcepacks/fimelcard-rp'
    fonts = pack / 'assets/card/font/uno'
    advances = json.loads((pack / 'assets/title/font/y_displace.json').read_text(encoding='utf-8'))['providers'][0]['advances']
    build = (base.PACK / 'data/uno/function/hud/build.mcfunction').read_text(encoding='utf-8')
    calls = re.findall(r'matches (\d+)\.\.(\d*) run function uno:hud/line \{row:(\d+),y:(-?\d+)\}', build)

    def shift(y):
        glyph = chr(int(str(2500 + 2*y), 16))
        # core/text.vsh 从顶点 X 解码 Y：正位移字形使画面向上移动。
        return -advances[glyph] / 30000

    checks = 0
    dd_advances = json.loads((pack / 'assets/card/font/doudizhu/hand_neg.json').read_text(encoding='utf-8'))['providers'][0]['advances']
    dd_width = 15 * (-2 * dd_advances['\uE101'] - 2 * dd_advances['\uE001'])
    for count, name, status_y in [(8, 'hud', 108), (9, 'hud_dense', 108), (15, 'hud_dense', 108), (18, 'hud_dense', 108), (36, 'hud_medium', 154), (54, 'hud_small', 167)]:
        providers = json.loads((fonts / (name + '.json')).read_text(encoding='utf-8'))['providers']
        card = next(p for p in providers if p['type'] == 'bitmap')
        max_ascent = max(p['ascent'] for p in providers if p['type'] == 'bitmap')
        min_ascent = min(p['ascent'] for p in providers if p['type'] == 'bitmap')
        assert all(p['ascent'] <= p['height'] for p in providers if p['type'] == 'bitmap'), 'invalid bitmap font ascent'
        rows = []
        for lower, upper, row, y in calls:
            if count < int(lower) or (upper and count > int(upper)):
                continue
            top = shift(int(y)) + 7 - max_ascent
            bottom = shift(int(y)) + 7 - min_ascent + card['height']
            rows.append((top, bottom))
            checks += 1
        rows.sort()
        assert len(rows) == (1 if count <= 18 else 2 if count <= 36 else 3)
        assert all(a[1] + 3 <= b[0] for a, b in zip(rows, rows[1:])), (name, 'rows overlap', rows)
        status_bottom = shift(status_y) + 8
        assert status_bottom + 3 <= rows[0][0], (name, 'status overlaps cards')
        # 原版actionbar绘制位置为H-72；检查纵向边界，横向参考斗地主15种的真实宽度。
        assert 240 - 72 + shift(status_y) >= 0, (name, 'top clipped')
        assert -72 + rows[-1][1] <= -60, (name, 'stack intrudes on item name')
        checks += 4
        # 使用实际PNG的不透明像素宽度计算Minecraft位图字形advance。
        from PIL import Image
        widths = {}
        for provider in providers:
            if provider['type'] == 'bitmap':
                namespace, path = provider['file'].split(':')
                with Image.open(pack / 'assets' / namespace / 'textures' / path) as im:
                    width = int(im.getbbox()[2] * provider['height'] / im.height + 0.5) + 1
                widths[provider['chars'][0]] = width
            elif provider['type'] == 'space':
                widths.update(provider['advances'])
        rewinds = json.loads((fonts / (name + '_neg.json')).read_text(encoding='utf-8'))['providers'][0]['advances']
        assert widths['\uE7F0'] >= 3, (name, 'adjacent card types overlap')
        for glyph, width in widths.items():
            assert rewinds[glyph] == -width / 2, (name, glyph, 'incorrect centering rewind')
        for index in range(54):
            for selected in (False, True):
                base_glyph = chr(0xE600 + index + int(selected) * 0x100)
                for layers in range(1, 5):
                    text = '\uE7F5'.join(chr(ord(base_glyph) + 0x200 * depth) for depth in range(layers))
                    assert sum(widths[ch] for ch in text) == widths[base_glyph], (name, 'duplicates widen row')
                    pen = 0
                    for ch in text:
                        if ch != '\uE7F5':
                            assert pen == 0, (name, 'stack layer enters adjacent card slot')
                        pen += widths[ch]
        row_width = min(count, 18) * (widths['\uE600'] + widths['\uE7F0']) + widths['\uE7F2']
        assert row_width <= dd_width, (name, 'row wider than full doudizhu hand', row_width)
        if count <= 18:
            assert card['height'] == 56 and max_ascent - min_ascent == 30, 'full-size ten-pixel stacks must fit eighteen types'
        checks += 434
    for font in ('dialog', 'dialog_selected'):
        providers = json.loads((fonts / (font + '.json')).read_text(encoding='utf-8'))['providers']
        cards = [p for p in providers if p['type'] == 'bitmap']
        assert all(p['ascent'] <= p['height'] for p in cards), 'invalid dialog font ascent'
        assert max(p['ascent'] for p in cards) <= 6 * 9, 'dialog first stack clipped'
        assert max(p['ascent'] for p in cards) - min(p['ascent'] - p['height'] for p in cards) + 3 <= 10 * 9, 'dialog rows overlap'
        assert max(p['ascent'] for p in cards) - min(p['ascent'] for p in cards) == 30, 'dialog stack strips too small'
        assert 12 * (33 + 4) <= 460, 'dialog wraps before twelve types'
        checks += 3
    print(f'UNO HUD screen geometry: {checks} checks passed', flush=True)


class HudFixtures(base.Fixtures):
    def case(self, name, commands):
        if name == "real_reload":
            self.hud_cases()
        super().case(name, commands)

    def render(self, seat=1, table=101, panel=901):
        player = base.person(seat, table)
        controller = base.A if table == 101 else base.B
        return [f"execute as {controller} at @s run function uno:system/context",
                f"scoreboard players set {player} un_panel {panel}",
                f"tag {player} add un.hud_active",
                f"execute as {player} run function uno:hud/build"]

    def at(self, path, expected, name):
        # NBT 的列表索引后不能直接接 compound 过滤器，先取出再比较。
        return ["data remove storage uno_test:hud probe",
                f"data modify storage uno_test:hud probe set from storage uno:hud {path}"] + self.check("data storage uno_test:hud probe" + expected, name)

    def y_marker(self, offset, name):
        # BetterTitle 宏把十进制数字写到 \u 后，得到位移控制字符。
        glyph = chr(int(str(2500 + offset * 2), 16))
        return self.check(f'data storage fimel_title:io panels[901][{{font:"title:y_displace",text:"{glyph}"}}]', name)

    def hud_cases(self):
        commands = self.setup() + self.hand(1, [2, 14, 28, 105, 106]) + self.hand(6, [79])
        commands += [f"scoreboard players set {base.person(1)} un_pick 1"] + self.render()
        commands += self.score(base.person(1), "fbt_panel", 901, "hud_binds_private_panel")
        commands += self.score(base.person(1), "un_pick", 1, "hud_does_not_change_selected_card")
        commands += self.at('rows[0].cards.extra[0]', '{text:"\uE701\uE7F5\uE901"}', "hud_duplicate_selected_red_one_stacks_two")
        commands += self.at('rows[0].cards.extra[2]', '{text:"\uE60F"}', "hud_sorts_yellow_after_red")
        commands += self.at('rows[0].cards.extra[4]', '{text:"\uE635\uE7F5\uE835"}', "hud_sorts_stacked_wild_after_colours")
        commands += ['execute store success score #has_count ut run data get storage uno:hud rows[0].counts']
        commands += self.score('#has_count', 'ut', 0, 'hud_has_no_quantity_line')
        commands += self.score("#hud_types", "un_ctx", 3, "hud_only_own_card_types")
        commands += self.check('data storage fimel_title:io panels[901][][{font:"card:uno/hud"}]', "hud_writes_bettertitle_card_font")
        commands += self.y_marker(42, "hud_cards_move_above_item_name")
        commands += self.count('@e[tag=un.hudhand]', 0, "hud_clears_synchronous_hand_tags")
        self.case("hud_hand", commands)

        commands = self.setup() + self.hand(1, [2, 28]) + self.hand(6, [79])
        commands += self.render() + [f"scoreboard players set {base.person(1)} un_pick 15"] + self.render()
        commands += self.at('rows[0].cards.extra[0]', '{text:"\uE601"}', "hud_previous_selected_loses_glow")
        commands += self.at('rows[0].cards.extra[2]', '{text:"\uE70F"}', "hud_new_selected_gets_glow")
        commands += [f"scoreboard players set {base.person(1)} un_pick -1"] + self.render()
        commands += self.at('rows[0].cards.extra[2]', '{text:"\uE60F"}', "hud_deselect_restores_normal_glyph")
        self.case("hud_selection", commands)

        unique = [*range(1, 14), *range(26, 39), *range(51, 64), *range(76, 89), 101, 105]
        for count, font in [(8, "hud"), (9, "hud_dense"), (15, "hud_dense"), (18, "hud_dense"), (19, "hud_medium"), (36, "hud_medium"), (37, "hud_small")]:
            commands = self.setup() + self.hand(1, unique[:count]) + self.render()
            commands += self.score("#hud_types", "un_ctx", count, f"hud_size_{count}_counts_unique_types")
            commands += self.check(f'data storage fimel_title:io panels[901][][{{font:"card:uno/{font}"}}]', f"hud_size_{count}_selects_readable_font")
            commands += self.check(f'data storage fimel_title:io panels[901][][{{font:"card:uno/{font}_neg"}}]', f"hud_size_{count}_uses_matching_half_width_rewind")
            if count >= 37:
                commands += self.y_marker(78, f"hud_size_{count}_second_row_keeps_stack_gap")
                commands += self.y_marker(129, f"hud_size_{count}_third_row_keeps_stack_gap")
                commands += self.y_marker(167, f"hud_size_{count}_status_stays_on_minimum_gui")
            elif count >= 19:
                commands += self.y_marker(106, f"hud_size_{count}_second_row_keeps_stack_gap")
                commands += self.y_marker(154, f"hud_size_{count}_status_above_both_rows")
            else:
                commands += self.y_marker(108, f"hud_size_{count}_status_above_full_size_cards")
            self.case(f"hud_size_{count}", commands)

        commands = self.setup() + self.hand(1, list(range(1, 109)))
        commands += self.render()
        commands += self.score("#hud_types", "un_ctx", 54, "hud_supports_all_fiftyfour_card_types")
        commands += self.check('data storage fimel_title:io panels[901][][{font:"card:uno/hud_small"}]', "hud_fiftyfour_types_fit_three_rows")
        commands += self.at('rows[0].cards.extra[34]', '{text:"\uE611\uE7F5\uE811"}', "hud_first_row_eighteen_types")
        commands += self.at('rows[1].cards.extra[0]', '{text:"\uE612\uE7F5\uE812"}', "hud_second_row_wraps_at_eighteen")
        commands += self.at('rows[2].cards.extra[0]', '{text:"\uE624\uE7F5\uE824"}', "hud_third_row_wraps_at_thirtysix")
        commands += self.at('rows[2].cards.extra[34]', '{text:"\uE635\uE7F5\uE835\uE7F5\uEA35\uE7F5\uEC35"}', "hud_last_wild_plus_four_stacks_all_four")
        commands += self.count('@e[tag=un.card,scores={un_owner=1}]', 108, "hud_reading_never_changes_card_ownership")
        self.case("hud_full_deck", commands)

        for count in (9, 12, 13, 36, 54):
            commands = self.setup() + self.hand(1, unique[:count])
            commands += ['tag @e[tag=un.uihand] remove un.uihand', 'tag @e[tag=un.card,scores={ct_id=101,un_owner=1}] add un.uihand',
                         'scoreboard players set #ui_base un_ctx 1000', 'scoreboard players set #ui_col un_ctx 0',
                         'data modify storage uno:ui grid set value {text:"",extra:[]}',
                         f'execute as {base.person(1)} run function uno:ui/build',
                         'execute store result score #grid_items ut run data get storage uno:ui grid.extra']
            commands += self.score('#grid_items', 'ut', count + (count - 1) // 12, f'dialog_{count}_wraps_twelve_types')
            if count > 12:
                commands += ['data modify storage uno_test:hud probe set from storage uno:ui grid.extra[12]']
                commands += self.check('data storage uno_test:hud probe{text:"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n"}', f'dialog_{count}_reserves_stack_height')
            self.case(f'dialog_rows_{count}', commands)

        commands = self.setup() + self.hand(1, [2]) + self.table(202, (1, 6, 8)) + self.hand(1, [79], 202)
        commands += self.render(table=101, panel=901)
        commands += ['data modify storage uno_test:hud saved set from storage fimel_title:io panels[901]']
        commands += self.render(table=202, panel=902)
        commands += self.at('rows[0].cards.extra[0]', '{text:"\uE62A"}', "hud_second_table_only_its_blue_card")
        commands += ['execute store success score #hud_changed ut run data modify storage uno_test:hud saved set from storage fimel_title:io panels[901]']
        commands += self.score("#hud_changed", "ut", 0, "hud_other_table_does_not_overwrite_first_panel")
        commands += self.score(base.person(1, 101), "fbt_panel", 901, "hud_first_viewer_keeps_own_panel")
        commands += self.score(base.person(1, 202), "fbt_panel", 902, "hud_second_viewer_keeps_own_panel")
        self.case("hud_two_tables", commands)

        commands = self.setup() + self.hand(1, [2]) + self.render()
        player = base.person(1)
        commands += [f"scoreboard players set {player} un_prev_panel 42", f"tag {player} add un.owns_actionbar", f"tag {player} add fimel.anim_text.replace.actionbar", f"execute as {player} run function uno:hud/deactivate"]
        commands += self.score(player, "fbt_panel", 42, "hud_exit_restores_previous_bettertitle_panel")
        commands += self.check('data storage fimel_title:io panels[901]', "hud_exit_keeps_reusable_private_slot")
        commands += self.check('entity @e[tag=un.player,tag=!un.hud_active,scores={un_seat=1,ct_id=101}]', "hud_exit_removes_active_tag")
        commands += self.count('@e[tag=un.owns_actionbar]', 0, "hud_exit_returns_actionbar_ownership")
        commands += self.count('@e[tag=fimel.anim_text.replace.actionbar]', 0, "hud_exit_does_not_keep_actionbar_claim")
        commands += self.score(player, "un_panel", 901, "hud_private_slot_reused_across_matches")
        self.case("hud_cleanup", commands)

        commands = self.setup() + self.hand(1, [2]) + self.render()
        commands += [f"scoreboard players set {player} fbt_panel 123", f"scoreboard players set {player} un_prev_panel 42", f"execute as {player} run function uno:hud/deactivate"]
        commands += self.score(player, "fbt_panel", 123, "hud_cleanup_preserves_newer_foreign_panel")
        commands += [f"scoreboard players set {player} fbt_panel 901", f"tag {player} add un.hud_active", f"tag {player} add fimel.anim_text.replace.actionbar", f"execute as {player} run function uno:hud/deactivate"]
        commands += self.count('@e[tag=fimel.anim_text.replace.actionbar]', 1, "hud_cleanup_preserves_preexisting_actionbar_claim")
        self.case("hud_foreign_panel", commands)

        commands = self.setup() + self.hand(1, [2]) + self.top(1)
        commands += [f"execute as {base.A} at @s run function uno:system/context", "scoreboard players set #seat un_ctx 1", f"execute as {base.A} at @s run function uno:deck/take"]
        commands += self.score(base.A, "un_hud_dirty", 1, "hud_draw_marks_dirty_once")
        commands += self.score(base.person(1), "un_count", 2, "hud_draw_preserves_actual_count")
        commands += [f"execute as {base.A} at @s run function uno:hud/flush"]
        commands += self.score(base.A, "un_hud_dirty", 0, "hud_end_of_tick_flush_resets_dirty")
        self.case("hud_draw_dirty", commands)


if __name__ == "__main__":
    check_layout_geometry()
    base.Fixtures = HudFixtures
    sys.exit(base.main())
