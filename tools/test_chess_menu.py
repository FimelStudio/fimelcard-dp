"""在隔离的原版 26.2 GameTest 世界验证单个操作物和局内菜单。

临时副本用 marker 代替输入参与者，并记录 place_tool 的宏参数；实际菜单、
阶段验证、请求同意与动作处理使用生产函数。真实玩家的 Q 键仍需客户端复测。
"""

from pathlib import Path
import sys

import test_chess as base


class MenuSuite(base.Suite):
    def case(self, name, commands):
        if name == 'dialogs':
            self.menu_cases()
        super().case(name, commands)

    def quick(self, side=1, tool=0):
        return [f'scoreboard players set #ui_tool ch_ctx {tool}',
                f'execute as {base.person(side)} at @s run function chess:ui/quick']

    def submit(self, side, code):
        person = base.person(side)
        return [f'scoreboard players operation {person} ch_action = {person} ch_seen',
                'scoreboard players set #hundred cg 100',
                f'scoreboard players operation {person} ch_action *= #hundred cg',
                f'scoreboard players add {person} ch_action {code}',
                f'execute as {person} at @s run function chess:input/submit']

    def buttons(self, count, name):
        return ['execute store result score #menu_count cg run data get storage chess:ui buttons'] + self.score('#menu_count', 'cg', count, name)

    def label(self, label, name, present=True):
        return self.check(('' if present else 'unless ') + f'data storage chess:ui buttons[{{label:{{text:"{label}"}}}}]', name) if present else [
            f'execute unless data storage chess:ui buttons[{{label:{{text:"{label}"}}}}] run say CHESS_GAME_PASS {name}',
            f'execute if data storage chess:ui buttons[{{label:{{text:"{label}"}}}}] run say CHESS_GAME_FAIL {name}']

    def absent(self, label, name):
        self.expected.append(name)
        return self.label(label, name, present=False)

    def menu_cases(self):
        commands = self.setup() + ['data modify storage chess_game_test:menu placed set value []',
                                  f'execute as {base.person(1)} at @s run function chess:input/give']
        commands += ['execute store result score #menu_count cg run data get storage chess_game_test:menu placed']
        commands += self.score('#menu_count', 'cg', 1, 'menu_only_one_tool')
        commands += self.check('data storage chess_game_test:menu placed[{slot:8,action:0,table:101,model:"minecraft:book"}]', 'menu_last_slot_current_table')
        commands += self.quick() + self.buttons(3, 'menu_three_actions')
        for label in ('悔棋', '和棋', '认输'):
            commands += self.label(label, 'menu_main_' + {'悔棋': 'undo', '和棋': 'draw', '认输': 'resign'}[label])
        commands += self.absent('认领规则和棋', 'menu_hides_ineligible_rule_claim')
        commands += self.submit(1, 9) + self.score(base.A, 'ch_state', 1, 'menu_resign_opens_confirmation')
        commands += self.buttons(1, 'menu_resign_only_confirmation') + self.label('确认认输', 'menu_confirmation_visible')
        commands += self.submit(1, 1) + self.score(base.A, 'ch_result', 2, 'menu_confirm_resigns')
        self.case('menu_tool_and_resign', commands)

        commands = self.setup() + self.move(1, 12, 28) + self.quick() + self.submit(1, 6)
        commands += self.score(base.A, 'ch_undo', 1, 'menu_undo_requires_response')
        commands += self.score(base.square(28), 'ch_piece', 1, 'menu_undo_request_does_not_move')
        commands += self.quick(-1) + self.label('同意悔棋', 'menu_undo_accept_visible') + self.label('拒绝悔棋', 'menu_undo_decline_visible')
        commands += self.submit(-1, 7) + self.score(base.square(12), 'ch_piece', 1, 'menu_opponent_accepts_undo')
        self.case('menu_undo_consent', commands)

        commands = self.setup() + self.quick() + self.submit(1, 2)
        commands += self.score(base.A, 'ch_draw', 1, 'menu_draw_requires_response')
        commands += self.score(base.A, 'ch_state', 1, 'menu_draw_request_continues')
        commands += self.quick(-1) + self.label('接受和棋', 'menu_draw_accept_visible') + self.label('拒绝和棋', 'menu_draw_decline_visible')
        commands += self.submit(-1, 3) + self.score(base.A, 'ch_result', 3, 'menu_opponent_accepts_draw')
        self.case('menu_draw_consent', commands)

        for bot_action in (2, 6):
            commands = self.setup() + [f'scoreboard players set {base.A} ch_bot -1'] + self.move(1, 12, 28)
            commands += self.quick() + self.submit(1, bot_action)
            if bot_action == 2:
                commands += self.score(base.A, 'ch_result', 3, 'menu_bot_agrees_draw')
            else:
                commands += self.score(base.square(12), 'ch_piece', 1, 'menu_bot_agrees_undo')
            self.case('menu_bot_' + str(bot_action), commands)

        for phase in (2, 3):
            commands = self.setup() + [f'scoreboard players set {base.A} ch_state {phase}'] + self.quick()
            commands += self.label('认输', f'menu_phase_{phase}_resign_visible')
            commands += self.submit(1, 9) + self.score(base.A, 'ch_state', phase, f'menu_phase_{phase}_confirmation_only')
            commands += self.submit(1, 1) + self.score(base.A, 'ch_result', 2, f'menu_phase_{phase}_can_resign')
            self.case('menu_phase_' + str(phase), commands)

        for half, repetition in ((100, 1), (0, 3)):
            commands = self.setup() + [f'scoreboard players set {base.A} ch_half {half}',
                                       f'scoreboard players set {base.A} ch_repetition {repetition}'] + self.quick()
            commands += self.label('认领规则和棋', f'menu_rule_claim_{half}_{repetition}')
            self.case(f'menu_claim_{half}_{repetition}', commands)

        # 一个窗口打开后回合变化，仍不能借新菜单认输确认或发起旧请求。
        commands = self.setup() + self.quick() + [f'scoreboard players add {base.A} ch_epoch 1'] + self.submit(1, 9)
        commands += self.score(base.A, 'ch_state', 1, 'menu_stale_resign_cannot_end_game')
        commands += self.absent('确认认输', 'menu_stale_window_cannot_open_confirmation')
        self.case('menu_stale', commands)

        # 结算五秒内仍可按 Q：没有可选动作时必须使用 notice，不能编译 actions:[]。
        commands = self.setup() + [f'scoreboard players set {base.A} ch_state 4',
                                   'scoreboard players set #menu_notice cg 0',
                                   'scoreboard players set #menu_actions cg 0'] + self.quick()
        commands += self.buttons(0, 'menu_result_has_no_actions')
        commands += self.score('#menu_notice', 'cg', 1, 'menu_result_uses_notice')
        commands += self.score('#menu_actions', 'cg', 0, 'menu_result_skips_invalid_empty_multi_action')
        self.case('menu_result_notice', commands)


