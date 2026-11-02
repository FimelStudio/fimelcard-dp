"""CC0 audio assets plus isolated vanilla 26.2 playback/settings GameTests.

The test pack observes the real audience guards using marked fixture listeners.
Client-only commands remain intact, so vanilla still parses every Dialog and
sound command. This does not claim to inspect how a real client renders/hears it.
"""
from pathlib import Path
import hashlib
import json
import math
import re
import shutil
import subprocess
import sys
import numpy as np
import build_catan_settings as settings
import build_catan_sound as sound
import test_love_letter_engine as base

TABLE = '@e[type=minecraft:marker,tag=cs.table,scores={ct_id=101},limit=1]'
OTHER = TABLE.replace('101', '202')
EVENTS = list(sound.EVENTS) + ['bgm']


def listener(seat=1, table=101):
    return f'@e[tag=cs.listener,scores={{cs_pid={table * 10 + seat}}},limit=1]'


def asset_checks():
    root = sound.RP / '.source/catan/audio'
    manifest = json.loads((root / 'manifest.json').read_text(encoding='utf-8'))
    sounds = json.loads((sound.RP / 'assets/card/sounds.json').read_text(encoding='utf-8'))
    checked = 0
    for name, digest in manifest['retained_files'].items():
        assert sound.sha(root / name) == digest, ('source digest', name)
        checked += 1
    for event in EVENTS:
        record = manifest['audio'][event]
        path = sound.RP / record['output']
        assert sound.sha(path) == record['output_sha256'], ('output digest', event)
        assert sound.sha(root / record['source']) == record['source_sha256'], ('original digest', event)
        detail = sound.probe(path)
        assert detail['streams'][0] == {'codec_name': 'vorbis', 'sample_rate': '44100', 'channels': 1}, detail
        samples = np.frombuffer(subprocess.check_output(['ffmpeg', '-v', 'error', '-i', str(path),
            '-f', 'f32le', '-acodec', 'pcm_f32le', '-']), dtype='<f4')
        assert np.isfinite(samples).all() and np.max(np.abs(samples)) < 1, ('invalid/clipped samples', event)
        assert math.sqrt(float(np.mean(samples * samples))) > 0.0001, ('silent audio', event)
        definition = sounds['catan.' + event]
        assert definition['sounds'][0]['name'] == 'card:catan/' + event
        assert bool(definition['sounds'][0].get('stream')) == (event == 'bgm')
        checked += 7
    assert manifest['loop_ticks'] == math.ceil(float(manifest['audio']['bgm']['format']['format']['duration']) * 20) == 1000
    assert 'CC0' in (root / 'randommind-page.html').read_text(encoding='utf-8')
    assert 'Waiver' in (root / 'CC0-1.0.txt').read_text(encoding='utf-8')
    checked += 3
    # Generation checks run into temporary paths, never rewrite another agent's files.
    import tempfile
    with tempfile.TemporaryDirectory(prefix='fimel-catan-source-check-') as directory:
        target = Path(directory)
        settings.build(target)
        sound.build(target)
        for path in target.rglob('*.mcfunction'):
            actual = base.PACK / 'data/catan/function' / path.relative_to(target)
            assert path.read_bytes() == actual.read_bytes(), ('generator mismatch', actual)
            checked += 1
    print(f'Catan assets/source: {checked} checks passed', flush=True)


