"""在真实 26.2 GameTest 中验证 UNO 单页即时设置及原有全部 UNO 行为。

marker 用于后台设置、组件和多桌状态断言，不代替真人客户端点击验收。
仅在隔离测试副本中，将 invalidate_table 的真人选择器换成测试 marker，
以覆盖实际 common 离座／切游戏入口；生产文件不包含测试分支。
"""

from __future__ import annotations

from pathlib import Path
import sys

import test_uno as base


ACTOR = '@e[type=minecraft:marker,tag=ust.actor,limit=1]'
INITIAL = {"un_mode": 0, "un_rounds": 3, "un_target": 500,
           "un_auto": 0, "un_challenge": 1, "un_window": 60}


class SettingsFixtures(base.Fixtures):
    def case(self, name, commands):
        if name == "real_reload":
            self.settings_cases()
        super().case(name, commands)

    def settings_setup(self):
        return (["function uno_test:reset"] + self.table(seats=(1, 8), create_deck=False)
                + self.table(202, (1, 8), create_deck=False)
                + [f"tag {base.A} add ct.controller", f"tag {base.B} add ct.controller",
                   f"scoreboard players set {base.A} ct_state 0", f"scoreboard players set {base.B} ct_state 0",
                   f"tag {base.person(1)} add ust.actor", "scoreboard players set #setting_serial un_ctx 23"])

    def session(self, field, value, nonce=23):
        return [f"scoreboard players operation {ACTOR} un_nonce = #ui_load un_ctx",
                f"scoreboard players set {ACTOR} un_set_table 101",
                f"scoreboard players set {ACTOR} un_setnonce {nonce}",
                f"scoreboard players set {ACTOR} un_settings {nonce * 100000 + field * 1000 + value}"]

    def submit(self):
        return [f"execute as {ACTOR} at @s run function uno:settings/save"]

    def unchanged(self, name):
        commands = []
        for objective, value in INITIAL.items():
            commands += self.score(base.A, objective, value, name + "_" + objective)
        return commands

    def render(self):
        return [f"execute as {base.A} at @s run function uno:settings/prepare",
                f"execute as {base.A} at @s run function uno:settings/root with storage uno:settings"]

    def settings_cases(self):
        valid = [(1, 1, "un_mode", 1), (1, 2, "un_mode", 2),
                 (2, 1, "un_rounds", 1), (2, 32, "un_rounds", 32),
                 (3, 1, "un_target", 100), (3, 10, "un_target", 1000),
                 (4, 1, "un_auto", 1), (5, 0, "un_challenge", 0),
                 (6, 1, "un_window", 20), (6, 5, "un_window", 100)]
        for index, (field, value, changed, expected) in enumerate(valid):
            prefix = f"settings_valid_{index}"
            commands = self.settings_setup() + self.session(field, value) + self.submit()
            for objective, original in INITIAL.items():
                commands += self.score(base.A, objective, expected if objective == changed else original,
                                       prefix + "_" + objective)
                commands += self.score(base.B, objective, original, prefix + "_foreign_" + objective)
            commands += self.score(ACTOR, "un_setnonce", 0, prefix + "_consumes_nonce")
            commands += self.count('@e[tag=un.setting_table]', 0, prefix + "_clears_context")
            self.case(prefix, commands)

        invalid = [(1, 3), (2, 0), (2, 33), (3, 0), (3, 11),
                   (4, 2), (5, 2), (6, 0), (6, 6), (7, 1), (0, 1)]
        for index, (field, value) in enumerate(invalid):
            prefix = f"settings_invalid_{index}"
            commands = self.settings_setup() + self.session(field, value) + self.submit()
            commands += self.unchanged(prefix)
            self.case(prefix, commands)

        for guard in ("wrong_table", "not_seated", "in_game", "other_game", "nonce", "reload", "missing_controller"):
            commands = self.settings_setup() + self.session(2, 20)
            if guard == "wrong_table":
                commands += [f"scoreboard players set {ACTOR} un_set_table 202"]
            elif guard == "not_seated":
                commands += [f"tag {ACTOR} remove ct.player"]
            elif guard == "in_game":
                commands += [f"scoreboard players set {base.A} ct_state 1"]
            elif guard == "other_game":
                commands += [f"scoreboard players set {base.A} ct_game 10"]
            elif guard == "nonce":
                commands += [f"scoreboard players set {ACTOR} un_setnonce 24"]
            elif guard == "reload":
                commands += [f"scoreboard players remove {ACTOR} un_nonce 1"]
            else:
                commands += [f"tag {base.A} remove ct.controller"]
            commands += self.submit() + self.unchanged("settings_guard_" + guard)
            self.case("settings_guard_" + guard, commands)

        commands = self.settings_setup() + self.session(2, 7) + self.submit()
        commands += [f"scoreboard players set {ACTOR} un_settings 2302032"] + self.submit()
        commands += self.score(base.A, "un_rounds", 7, "settings_same_nonce_cannot_replay")
        self.case("settings_replay", commands)

        commands = self.settings_setup() + self.session(0, 0) + self.submit()
        commands += self.unchanged("settings_done")
        commands += self.score(ACTOR, "un_setnonce", 0, "settings_done_consumes_session")
        self.case("settings_done", commands)

        commands = self.settings_setup() + self.render()
        commands += self.check('data storage uno:settings mode_row.extra[{color:"gold",bold:1b}]', "settings_current_mode_highlighted")
        commands += self.check('data storage uno:settings mode_row.extra[{click_event:{command:"trigger un_settings set 2301002"}}]', "settings_mode_choice_immediate_command")
        commands += self.check('data storage uno:settings rounds_row.extra[{click_event:{command:"trigger un_settings set 2302001"}}]', "settings_rounds_minus_five_clamps_to_one")
        commands += self.check('data storage uno:settings rounds_row.extra[{click_event:{command:"trigger un_settings set 2302008"}}]', "settings_rounds_plus_five_is_eight")
        commands += self.check('data storage uno:settings target_row.extra[{click_event:{command:"trigger un_settings set 2303010"}}]', "settings_target_plus_five_hundred_is_thousand")
        commands += self.check('data storage uno:settings window_row.extra[{click_event:{command:"trigger un_settings set 2306002"}}]', "settings_window_minus_one_is_two_seconds")
        for key, count in [("mode", 3), ("rounds", 5), ("target", 5), ("auto", 2), ("challenge", 2), ("window", 3)]:
            commands += [f"execute store result score #setting_count ut run data get storage uno:settings {key}_row.extra"]
            commands += self.score("#setting_count", "ut", count, "settings_one_page_" + key + "_controls")
        self.case("settings_components", commands)

        for suffix, rounds, target, window in [("minimum", 1, 100, 20), ("maximum", 32, 1000, 100)]:
            commands = self.settings_setup()
            commands += [f"scoreboard players set {base.A} un_rounds {rounds}",
                         f"scoreboard players set {base.A} un_target {target}",
                         f"scoreboard players set {base.A} un_window {window}"] + self.render()
            for key, index in [("rounds", 0 if suffix == "minimum" else 4), ("target", 0 if suffix == "minimum" else 4), ("window", 0 if suffix == "minimum" else 2)]:
                commands += [f'data remove storage uno_test:settings probe', f'data modify storage uno_test:settings probe set from storage uno:settings {key}_row.extra[{index}]']
                commands += self.check('data storage uno_test:settings probe{color:"dark_gray"}', "settings_" + suffix + "_" + key + "_at_boundary")
                commands += ['execute store success score #setting_click_exists ut run data get storage uno_test:settings probe.click_event']
                commands += self.score('#setting_click_exists', 'ut', 0, "settings_" + suffix + "_" + key + "_has_no_command")
            self.case("settings_" + suffix, commands)

        # 使用生产common离座函数；重新入座同桌也不能重放离座前的窗口。
        commands = self.settings_setup() + self.session(2, 20)
        commands += [f"execute as {ACTOR} at @s run function cardtable:seat/leave",
                     f"tag {ACTOR} add ct.player", f"scoreboard players set {ACTOR} ct_id 101",
                     f"scoreboard players set {ACTOR} ct_seat 1",
                     f"scoreboard players set {ACTOR} un_settings 2302020"] + self.submit()
        commands += self.score(base.A, "un_rounds", 3, "settings_leave_reentry_rejects_old_window")
        self.case("settings_leave_reentry", commands)

        commands = self.settings_setup() + self.session(2, 20)
        commands += ["scoreboard players set #pick_choice ct_ctx 1",
                     f"execute as {base.A} at @s run function cardtable:menu/select_game",
                     "scoreboard players set #pick_choice ct_ctx 11",
                     f"execute as {base.A} at @s run function cardtable:menu/select_game",
                     f"scoreboard players set {ACTOR} un_settings 2302020"] + self.submit()
        commands += self.score(base.A, "un_rounds", 3, "settings_switch_return_rejects_old_window")
        commands += self.score(base.B, "un_rounds", 3, "settings_switch_preserves_foreign_table")
        self.case("settings_switch_return", commands)


original_write_test_pack = base.write_test_pack


def write_test_pack(output: Path, source: Path):
    target, expected = original_write_test_pack(output, source)
    path = target / "data/uno/function/settings/invalidate_table.mcfunction"
    text = path.read_text(encoding="utf-8")
    text = text.replace("execute as @a if score", "execute as @e[type=minecraft:marker,tag=ut.fixture,tag=ct.player] if score")
    path.write_text(text, encoding="utf-8")
    return target, expected


if __name__ == "__main__":
    base.Fixtures = SettingsFixtures
    base.write_test_pack = write_test_pack
    sys.exit(base.main())
