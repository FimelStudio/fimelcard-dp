"""在隔离的原版 26.2 GameTest 世界中验证国际象棋单页即时设置。

复用整包国际象棋 Suite 和启动器，额外检查实际提交路径、会话防重放与本桌隔离。
只有临时测试副本会把设置参与者的玩家选择器替换为 marker；Dialog 的玩家目标
保持不变，生产函数不含测试分支。客户端真实点击与外观仍需游戏内复测。
"""

from __future__ import annotations

from pathlib import Path
import sys

import test_chess as base


ACTOR = '@e[type=minecraft:marker,tag=cst.actor,limit=1]'
INITIAL = {'ch_board': 0, 'ch_palette': 0, 'ch_orient': 0,
           'ch_first': 0, 'ch_time': 10, 'ch_level': 2, 'ch_hints': 1}


class SettingsSuite(base.Suite):
    def case(self, name, commands):
        if name == 'dialogs':
            self.settings_cases()
        super().case(name, commands)

    def settings_setup(self, cap=4):
        return (self.setup(cap) + self.setup(cap, table=202, reset=False)
                + [f'scoreboard players set {base.A} ct_state 0',
                   f'scoreboard players set {base.B} ct_state 0',
                   f'tag {base.person(1)} add cst.actor',
                   'scoreboard players set #setting_serial ch_ctx 100000'])

    def session(self, field, value, nonce=100000, legacy=False):
        code = int(f'{nonce}{field}{value}') if legacy else nonce * 1000 + field * 100 + value
        return [f'scoreboard players operation {ACTOR} ch_nonce = #ui_load ch_ctx',
                f'scoreboard players set {ACTOR} ch_setnonce {nonce}',
                f'scoreboard players set {ACTOR} ch_set_table 101',
                f'scoreboard players operation {ACTOR} ch_setepoch = {base.A} ch_epoch',
                f'scoreboard players set {ACTOR} ch_settings {code}']

    def submit(self):
        return [f'execute as {ACTOR} at @s run function chess:settings/save']

    def unchanged(self, prefix):
        commands = []
        for objective, value in INITIAL.items():
            commands += self.score(base.A, objective, value, prefix + '_' + objective)
        return commands

    def render(self):
        return self.call('settings/prepare') + self.call('settings/root')

    def settings_cases(self):
        valid = [(1, 0, 'ch_board', 0), (1, 4, 'ch_board', 4),
                 (2, 0, 'ch_palette', 0), (2, 3, 'ch_palette', 3),
                 (3, 0, 'ch_orient', 0), (3, 1, 'ch_orient', 1),
                 (4, 0, 'ch_first', 0), (4, 1, 'ch_first', 1)]
        valid += [(5, minutes, 'ch_time', minutes) for minutes in (0, 5, 10, 15, 20, 25, 30)]
        valid += [(6, level, 'ch_level', level) for level in (1, 2, 3)]
        valid += [(7, enabled, 'ch_hints', enabled) for enabled in (0, 1)]
        for index, (field, value, changed, expected) in enumerate(valid):
            prefix = f'settings_valid_{index}'
            commands = self.settings_setup() + self.session(field, value) + self.submit()
            for objective, original in INITIAL.items():
                commands += self.score(base.A, objective, expected if objective == changed else original,
                                       prefix + '_' + objective)
                commands += self.score(base.B, objective, original, prefix + '_foreign_' + objective)
            commands += self.score(ACTOR, 'ch_setnonce', 100001, prefix + '_renews_session')
            commands += self.count('@e[tag=ch.setting_table]', 0, prefix + '_clears_context')
            self.case(prefix, commands)

        # 兼容旧设置码：原一位值为 8 位，两位计时为 9 位；不能误解码新格式。
        for index, (field, value, changed) in enumerate([(1, 4, 'ch_board'), (4, 1, 'ch_first'), (5, 5, 'ch_time'), (5, 30, 'ch_time')]):
            prefix = f'settings_legacy_{index}'
            commands = self.settings_setup() + self.session(field, value, legacy=True) + self.submit()
            commands += self.score(base.A, changed, value, prefix + '_value')
            commands += self.score(ACTOR, 'ch_setnonce', 100001, prefix + '_renews_session')
            self.case(prefix, commands)

        invalid = [(1, 5), (2, 4), (3, 2), (4, 2), (4, 8),
                   (5, 1), (5, 7), (5, 31), (6, 0), (6, 4),
                   (7, 2), (7, 99), (8, 0), (0, 1)]
        for index, (field, value) in enumerate(invalid):
            prefix = f'settings_invalid_{index}'
            commands = self.settings_setup() + self.session(field, value) + self.submit()
            commands += self.unchanged(prefix)
            self.case(prefix, commands)

        for guard in ('wrong_table', 'not_seated', 'in_game', 'other_game',
                      'nonce', 'reload', 'epoch', 'missing_controller'):
            commands = self.settings_setup() + self.session(1, 4)
            if guard == 'wrong_table':
                commands += [f'scoreboard players set {ACTOR} ch_set_table 202']
            elif guard == 'not_seated':
                commands += [f'tag {ACTOR} remove ct.player']
            elif guard == 'in_game':
                commands += [f'scoreboard players set {base.A} ct_state 1']
            elif guard == 'other_game':
                commands += [f'scoreboard players set {base.A} ct_game 11']
            elif guard == 'nonce':
                commands += [f'scoreboard players set {ACTOR} ch_setnonce 100001']
            elif guard == 'reload':
                commands += ['function chess:load']
            elif guard == 'epoch':
                commands += [f'scoreboard players add {base.A} ch_epoch 1']
            else:
                commands += [f'tag {base.A} remove ct.controller']
            commands += self.submit() + self.unchanged('settings_guard_' + guard)
            self.case('settings_guard_' + guard, commands)

        commands = self.settings_setup() + self.session(1, 4) + self.submit()
        commands += [f'scoreboard players set {ACTOR} ch_settings 100000100'] + self.submit()
        commands += self.score(base.A, 'ch_board', 4, 'settings_consumed_nonce_cannot_replay')
        self.case('settings_replay', commands)

        commands = self.settings_setup() + self.session(0, 0) + self.submit()
        commands += self.unchanged('settings_done')
        commands += ['scoreboard players set #setting_session cg 0',
                     f'execute if score {ACTOR} ch_setnonce matches 0.. run scoreboard players set #setting_session cg 1']
        commands += self.score('#setting_session', 'cg', 0, 'settings_done_consumes_session')
        self.case('settings_done', commands)

        commands = self.settings_setup() + self.render()
        commands += self.check('data storage chess:settings board_row.extra[{text:" [经典黑白] ",color:"gold",bold:1b}]', 'settings_board_highlight')
        commands += self.check('data storage chess:settings palette_row.extra[{text:" [黑白] ",color:"gold",bold:1b}]', 'settings_palette_highlight')
        commands += self.check('data storage chess:settings orient_row.extra[{text:" [南北向 · 白方南侧] ",color:"gold",bold:1b}]', 'settings_orient_highlight')
        commands += self.check('data storage chess:settings first_row.extra[{text:" [随机分配黑白] ",color:"gold",bold:1b}]', 'settings_first_highlight')
        commands += self.check('data storage chess:settings time_row.extra[{text:" [10分钟] ",color:"gold",bold:1b}]', 'settings_time_highlight')
        commands += self.check('data storage chess:settings level_row.extra[{text:" [普通] ",color:"gold",bold:1b}]', 'settings_level_highlight')
        commands += self.check('data storage chess:settings hints_row.extra[{text:" [开启] ",color:"gold",bold:1b}]', 'settings_hints_highlight')
        commands += self.check('data storage chess:settings board_row.extra[{click_event:{command:"trigger ch_settings set 100000104"}}]', 'settings_board_choice_immediate_command')
        commands += self.check('data storage chess:settings first_row.extra[{click_event:{command:"trigger ch_settings set 100000401"}}]', 'settings_side_choice_immediate_command')
        commands += self.check('data storage chess:settings time_row.extra[{click_event:{command:"trigger ch_settings set 100000530"}}]', 'settings_time_choice_immediate_command')
        commands += self.check('data storage chess:settings level_row.extra[{click_event:{command:"trigger ch_settings set 100000603"}}]', 'settings_level_choice_immediate_command')
        commands += self.check('data storage chess:settings hints_row.extra[{click_event:{command:"trigger ch_settings set 100000700"}}]', 'settings_hints_choice_immediate_command')
        for key, count in [('board', 5), ('palette', 4), ('orient', 2), ('first', 2), ('time', 7), ('level', 3), ('hints', 2)]:
            commands += [f'execute store result score #setting_count cg run data get storage chess:settings {key}_row.extra']
            commands += self.score('#setting_count', 'cg', count, 'settings_single_page_' + key + '_controls')
            commands += [f'data modify storage chess_game_test:settings probe set from storage chess:settings {key}_row.extra[{{color:"gold",bold:1b}}]',
                         'execute store success score #setting_click cg run data get storage chess_game_test:settings probe.click_event']
            commands += self.score('#setting_click', 'cg', 0, 'settings_current_' + key + '_has_no_command')
        self.case('settings_components', commands)

        commands = self.settings_setup() + self.session(1, 4) + self.submit()
        commands += self.check('data storage chess:settings board_row.extra[{text:" [薰衣草紫] ",color:"gold",bold:1b}]', 'settings_changed_choice_highlight')
        commands += self.check('data storage chess:settings board_row.extra[{click_event:{command:"trigger ch_settings set 100001100"}}]', 'settings_reopened_choice_has_new_nonce')
        commands += self.check('data storage chess:settings {close:100001000}', 'settings_done_has_new_nonce')
        self.case('settings_updated_components', commands)

        commands = self.settings_setup() + self.session(7, 1, nonce=999999)
        commands += ['scoreboard players set #setting_serial ch_ctx 999999',
                     'scoreboard players operation #old_ui_load cg = #ui_load ch_ctx'] + self.submit()
        commands += self.score(base.A, 'ch_hints', 1, 'settings_maximum_nonce_accepts_field_seven')
        commands += self.score(ACTOR, 'ch_setnonce', 100000, 'settings_nonce_wraps_safely')
        commands += ['scoreboard players add #old_ui_load cg 1']
        commands += self.check('score #ui_load ch_ctx = #old_ui_load cg', 'settings_nonce_wrap_invalidates_old_generation')
        commands += self.check(f'score {ACTOR} ch_nonce = #ui_load ch_ctx', 'settings_nonce_wrap_rebinds_actor')
        self.case('settings_nonce_boundary', commands)

        commands = self.settings_setup() + self.session(7, 0) + self.submit()
        commands += self.check('data storage chess:settings hints_row.extra[{text:" [关闭] ",color:"gold",bold:1b}]', 'settings_disabled_hints_highlight')
        commands += self.check('data storage chess:settings hints_row.extra[{click_event:{command:"trigger ch_settings set 100001701"}}]', 'settings_hints_can_reenable_immediately')
        commands += self.session(6, 3, nonce=100001) + self.submit()
        commands += self.score(base.A, 'ch_hints', 0, 'settings_level_preserves_hints')
        commands += self.score(base.A, 'ch_level', 3, 'settings_difficulty_changed_after_hints')
        self.case('settings_ai_and_hints_sequence', commands)

        commands = self.settings_setup() + self.session(1, 4)
        commands += [f'scoreboard players set {base.person(1, 202)} ch_setnonce 100012',
                     f'scoreboard players set {base.person(1, 202)} ch_set_table 202']
        commands += self.call('settings/invalidate_table')
        commands += [f'scoreboard players set {ACTOR} ch_settings 100000104'] + self.submit()
        commands += self.score(base.A, 'ch_board', 0, 'settings_clear_table_rejects_old_window')
        commands += self.score(base.person(1, 202), 'ch_setnonce', 100012, 'settings_clear_table_preserves_foreign_session')
        self.case('settings_invalidate_table', commands)

        commands = self.settings_setup() + self.session(1, 4)
        commands += [f'execute as {ACTOR} at @s run function cardtable:seat/leave',
                     f'tag {ACTOR} add ct.player', f'scoreboard players set {ACTOR} ct_id 101',
                     f'scoreboard players set {ACTOR} ct_seat 3',
                     f'scoreboard players set {ACTOR} ch_settings 100000104'] + self.submit()
        commands += self.score(base.A, 'ch_board', 0, 'settings_leave_reentry_rejects_old_window')
        self.case('settings_leave_reentry', commands)

        commands = self.settings_setup() + self.session(1, 4)
        commands += ['scoreboard players set #pick_choice ct_ctx 11',
                     f'execute as {base.A} at @s run function cardtable:menu/select_game',
                     'scoreboard players set #pick_choice ct_ctx 12',
                     f'execute as {base.A} at @s run function cardtable:menu/select_game',
                     f'scoreboard players set {ACTOR} ch_settings 100000104'] + self.submit()
        commands += self.score(base.A, 'ch_board', 0, 'settings_switch_return_rejects_old_window')
        commands += self.score(base.B, 'ch_board', 0, 'settings_switch_preserves_foreign_table')
        self.case('settings_switch_return', commands)