class Suite(base.Suite):
    def call(self, name, table=101):
        return [f'execute as {TABLE if table == 101 else OTHER} at @s run function catan:{name}']

    def setup(self, state=1):
        lines = ['function love_letter_test:reset']
        # Same loaded chunk also proves that isolation does not rely on distance.
        for table, x in ((101, 8), (202, 12)):
            lines += [f'execute positioned {x} 64 8 summon minecraft:marker run function love_letter_test:table {{table:{table},state:{state}}}']
            for seat in range(1, 5):
                lines += [f'execute positioned {x} 64 8 summon minecraft:marker run function love_letter_test:listener {{table:{table},seat:{seat},pid:{table * 10 + seat}}}']
        return lines

    def open(self, table=101, seat=1):
        return ['tag @e[tag=ct.settings_actor] remove ct.settings_actor',
            f'tag {listener(seat, table)} add ct.settings_actor'] + self.call('settings/open', table)

    def submit(self, field, value, seat=1, table=101, from_saved=False):
        person = listener(seat, table)
        return [f'scoreboard players operation {person} ca_settings = ' + ('#saved lt' if from_saved else f'{person} ca_setnonce'),
            *([] if from_saved else [f'scoreboard players operation {person} ca_settings *= #tenk lt',
                f'scoreboard players add {person} ca_settings {field * 100 + value}']),
            f'execute as {person} at @s run function catan:settings/save']

    def absent(self, target, objective, name):
        return [f'execute store success score #exists lt run scoreboard players get {target} {objective}'] + self.score('#exists', 'lt', 0, name)

    def heard(self, event, amount, name, table=101, seats=(1, 2, 3, 4)):
        objective = 'cs_h' + str(EVENTS.index(event))
        return sum((self.score(listener(seat, table), objective, amount, name + f'_p{seat}') for seat in seats), [])

    def build(self):
        self.file('reset', ['kill @e[tag=cs.fixture]', 'scoreboard players set #dialog lt 0',
            'scoreboard players set #preview lt 0', 'scoreboard players set #settings_serial ca_ctx 9999',
            'scoreboard players set #settings_load ca_ctx 1', 'scoreboard players set #tenk lt 10000'])
        self.file('table', '''
tag @s add cs.fixture
tag @s add cs.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_state $(state)
scoreboard players set @s ct_game 21
scoreboard players set @s ca_epoch 7
scoreboard players set @s ca_state 4
scoreboard players set @s ca_finish 0
scoreboard players set @s ca_music 1
scoreboard players set @s ca_bgm 0
function catan:settings/defaults
''')
        self.file('listener', '''
tag @s add cs.fixture
tag @s add cs.listener
tag @s add ct.player
tag @s add ca.player
$scoreboard players set @s cs_pid $(pid)
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ca_table $(table)
$scoreboard players set @s ca_seat $(seat)
$scoreboard players set @s ca_side $(seat)
''' + '\n'.join(f'scoreboard players set @s cs_h{i} 0' for i in range(len(EVENTS))) + '\nscoreboard players set @s cs_stop 0')
        for event in sound.EVENTS:
            c = self.setup() + self.call('sound/' + event)
            if event == 'illegal':
                c = self.setup() + [f'tag {listener()} add ca.actor'] + self.call('sound/illegal')
                c += self.heard(event, 1, 'illegal_actor', seats=(1,)) + self.heard(event, 0, 'illegal_not_other', seats=(2, 3, 4))
            else:
                c += self.heard(event, 1, event)
            c += self.heard(event, 0, event + '_other_table', table=202)
            self.case('sound_' + event, c)
        for label, changes in [
            ('not_participant', [f'tag {listener(2)} remove ca.player']),
            ('left_seat', [f'tag {listener(2)} remove ct.player']),
            ('foreign_game_table', [f'scoreboard players set {listener(2)} ca_table 202']),
            ('foreign_common_table', [f'scoreboard players set {listener(2)} ct_id 202']),
        ]:
            c = self.setup() + changes + self.call('sound/road')
            c += self.heard('road', 0, label, seats=(2,)) + self.heard('road', 1, label + '_others', seats=(1, 3, 4))
            self.case('sound_guard_' + label, c)
        c = self.setup() + self.call('sound/start') + self.heard('bgm', 1, 'music_start') + self.heard('bgm', 0, 'music_start_other', table=202)
        c += self.score(TABLE, 'ca_bgm', 1000, 'music_timer') + self.call('sound/tick') * 3 + self.heard('bgm', 1, 'no_tick_replay')
        c += [f'scoreboard players set {TABLE} ca_bgm 1'] + self.call('sound/tick') + self.heard('bgm', 2, 'music_loop')
        c += self.score(listener(), 'cs_stop', 3, 'stop_before_each_start_and_loop')
        self.case('music_loop', c)
        c = self.setup() + self.call('sound/start') + self.call('sound/start', 202) + self.call('sound/toggle')
        c += self.score(TABLE, 'ca_music', 0, 'toggle_off_persisted') + self.score(TABLE, 'ca_bgm', 0, 'toggle_off_timer')
        c += self.absent(listener(), 'ca_bgm_on', 'toggle_off_listener') + self.score(listener(1, 202), 'ca_bgm_on', 1, 'toggle_off_other_table_keeps_playing')
        c += self.call('sound/tick') * 2 + self.heard('bgm', 1, 'off_tick_no_restart')
        c += self.call('sound/toggle') + self.heard('bgm', 2, 'toggle_on_once') + self.score(TABLE, 'ca_music', 1, 'toggle_on_persisted')
        self.case('music_toggle', c)
        c = self.setup() + self.call('sound/start') + self.call('sound/reload') + self.heard('bgm', 2, 'reload_restarts_once')
        c += self.score(listener(), 'cs_stop', 3, 'reload_stops_old_stream') + self.call('sound/load')
        c += self.absent(listener(), 'ca_bgm_on', 'load_clears_online_flags') + self.call('sound/reload') + self.heard('bgm', 3, 'reload_after_load_once')
        self.case('music_reload', c)
        for label, changes in [
            ('left', [f'tag {listener(2)} remove ct.player']),
            ('game_tag_lost', [f'tag {listener(2)} remove ca.player']),
            ('table_changed', [f'scoreboard players set {listener(2)} ct_id 202']),
            ('game_table_changed', [f'scoreboard players set {listener(2)} ca_table 202']),
        ]:
            c = self.setup() + self.call('sound/start') + changes + self.call('sound/tick')
            c += self.absent(listener(2), 'ca_bgm_on', label + '_music_stops') + self.score(listener(2), 'cs_stop', 2, label + '_one_cleanup')
            c += self.score(listener(), 'ca_bgm_on', 1, label + '_others_continue')
            self.case('music_' + label, c)
        c = self.setup() + self.call('sound/start') + [f'scoreboard players reset {listener(2)} ca_bgm_on'] + self.call('sound/tick')
        c += self.heard('bgm', 2, 'missing_listener_restored', seats=(2,)) + self.heard('bgm', 1, 'existing_listener_no_replay', seats=(1, 3, 4))
        self.case('music_missing_listener', c)
        for label, change in [('finished', 'ca_finish 100'), ('engine_finished', 'ca_state 11'), ('lobby', 'ct_state 0'), ('changed_game', 'ct_game 20')]:
            c = self.setup() + self.call('sound/start') + [f'scoreboard players set {TABLE} {change}'] + self.call('sound/tick') * 2
            c += self.heard('bgm', 1, label + '_no_restart') + self.absent(listener(), 'ca_bgm_on', label + '_stopped')
            self.case('music_' + label, c)
        c = self.setup() + self.call('sound/start') + [f'scoreboard players set {TABLE} ca_winner 2'] + self.call('sound/result')
        c += self.heard('win', 1, 'winner_only', seats=(2,)) + self.heard('win', 0, 'others_not_win', seats=(1, 3, 4))
        c += self.heard('lose', 0, 'winner_not_lose', seats=(2,)) + self.heard('lose', 1, 'losers_only', seats=(1, 3, 4))
        c += self.heard('win', 0, 'result_other_table_win', table=202) + self.heard('lose', 0, 'result_other_table_lose', table=202)
        c += self.absent(listener(), 'ca_bgm_on', 'result_stops_music')
        self.case('music_result', c)
        c = self.setup(0) + [f'scoreboard players reset {TABLE} ca_music', f'scoreboard players set {TABLE} ca_layout 99'] + self.call('settings/defaults')
        c += self.score(TABLE, 'ca_music', 1, 'default_music_on') + self.score(TABLE, 'ca_layout', 0, 'default_layout_repaired')
        c += [f'scoreboard players set {TABLE} ca_first 1'] + self.call('settings/defaults') + self.score(TABLE, 'ca_first', 1, 'valid_default_preserved')
        self.case('settings_defaults', c)
        c = self.setup(0) + self.open() + self.score('#dialog', 'lt', 1, 'settings_dialog_compiled')
        c += self.score(listener(), 'ca_setnonce', 10000, 'settings_nonce_bound') + self.score(listener(), 'ca_setepoch', 7, 'settings_epoch_bound')
        c += self.submit(3, 1) + self.score(TABLE, 'ca_first', 1, 'first_instant') + self.score(OTHER, 'ca_first', 0, 'first_other_table_unchanged')
        c += self.score('#preview', 'lt', 0, 'first_no_visual_reinit') + self.score('#dialog', 'lt', 2, 'setting_reopens_same_page')
        c += self.score(listener(), 'ca_setnonce', 10001, 'setting_nonce_consumed_replaced')
        c += self.submit(4, 0) + self.score(TABLE, 'ca_music', 0, 'music_setting_instant') + self.score(TABLE, 'ca_first', 1, 'music_preserves_first')
        c += self.submit(0, 0) + self.absent(listener(), 'ca_setnonce', 'done_clears_session')
        self.case('settings_instant', c)
        for field in (1, 2):
            c = self.setup(0) + self.open() + self.submit(field, 1)
            c += self.score(TABLE, 'ca_' + settings.FIELDS[field - 1][1], 1, f'visual_setting_{field}_applied')
            c += self.score('#preview', 'lt', 1, f'visual_setting_{field}_preview_callback') + self.score(listener(), 'ca_setepoch', 8, f'visual_setting_{field}_new_epoch_bound')
            self.case(f'settings_visual_{field}', c)
        mutations = [
            ('role', [f'tag {listener()} remove ct.player']),
            ('table', [f'scoreboard players set {listener()} ct_id 202']),
            ('active', [f'scoreboard players set {TABLE} ct_state 1']),
            ('game', [f'scoreboard players set {TABLE} ct_game 20']),
            ('epoch', [f'scoreboard players add {TABLE} ca_epoch 1']),
            ('reload', ['scoreboard players add #settings_load ca_ctx 1']),
            ('nonce', [f'scoreboard players add {listener()} ca_setnonce 1']),
        ]
        for label, change in mutations:
            c = self.setup(0) + self.open() + [f'scoreboard players operation #saved lt = {listener()} ca_setnonce',
                'scoreboard players operation #saved lt *= #tenk lt', 'scoreboard players add #saved lt 301'] + change
            c += self.submit(0, 0, from_saved=True) + self.score(TABLE, 'ca_first', 0, label + '_rejects_no_mutation')
            c += self.absent(listener(), 'ca_setnonce', label + '_consumes_invalid_session') + self.score('#dialog', 'lt', 1, label + '_no_reopen')
            self.case('settings_guard_' + label, c)
        for label, suffix in [('unknown_field', 501), ('bad_value', 302), ('bad_close', 1), ('low', -100000000), ('high', 2047483647)]:
            c = self.setup(0) + self.open() + [f'scoreboard players operation #saved lt = {listener()} ca_setnonce',
                'scoreboard players operation #saved lt *= #tenk lt', f'scoreboard players {"remove" if suffix < 0 else "add"} #saved lt {abs(suffix)}']
            c += self.submit(0, 0, from_saved=True) + self.score(TABLE, 'ca_first', 0, label + '_rejected') + self.absent(listener(), 'ca_setnonce', label + '_session_cleared')
            self.case('settings_invalid_' + label, c)
        c = self.setup(0) + self.open() + self.open(202) + self.call('settings/invalidate_table')
        c += self.absent(listener(), 'ca_setnonce', 'invalidate_only_table_a') + self.score(listener(1, 202), 'ca_setnonce', 10001, 'invalidate_keeps_table_b')
        c += self.call('settings/load') + self.absent(listener(1, 202), 'ca_setnonce', 'settings_load_clears_both')
        self.case('settings_clear', c)
        c = self.setup(0) + self.open() + [f'scoreboard players operation #saved lt = {listener()} ca_setnonce',
            'scoreboard players operation #saved lt *= #tenk lt', 'scoreboard players add #saved lt 301'] + self.submit(3, 1)
        c += [f'scoreboard players set {TABLE} ca_first 0'] + self.submit(0, 0, from_saved=True) + self.score(TABLE, 'ca_first', 0, 'replayed_setting_refused')
        self.case('settings_replay', c)
        c = self.setup(0) + self.open() + ['scoreboard players set #settings_serial ca_ctx 99999'] + self.open(202)
        c += self.score('#settings_load', 'ca_ctx', 2, 'serial_wrap_advances_generation') + self.score(listener(1, 202), 'ca_setnonce', 10000, 'serial_wrap_safe_base')
        c += self.submit(3, 1) + self.score(TABLE, 'ca_first', 0, 'wrap_old_window_refused')
        self.case('settings_wrap', c)
        c = self.setup(1) + self.open() + self.score('#dialog', 'lt', 0, 'cannot_open_active_settings')
        c += [f'scoreboard players set {TABLE} ct_state 0'] + self.open(202) + self.call('settings/open') + self.score('#dialog', 'lt', 0, 'cannot_open_foreign_settings')
        self.case('settings_open_guards', c)
        objectives = {'lt': 'dummy', 'ct_id': 'dummy', 'ct_state': 'dummy', 'ct_game': 'dummy',
            'ca_ctx': 'dummy', 'ca_epoch': 'dummy', 'ca_table': 'dummy', 'ca_seat': 'dummy',
            'ca_side': 'dummy', 'ca_state': 'dummy', 'ca_finish': 'dummy', 'ca_winner': 'dummy',
            'cs_pid': 'dummy', 'cs_stop': 'dummy', **settings.OBJECTIVES, **sound.OBJECTIVES,
            **{'cs_h' + str(i): 'dummy' for i in range(len(EVENTS))}}
        self.file('bootstrap', ['forceload add 0 0 47 15'] + [f'scoreboard objectives add {key} {kind}' for key, kind in objectives.items()] + [f'schedule function love_letter_test:case/{self.cases[0]} 2t'])
        self.file('finish', ['function love_letter_test:reset', 'say LOVELETTER_FINISHED'])
        for i, name in enumerate(self.cases):
            self.files['case/' + name] += 'schedule function love_letter_test:' + ('case/' + self.cases[i + 1] if i + 1 < len(self.cases) else 'finish') + ' 1t\n'