original_copytree = base.shutil.copytree
original_dumps = base.json.dumps


def copytree(source, destination, *args, **kwargs):
    result = original_copytree(source, destination, *args, **kwargs)
    if Path(source) == base.PACK / 'data':
        root = Path(destination) / 'chess/function'
        for folder in ('input', 'ui'):
            for path in (root / folder).glob('*.mcfunction'):
                lines = path.read_text(encoding='utf-8').splitlines()
                for index, line in enumerate(lines):
                    if 'dialog show' not in line and 'tellraw' not in line:
                        lines[index] = line.replace('@a[', '@e[type=minecraft:marker,tag=cg.fixture,')
                text = '\n'.join(lines) + '\n'
                if path.name == 'place_tool.mcfunction':
                    text = '$data modify storage chess_game_test:menu placed append value {slot:$(slot),action:$(action),table:$(table),model:"$(model)"}\n' + text
                if path.name in ('notice_show.mcfunction', 'actions_show.mcfunction'):
                    counter = 'notice' if path.name == 'notice_show.mcfunction' else 'actions'
                    text = f'scoreboard players add #menu_{counter} cg 1\n' + text
                path.write_text(text, encoding='utf-8')
    return result


def dumps(value, *args, **kwargs):
    if isinstance(value, dict) and value.get('setup_ticks') == 240:
        value = dict(value, setup_ticks=400)
    return original_dumps(value, *args, **kwargs)


if __name__ == '__main__':
    base.Suite = MenuSuite
    base.shutil.copytree = copytree
    base.json.dumps = dumps
    sys.exit(base.main())
