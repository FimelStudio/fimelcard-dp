"""Exercise chess sound timing and recipients in an isolated vanilla 26.2 world.

The temporary pack records each actual playsound recipient, preserving its
context, audience and table guards. Production files and player saves are never
changed. Audio fidelity and client volume controls still need a listening check.
"""
from pathlib import Path
import argparse
import json
import re
import shutil
import subprocess
import tempfile
import time

from test_chess import A, B, PACK, Suite as BaseSuite, person, square


EVENTS = ('move', 'capture', 'castle', 'check', 'start', 'end', 'illegal')


class Suite(BaseSuite):
    def heard(self, event, recipients, name, table=101, private=False):
        lines = self.score('#total', 'cg', recipients, name + '_total')
        for current in EVENTS:
            lines += self.score('#' + current, 'cg', recipients if current == event else 0, name + '_' + current)
        lines += self.score(person(1, table), 'cs_' + event, 1 if recipients else 0, name + '_white')
        lines += self.score(person(-1, table), 'cs_' + event, 0 if private or not recipients else 1, name + '_black')
        return lines

    def quiet(self, name):
        return self.score('#total', 'cg', 0, name)

    def land(self, table=101):
        return sum((self.call('system/tick', table) for _ in range(8)), [])

    def build(self):
        reset = ['kill @e[tag=ch.visual]', 'kill @e[tag=ch.square]', 'kill @e[tag=cg.fixture]', 'kill @e[tag=ct.menu]', 'kill @e[tag=ct.vote]',
                 'scoreboard players set #total cg 0']
        reset += [f'scoreboard players set #{event} cg 0' for event in EVENTS]
        self.file('reset', reset)
        self.file('table', '''
tag @s add cg.fixture
tag @s add cg.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_capacity $(cap)
scoreboard players set @s ct_game 12
scoreboard players set @s ct_state 0
scoreboard players set @s ct_joined 2
function chess:game/init_table
scoreboard players set @s ch_state 1
scoreboard players set @s ct_state 1
scoreboard players set @s ch_wtime 12000
scoreboard players set @s ch_btime 12000
scoreboard players set @s ch_white 3
scoreboard players set @s ch_black 1
scoreboard players set @s ch_pulse -1000
$execute summon minecraft:marker run function chess_game_test:person {table:$(table),side:1,seat:3}
$execute summon minecraft:marker run function chess_game_test:person {table:$(table),side:-1,seat:1}
function chess:system/context
function chess:clock/create
''')
        self.file('person', '''
tag @s add cg.fixture
tag @s add cs.listener
tag @s add ch.player
tag @s add ct.player
$scoreboard players set @s ch_side $(side)
$scoreboard players set @s ch_seat $(seat)
$scoreboard players set @s ct_seat $(seat)
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ch_table $(table)
scoreboard players set @s ct_online 1
''' + '\n'.join(f'scoreboard players set @s cs_{event} 0' for event in EVENTS))

        # Real move submission mutates the board immediately, while the sound
        # must wait for the eighth animation tick instead of playing on click.
        lines = self.setup() + self.click(1, 12) + self.click(1, 28)
        lines += self.score(square(28), 'ch_piece', 1, 'move_committed') + self.quiet('move_no_sound_at_commit')
        for _ in range(7):
            lines += self.call('system/tick')
        lines += self.quiet('move_no_sound_during_animation') + self.score(A, 'ch_timer', 1, 'move_one_tick_left')
        lines += self.call('system/tick') + self.heard('move', 2, 'move_lands')
        lines += self.call('system/tick') * 2 + self.score('#total', 'cg', 2, 'move_no_tick_replay')
        self.case('move_timeline', lines)

        scenarios = [
            ('capture', '4k3/8/8/3p4/4P3/8/8/4K3', 28, 35, 'capture', {}),
            ('en_passant', '4k3/8/8/3pP3/8/8/8/4K3', 36, 43, 'capture', {'ep': 43}),
            ('castle', '4k3/8/8/8/8/8/8/R3K2R', 4, 6, 'castle', {'castle': 3}),
            ('castle_check', '5k2/8/8/8/8/8/8/4K2R', 4, 6, 'check', {'castle': 1}),
            ('check', '4k3/8/8/8/8/8/4R3/4K3', 12, 52, 'check', {}),
            ('capture_check', '4k3/4p3/8/8/8/8/4R3/4K3', 12, 52, 'check', {}),
        ]
        for name, fen, source, target, event, options in scenarios:
            lines = self.position(fen, **options) + self.click(1, source) + self.click(1, target)
            lines += self.score(A, 'ch_state', 2, name + '_animates') + self.quiet(name + '_silent_before_landing')
            lines += self.land() + self.heard(event, 2, name + '_lands')
            self.case(name, lines)

        for name, fen, target, promotion, event in [
            ('promotion', '4k2r/P7/8/8/8/8/8/4K3', 56, 2, 'move'),
            ('promotion_capture', '1r2k3/P6p/8/8/8/8/8/4K3', 57, 2, 'capture'),
            ('promotion_check', '4k2r/P7/8/8/8/8/8/4K3', 56, 5, 'check'),
        ]:
            lines = self.position(fen) + self.click(1, 48) + self.click(1, target)
            lines += self.score(A, 'ch_state', 3, name + '_choice_pending') + self.quiet(name + '_choice_silent')
            lines += self.actor(1) + [f'scoreboard players set #promo ch_ctx {promotion}'] + self.call('game/promote')
            lines += self.quiet(name + '_commit_silent') + self.land() + self.heard(event, 2, name + '_lands')
            self.case(name, lines)

        # Mating moves replace the ordinary landing cue with the end cue.
        lines = self.position('7k/5Q2/6K1/8/8/8/8/8') + self.click(1, 53) + self.click(1, 61)
        lines += self.score(A, 'ch_result', 1, 'mate_detected_before_landing') + self.quiet('mate_commit_silent')
        lines += self.land() + self.heard('end', 2, 'mate_lands') + self.score(A, 'ch_state', 4, 'mate_finished')
        lines += self.call('game/finish') + self.score('#total', 'cg', 2, 'finish_reentry_no_sound_replay')
        self.case('mate_end_once', lines)

        lines = self.position('5r1k/5Q2/6K1/8/8/8/8/8') + self.click(1, 53) + self.click(1, 61)
        lines += self.score(A, 'ch_result', 1, 'capture_mate_detected') + self.quiet('capture_mate_commit_silent')
        lines += self.land() + self.heard('end', 2, 'capture_mate_lands')
        self.case('capture_mate', lines)

        for name, action in [('resign', self.actor(1) + self.call('game/resign')),
                             ('timeout', [f'scoreboard players set {A} ch_wtime 1'] + self.call('clock/tick')),
                             ('draw', self.actor(1) + self.call('game/offer_draw') + self.actor(-1) + self.call('game/accept_draw'))]:
            lines = self.setup() + action + self.heard('end', 2, name + '_ends')
            lines += self.call('game/finish') + self.score('#total', 'cg', 2, name + '_finish_not_replayed')
            self.case(name, lines)

        # Selecting/reselecting and a wrong-turn click are silent. Only the
        # actor who actually submits an illegal move receives the rejection.
        lines = self.setup() + self.setup(table=202, reset=False)
        lines += self.click(1, 12) + self.click(1, 6) + self.click(-1, 52) + self.quiet('selection_and_wrong_turn_silent')
        lines += self.click(1, 36) + self.heard('illegal', 1, 'illegal_actor_only', private=True)
        for side in (1, -1):
            lines += self.score(person(side, 202), 'cs_illegal', 0, 'illegal_other_table_' + ('white' if side == 1 else 'black'))
        self.case('illegal_private', lines)

        # Context must be rebuilt inside the sound endpoint, not inherited
        # from whichever table most recently ran its tick or UI handler.
        lines = self.setup() + self.setup(table=202, reset=False)
        lines += self.click(1, 12, 202) + self.click(1, 28, 202) + self.call('system/context')
        lines += self.land(202) + self.heard('move', 2, 'table_b_landing', table=202)
        for side in (1, -1):
            lines += self.score(person(side), 'cs_move', 0, 'table_a_does_not_hear_b_' + ('white' if side == 1 else 'black'))
        self.case('table_context', lines)

        lines = self.setup() + self.move(1, 12, 28) + self.actor(1) + self.call('game/offer_undo')
        lines += self.actor(-1) + self.call('game/accept_undo') + self.score(square(12), 'ch_piece', 1, 'undo_restores_board')
        lines += self.call('system/reload') + self.heard('move', 2, 'undo_and_reload_do_not_replay')
        lines += self.call('game/abort') + self.score('#total', 'cg', 2, 'abort_no_end_cue')
        self.case('undo_reload_abort', lines)

        # Actual start succeeds only after both players/seat checks. A failed
        # start must never emit the start cue or give the impression of play.
        lines = self.setup() + [f'scoreboard players set {A} ct_state 0', f'scoreboard players set {A} ct_joined 1']
        lines += self.call('game/start') + self.quiet('failed_start_silent')
        lines += [f'scoreboard players set {A} ct_joined 2'] + self.call('game/start')
        lines += self.score(A, 'ct_start', 1, 'successful_start_initialized') + self.heard('start', 2, 'successful_start')
        lines += self.call('system/reload') + self.score('#total', 'cg', 2, 'reload_no_start_replay')
        self.case('start', lines)

        self.file('finish', ['function chess_game_test:reset', 'say CHESS_SOUND_FINISHED'])
        self.file('bootstrap', ['forceload add -16 -16 63 31', 'scoreboard objectives add cg dummy']
                  + [f'scoreboard objectives add cs_{event} dummy' for event in EVENTS]
                  + ['schedule function chess_game_test:case/' + self.cases[0] + ' 40t'])
        for index, name in enumerate(self.cases):
            self.files['case/' + name] += 'schedule function chess_game_test:' + ('case/' + self.cases[index+1] if index+1 < len(self.cases) else 'finish') + ' 2t\n'