def fixtures(selector):
    return selector.replace('@a[', '@e[tag=cs.listener,').replace('@a ', '@e[tag=cs.listener] ')


def prepare_target(target):
    dest = target / 'data/catan/function'
    for directory in ('settings', 'sound', 'rules'):
        shutil.copytree(base.PACK / 'data/catan/function' / directory, dest / directory)
    # This suite checks the settings callback boundary. Complete engine/visual
    # preview behavior is covered by the main Catan lifecycle/visual suites.
    callback = dest / 'game/preview.mcfunction'
    callback.parent.mkdir(parents=True, exist_ok=True)
    callback.write_text('scoreboard players add #preview lt 1\nscoreboard players add @s ca_epoch 1\n', encoding='utf-8')
    for path in dest.rglob('*.mcfunction'):
        lines = []
        for line in path.read_text(encoding='utf-8').splitlines():
            if 'playsound card:catan.' in line:
                event = re.search(r'playsound card:catan\.([a-z_]+)', line).group(1)
                prefix = fixtures(line.split(' run playsound ', 1)[0]) if ' run playsound ' in line else ''
                observe = f'scoreboard players add @s cs_h{EVENTS.index(event)} 1'
                lines.append(prefix + ' run ' + observe if prefix else observe)
                lines.append(line)
            elif line.startswith('stopsound '):
                lines += ['scoreboard players add @s cs_stop 1', line]
            elif 'dialog show ' in line:
                lines += [line, 'scoreboard players add #dialog lt 1']
            elif 'tellraw ' in line or 'dialog clear ' in line:
                lines.append(line)
            else:
                lines.append(fixtures(line))
        path.write_text('\n'.join(lines) + '\n', encoding='utf-8')


if __name__ == '__main__':
    asset_checks()
    if '--assets-only' in sys.argv:
        raise SystemExit(0)
    suite = Suite()
    suite.build()
    original_run = base.subprocess.run
    def run_with_heap(command, *args, **kwargs):
        if len(command) == 2 and str(command[1]).startswith('@'):
            path = Path(str(command[1])[1:])
            path.write_text(path.read_text(encoding='utf-8').replace('-Xmx1536M', '-Xmx3072M'), encoding='utf-8')
        return original_run(command, *args, **kwargs)
    base.subprocess.run = run_with_heap
    print('Catan isolated GameTest: Java heap 3072 MiB; command limit remains vanilla 65536.', flush=True)
    raise SystemExit(base.run(suite, isolated=True, prefix='fimel-catan-sound-', prepare_target=prepare_target))
