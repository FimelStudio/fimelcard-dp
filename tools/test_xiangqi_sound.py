"""在独立原版26.2世界记录真实音效选择器的接收者与播放时机。"""
from pathlib import Path
import test_xiangqi as base
from test_xiangqi import A, B, person, square
from test_xiangqi_ai import Suite as AiSuite

EVENTS = ('move', 'capture', 'check', 'start', 'end', 'illegal')


class Suite(AiSuite):
    def heard(self, event, count, name, table=101, private=False):
        commands = self.score('#sound_total', 'xg', count, name + '_total')
        for current in EVENTS:
            commands += self.score('#sound_' + current, 'xg', count if current == event else 0, name + '_' + current)
        commands += self.score(person(1, table), 'xs_' + event, 1 if count else 0, name + '_red')
        commands += self.score(person(-1, table), 'xs_' + event, 0 if private or not count else 1, name + '_black')
        return commands

    def land(self, table=101):
        return sum((self.call('system/tick', table) for _ in range(8)), [])

    def build(self):
        base.Suite.build(self)
        self.cases, self.expected = [], []
        self.files['reset'] += 'scoreboard players set #sound_total xg 0\n' + '\n'.join(f'scoreboard players set #sound_{event} xg 0' for event in EVENTS) + '\n'
        self.files['person'] += 'tag @s add xs.listener\n' + '\n'.join(f'scoreboard players set @s xs_{event} 0' for event in EVENTS) + '\n'
        commands = self.setup() + self.click(1, 27) + self.click(1, 36)
        commands += self.score('#sound_total', 'xg', 0, 'move_commit_silent')
        for _ in range(7):
            commands += self.call('system/tick')
        commands += self.score('#sound_total', 'xg', 0, 'move_interpolation_silent')
        commands += self.call('system/tick') + self.heard('move', 2, 'move_landing')
        commands += self.call('system/tick') * 2 + self.score('#sound_total', 'xg', 2, 'move_no_replay')
        self.case('timeline', commands)
        for name, pieces, source, target, event in [
            ('capture', {0: 4, 18: -4}, 0, 18, 'capture'),
            ('check', {1: 4}, 1, 82, 'check'),
            ('capture_check', {1: 4, 82: -1}, 1, 82, 'check'),
        ]:
            commands = self.position_map(pieces) + self.click(1, source) + self.click(1, target)
            commands += self.score(A, 'xq_state', 2, name + '_animates') + self.score('#sound_total', 'xg', 0, name + '_commit_silent')
            commands += self.land() + self.heard(event, 2, name + '_lands')
            self.case(name, commands)
        commands = self.setup() + self.setup(table=202, reset=False)
        commands += self.click(1, 27) + self.click(1, 1) + self.click(-1, 82)
        commands += self.score('#sound_total', 'xg', 0, 'selection_silent') + self.click(1, 17)
        commands += self.heard('illegal', 1, 'illegal_private', private=True)
        commands += self.score(person(1, 202), 'xs_illegal', 0, 'illegal_other_table_silent')
        self.case('illegal', commands)
        commands = self.setup() + self.setup(table=202, reset=False)
        commands += self.click(1, 27, 202) + self.click(1, 36, 202) + self.call('system/context') + self.land(202)
        commands += self.heard('move', 2, 'table_b', table=202)
        commands += self.score(person(1), 'xs_move', 0, 'table_a_red_silent') + self.score(person(-1), 'xs_move', 0, 'table_a_black_silent')
        self.case('isolation', commands)
        for name, action in [
            ('resign', self.actor(1) + self.call('game/resign')),
            ('timeout', [f'scoreboard players set {A} xq_rtime 1'] + self.call('clock/tick')),
            ('agreed_draw', self.actor(1) + self.call('game/offer_draw') + self.actor(-1) + self.call('game/accept_draw')),
        ]:
            commands = self.setup() + action + self.heard('end', 2, name)
            commands += self.call('game/finish') + self.score('#sound_total', 'xg', 2, name + '_finish_idempotent')
            self.case(name, commands)
        commands = self.setup() + self.move(1, 27, 36) + self.actor(1) + self.call('game/offer_undo') + self.actor(-1) + self.call('game/accept_undo')
        commands += self.call('system/reload') + self.heard('move', 2, 'undo_reload_no_replay')
        commands += self.call('game/abort') + self.score('#sound_total', 'xg', 2, 'abort_silent')
        self.case('undo_reload', commands)
        commands = self.setup() + self.call('sound/start') + self.heard('start', 2, 'start_endpoint')
        self.case('start', commands)
        self.file('finish', ['function xiangqi_game_test:reset', 'say XIANGQI_DIALOGS_END', 'say XIANGQI_GAME_FINISHED'])
        self.file('bootstrap', ['forceload add -16 -16 63 31', 'scoreboard objectives add xg dummy'] + [f'scoreboard objectives add xs_{event} dummy' for event in EVENTS] + ['schedule function xiangqi_game_test:case/' + self.cases[0] + ' 40t'])
        for index, name in enumerate(self.cases):
            self.files['case/' + name] += 'schedule function xiangqi_game_test:' + ('case/' + self.cases[index+1] if index+1 < len(self.cases) else 'finish') + ' 3t\n'


original_copytree = base.shutil.copytree


def copytree(source, destination, *args, **kwargs):
    result = original_copytree(source, destination, *args, **kwargs)
    if Path(source) == base.PACK / 'data':
        for event in EVENTS:
            path = Path(destination) / f'xiangqi/function/sound/{event}.mcfunction'
            body = path.read_text(encoding='utf-8')
            command, = [line for line in body.splitlines() if f'playsound card:xiangqi.{event} ' in line]
            prefix, _ = command.split(' run playsound ', 1)
            prefix = prefix.replace('@a[', '@e[tag=xs.listener,')
            observations = [prefix + f' run scoreboard players add @s xs_{event} 1', prefix + f' run scoreboard players add #sound_{event} xg 1', prefix + ' run scoreboard players add #sound_total xg 1']
            path.write_text(body.replace(command, '\n'.join(observations + [command])), encoding='utf-8')
    return result


if __name__ == '__main__':
    suite = Suite()
    suite.build()
    base.shutil.copytree = copytree
    raise SystemExit(base.run(suite, prefix='fimel-xiangqi-sound-', manual_tick=True))