def instrument(target):
    """Observe the recipient selected by the actual playsound command."""
    for event in EVENTS:
        path = target / f'data/chess/function/sound/{event}.mcfunction'
        body = path.read_text(encoding='utf-8')
        commands = [line for line in body.splitlines() if f'playsound card:chess.{event} ' in line]
        assert len(commands) == 1, (event, commands)
        command = commands[0]
        prefix, sound = command.split(' run playsound ', 1)
        # Keep the real playsound for command/codec parsing. An adjacent
        # test-only observation uses the same full selector and score guards.
        fixture_prefix = prefix.replace('@a[', '@e[tag=cs.listener,')
        observations = [fixture_prefix + f' run scoreboard players add @s cs_{event} 1',
                        fixture_prefix + f' run scoreboard players add #{event} cg 1',
                        fixture_prefix + ' run scoreboard players add #total cg 1']
        assert sound.startswith(f'card:chess.{event} block @s '), sound
        path.write_text(body.replace(command, '\n'.join(observations + [command])), encoding='utf-8')
    # Simulate online participants only for non-UI backend operations. The
    # common start/seat logic and all sound guards remain the real functions.
    for name in ['game/start', 'game/assign_sides', 'game/random_first', 'game/chosen_first', 'game/reseat', 'system/reload']:
        path = target / f'data/chess/function/{name}.mcfunction'
        lines = []
        for line in path.read_text(encoding='utf-8').splitlines():
            if 'if items entity' in line or 'run function chess:input/give' in line:
                continue
            if not any(command in line for command in ('tellraw ', 'title ', 'dialog ')):
                line = line.replace('@a[tag=ct.player]', '@e[tag=cs.listener,tag=ct.player]')
                line = line.replace('@a[tag=ch.audience', '@e[tag=cs.listener,tag=ch.audience')
            lines.append(line)
        path.write_text('\n'.join(lines) + '\n', encoding='utf-8')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--java', type=Path, default=Path('C:/Temp/fimel-uno-java25/jdk-25.0.5+8-jre/bin/java.exe'))
    parser.add_argument('--minecraft-root', type=Path, default=Path('D:/PCL2/MinecraftPcl'))
    parser.add_argument('--version', default='26.2-Fabric_0.19.3')
    args = parser.parse_args()
    output = Path(tempfile.mkdtemp(prefix='fimel-chess-sound-'))
    target = output / 'packs/fimel_cards'
    shutil.copytree(PACK / 'data', target / 'data')
    shutil.copy2(PACK / 'pack.mcmeta', target / 'pack.mcmeta')
    instrument(target)
    suite = Suite()
    suite.build()
    for name, body in suite.files.items():
        path = target / 'data/chess_sound_test/function' / (name + '.mcfunction')
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(body.replace('function chess_game_test:', 'function chess_sound_test:'), encoding='utf-8')
    for name, body in {
        'test_environment/default.json': {'type': 'minecraft:function', 'setup': 'chess_sound_test:bootstrap'},
        'test_instance/sound.json': {'type': 'minecraft:function', 'environment': 'chess_sound_test:default', 'function': 'minecraft:always_pass', 'max_ticks': 1, 'setup_ticks': 200, 'required': True, 'structure': 'minecraft:empty'},
    }.items():
        path = target / 'data/chess_sound_test' / name
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(json.dumps(body), encoding='utf-8')
    launch = args.minecraft_root / 'versions' / args.version / (args.version + '.json')
    meta = json.loads(launch.read_text(encoding='utf-8-sig'))
    classpath = [launch.with_suffix('.jar')]
    for library in meta['libraries']:
        artifact = library.get('downloads', {}).get('artifact', {})
        if artifact.get('path'):
            path = args.minecraft_root / 'libraries' / artifact['path']
            if path.is_file():
                classpath.append(path)
    options = ['-Xms256M', '-Xmx1536M', '-Djava.awt.headless=true', '-Dfile.encoding=UTF-8', '--enable-native-access=ALL-UNNAMED', '-cp', ';'.join(map(str, classpath)), 'net.minecraft.gametest.Main', '--packs', str(output/'packs'), '--universe', str(output/'universe'), '--tests', 'chess_sound_test:*', '--report', str(output/'gametest.xml')]
    argfile = output / 'java-args.txt'
    argfile.write_text('\n'.join('"' + value.replace('\\', '\\\\').replace('"', '\\"') + '"' for value in options), encoding='utf-8')
    print('Chess sound GameTest: ' + str(output), flush=True)
    start = time.monotonic()
    process = subprocess.run([str(args.java), '@' + str(argfile)], cwd=output, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, encoding='utf-8', errors='replace', timeout=180)
    (output / 'game.log').write_text(process.stdout, encoding='utf-8')
    passed = set(re.findall(r'CHESS_GAME_PASS ([a-z0-9_]+)', process.stdout))
    failed = sorted(set(re.findall(r'CHESS_GAME_FAIL ([a-z0-9_]+)', process.stdout)))
    errors = [line for line in process.stdout.splitlines() if any(part in line for part in ('[ERROR]', '/ERROR]', 'Failed to load', 'Failed to parse', 'Unknown function', 'Unknown or incomplete command', "Couldn't parse", 'Command execution stopped'))]
    result = {'exit_code': process.returncode, 'seconds': round(time.monotonic()-start, 1), 'assertions': len(suite.expected), 'passed': len(passed), 'failed': failed, 'missing': sorted(set(suite.expected)-passed), 'errors': errors, 'finished': 'CHESS_SOUND_FINISHED' in process.stdout, 'output': str(output)}
    (output / 'result.json').write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding='utf-8')
    print(json.dumps(result, ensure_ascii=False, indent=2), flush=True)
    return int(bool(process.returncode or failed or result['missing'] or errors or not result['finished']))


if __name__ == '__main__':
    raise SystemExit(main())