original_copytree = base.shutil.copytree
original_dumps = base.json.dumps


def copytree(source, destination, *args, **kwargs):
    result = original_copytree(source, destination, *args, **kwargs)
    if Path(source) == base.PACK / 'data':
        root = Path(destination)
        for path in (root / 'chess/function/settings').glob('*.mcfunction'):
            lines = path.read_text(encoding='utf-8').splitlines()
            for index, line in enumerate(lines):
                if 'dialog show' not in line and 'tellraw' not in line:
                    lines[index] = line.replace('@a[tag=ct.settings_actor', '@e[type=minecraft:marker,tag=cg.fixture,tag=ct.settings_actor')
            text = '\n'.join(lines) + '\n'
            if path.stem == 'invalidate_table':
                text = text.replace('execute as @a if score', 'execute as @e[type=minecraft:marker,tag=cg.fixture,tag=ct.player] if score')
            path.write_text(text, encoding='utf-8')
    return result


def dumps(value, *args, **kwargs):
    # 额外设置场景在同一原版服务器内运行，需要给环境调度链足够时间。
    if isinstance(value, dict) and value.get('setup_ticks') == 240:
        value = dict(value, setup_ticks=600)
    return original_dumps(value, *args, **kwargs)


if __name__ == '__main__':
    base.Suite = SettingsSuite
    base.shutil.copytree = copytree
    base.json.dumps = dumps
    sys.exit(base.main())
