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
    """读取实际字体和位移字符，检查牌与数量的屏幕范围，而非只核对 NBT。"""
    pack = base.PACK.parents[3] / 'resourcepacks/fimelcard-rp'
    fonts = pack / 'assets/card/font/uno'
    advances = json.loads((pack / 'assets/title/font/y_displace.json').read_text(encoding='utf-8'))['providers'][0]['advances']
    build = (base.PACK / 'data/uno/function/hud/build.mcfunction').read_text(encoding='utf-8')
    calls = re.findall(r'matches (\d+)\.\.(\d*) run function uno:hud/line \{row:(\d+),y:(-?\d+),count_y:(-?\d+)\}', build)

    def shift(y):
        glyph = chr(int(str(2500 + 2*y), 16))
        # core/text.vsh 从顶点 X 解码 Y：正位移字形使画面向上移动。
        return -advances[glyph] / 30000

    checks = 0
    for count, name, status_y in [(8, 'hud', 76), (18, 'hud_dense', 76), (36, 'hud_medium', 120), (54, 'hud_small', 152)]:
        providers = json.loads((fonts / (name + '.json')).read_text(encoding='utf-8'))['providers']
        card = next(p for p in providers if p['type'] == 'bitmap')
        rows = []
        for lower, upper, row, y, count_y in calls:
            if count < int(lower) or (upper and count > int(upper)):
                continue
            # 同一绘制原点；卡牌字体用自身 ascent，x1～x4 使用原版 8px／ascent7。
            top = shift(int(y)) + 7 - card['ascent']
            bottom = top + card['height']
            count_top = shift(int(count_y))
            count_bottom = count_top + 8
            assert count_top - bottom >= 3, (name, row, 'quantity overlaps card', bottom, count_top)
            rows.append((top, count_bottom))
            checks += 1
        rows.sort()
        assert len(rows) == (1 if count <= 18 else 2 if count <= 36 else 3)
        assert all(a[1] + 3 <= b[0] for a, b in zip(rows, rows[1:])), (name, 'rows overlap', rows)
        status_bottom = shift(status_y) + 8
        assert status_bottom + 3 <= rows[0][0], (name, 'status overlaps cards')
        # 原版 actionbar 绘制位置为H-72；位图bearing为7-ascent，物品名顶端H-59。
        assert 240 - 72 + shift(status_y) >= 0, (name, 'top clipped')
        assert -72 + rows[-1][1] <= -60, (name, 'quantity intrudes on item name')
        checks += 4
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
        commands += self.at('rows[0].cards.extra[0]', '{text:"\uE701"}', "hud_selected_first_card_uses_highlight")
        commands += self.at('rows[0].counts.extra[0]', '{text:"x2"}', "hud_duplicate_red_one_aggregates_two")
        commands += self.at('rows[0].cards.extra[2]', '{text:"\uE60F"}', "hud_sorts_yellow_after_red")
        commands += self.at('rows[0].cards.extra[4]', '{text:"\uE635"}', "hud_sorts_wild_after_colours")
        commands += self.at('rows[0].counts.extra[4]', '{text:"x2"}', "hud_wild_duplicate_count")
        commands += self.score("#hud_types", "un_ctx", 3, "hud_only_own_card_types")
        commands += self.check('data storage fimel_title:io panels[901][][{font:"card:uno/hud"}]', "hud_writes_bettertitle_card_font")
        commands += self.y_marker(12, "hud_cards_move_above_item_name")
        commands += self.y_marker(0, "hud_counts_move_above_item_name")
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
        for count, font in [(8, "hud"), (9, "hud_dense"), (18, "hud_dense"), (19, "hud_medium"), (36, "hud_medium"), (37, "hud_small")]:
            commands = self.setup() + self.hand(1, unique[:count]) + self.render()
            commands += self.score("#hud_types", "un_ctx", count, f"hud_size_{count}_counts_unique_types")
            commands += self.check(f'data storage fimel_title:io panels[901][][{{font:"card:uno/{font}"}}]', f"hud_size_{count}_selects_readable_font")
            commands += self.check(f'data storage fimel_title:io panels[901][][{{font:"card:uno/{font}_neg"}}]', f"hud_size_{count}_uses_matching_half_width_rewind")
            if count >= 37:
                commands += self.y_marker(60, f"hud_size_{count}_second_row_keeps_count_gap")
                commands += self.y_marker(108, f"hud_size_{count}_third_row_keeps_count_gap")
                commands += self.y_marker(152, f"hud_size_{count}_status_stays_on_minimum_gui")
            elif count >= 19:
                commands += self.y_marker(68, f"hud_size_{count}_second_row_keeps_count_gap")
                commands += self.y_marker(120, f"hud_size_{count}_status_above_both_rows")
            else:
                commands += self.y_marker(76, f"hud_size_{count}_status_above_full_size_cards")
            self.case(f"hud_size_{count}", commands)

        commands = self.setup() + self.hand(1, list(range(1, 101)) + [101, 105])
        commands += self.render()
        commands += self.score("#hud_types", "un_ctx", 54, "hud_supports_all_fiftyfour_card_types")
        commands += self.check('data storage fimel_title:io panels[901][][{font:"card:uno/hud_small"}]', "hud_fiftyfour_types_fit_three_rows")
        commands += self.at('rows[0].cards.extra[34]', '{text:"\uE611"}', "hud_first_row_eighteen_types")
        commands += self.at('rows[1].cards.extra[0]', '{text:"\uE612"}', "hud_second_row_wraps_at_eighteen")
        commands += self.at('rows[2].cards.extra[0]', '{text:"\uE624"}', "hud_third_row_wraps_at_thirtysix")
        commands += self.at('rows[2].cards.extra[34]', '{text:"\uE635"}', "hud_last_wild_plus_four_never_truncated")
        commands += self.count('@e[tag=un.card,scores={un_owner=1}]', 102, "hud_reading_never_changes_card_ownership")
        self.case("hud_full_deck", commands)

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
