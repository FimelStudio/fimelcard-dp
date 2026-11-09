# -*- coding: utf-8 -*-
"""26.2隔离GameTest：真实比赛Dialog、设置、公共会话与多桌生命周期。

仅在临时副本用marker桥接玩家选择器；不修改规则命令或Dialog宏。
客户端画面、真实按Q和音效收听仍需联机验收。
"""
import json
import re
from pathlib import Path

from test_catan_engine import Suite as BaseSuite, run

PACK = Path(__file__).resolve().parents[1]
TABLE = '@e[type=minecraft:marker,tag=mg.table,scores={ct_id=101},limit=1]'
OTHER = TABLE.replace('101', '202')


def person(side=1, table=101):
    return f'@e[type=minecraft:marker,tag=mg.person,scores={{mg_pid={table*10+side}}},limit=1]'


def identity(side=1, table=101):
    return person(side, table).replace('tag=mg.person', 'tag=mg.identity')


class Suite(BaseSuite):
    def call(self, name, table=101):
        return [f'execute as {TABLE if table == 101 else OTHER} at @s run function magical_athlete:{name}']

    def player(self, name, side=1, table=101):
        return [f'execute as {person(side, table)} at @s run function magical_athlete:{name}']

    def set(self, path, value, table=101):
        return [f'data modify entity {TABLE if table == 101 else OTHER} data.magical_athlete.{path} set value ' + json.dumps(value, ensure_ascii=False, separators=(',', ':'))]

    def equal(self, source, expected, label):
        return ['data modify storage magical_athlete_test:compare value set value ' + json.dumps(expected, ensure_ascii=False, separators=(',', ':')),
                f'execute store success score #present ce run data get {source}',
                f'execute store success score #different ce run data modify storage magical_athlete_test:compare value set from {source}',
                'execute unless score #present ce matches 1 run scoreboard players set #different ce 1'] + self.score('#different', 'ce', 0, label)

    def data(self, path, expected, label, table=101):
        return self.equal(f'entity {TABLE if table == 101 else OTHER} data.magical_athlete.{path}', expected, label)

    def setup(self, state=1, n=2, table=101, reset=True):
        out = ['kill @e[tag=mg.fixture]', 'kill @e[tag=ma.visual]', 'scoreboard players set #dialog ce 0', 'scoreboard players set #setting_dialog ce 0'] if reset else []
        out += [f'execute positioned {8 if table == 101 else 40} 64 8 summon minecraft:marker run function catan_engine_test:table {{table:{table},state:{state},n:{n}}}']
        seats = [1, 8, 3, 6, 4, 5]
        for side in range(1, n + 1):
            out += [f'execute positioned {8 if table == 101 else 40} 64 8 summon minecraft:marker run function catan_engine_test:person {{table:{table},side:{side},seat:{seats[side-1]},pid:{table*10+side}}}']
        out += [f'scoreboard players set #players ma_ctx {n}'] + self.call('engine/init', table) + self.call('game/sync', table)
        for side in range(1, n + 1):
            out += self.set(f'p{side}.name', {'text': f'Player{side}'}, table) + self.set(f'p{side}.seat', seats[side-1], table)
        return out + self.call('system/context', table)

    def click(self, code, side=1, table=101):
        who = person(side, table)
        return [f'scoreboard players operation {who} ma_action = {who} ma_nonce', f'scoreboard players operation {who} ma_action *= #factor ma_ctx', f'scoreboard players add {who} ma_action {code}'] + self.player('ui/handle', side, table)

    def open_settings(self, table=101):
        return [f'tag {person(1, table)} add ct.settings_actor'] + self.call('settings/open', table) + [f'tag {person(1, table)} remove ct.settings_actor']

    def setting(self, field, value, side=1, table=101):
        who = person(side, table)
        return [f'scoreboard players operation {who} ma_settings = {who} ma_setnonce', f'scoreboard players operation {who} ma_settings *= #factor ma_ctx', f'scoreboard players add {who} ma_settings {field*100+value}'] + self.player('settings/save', side, table)

    def snapshot(self, table=101):
        return [f'data modify storage magical_athlete_test:snapshot saved set from entity {TABLE if table == 101 else OTHER} data.magical_athlete']

    def unchanged(self, label, table=101):
        return [f'execute store success score #different ce run data modify storage magical_athlete_test:snapshot saved set from entity {TABLE if table == 101 else OTHER} data.magical_athlete'] + self.score('#different', 'ce', 0, label)

    def build(self):
        self.file('table', '''
tag @s add mg.fixture
tag @s add mg.table
tag @s add ct.controller
tag @s add ma.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_state $(state)
$scoreboard players set @s ct_joined $(n)
scoreboard players set @s ct_game 23
scoreboard players set @s ct_capacity 8
scoreboard players set @s ct_chairs 8
scoreboard players set @s ct_ch_epoch 1
scoreboard players set @s ct_paused 0
scoreboard players set @s ma_anim 0
scoreboard players set @s ma_finish 0
scoreboard players set @s ma_music 0
scoreboard players set @s ma_music_tick 0
scoreboard players set @s ma_pulse 0
scoreboard players set @s ma_draft 1
scoreboard players set @s ma_track 0
scoreboard players set @s ma_orient 0
scoreboard players set @s ma_speed 1
''')
        self.file('person', '''
tag @s add mg.fixture
tag @s add mg.person
tag @s add mg.identity
tag @s add ct.player
tag @s add ma.player
$scoreboard players set @s mg_pid $(pid)
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_seat $(seat)
$scoreboard players set @s ma_table $(table)
$scoreboard players set @s ma_side $(side)
$scoreboard players set @s ma_seat $(seat)
scoreboard players set @s ct_paused 0
data modify entity @s data.name set value {text:"Fixture"}
''')
        c = self.setup() + self.set('p1.hand', [21, 3, 4, 6, 18, 19, 22, 26]) + self.set('p2.hand', [0, 1, 2, 5, 7, 8, 9, 10]) + self.player('ui/open')
        c += self.score('#dialog', 'ce', 1, 'lineup_dialog_macro_compiles')
        c += self.equal('storage magical_athlete:ui hand.hand', [21, 3, 4, 6, 18, 19, 22, 26], 'own_lineup_only')
        c += self.click(221) + self.data('p1.selected', [21], 'first_secret_selection')
        c += self.data('p2.selected', [], 'other_secret_selection_not_changed')
        c += self.player('ui/open') + self.click(6) + self.check('data storage magical_athlete:ui hand{selected:[21]}', 'my_team_keeps_own_secret_selection')
        c += self.player('ui/open', 2) + self.equal('storage magical_athlete:ui hand.hand', [0, 1, 2, 5, 7, 8, 9, 10], 'other_sees_own_lineup')
        c += self.click(7, 2) + self.check('data storage magical_athlete:ui detail.extra[0]', 'public_scoreboard_exists')
        self.case('lineup_privacy', c)

        c = self.setup() + self.set('phase', 1) + self.set('turn', 1) + self.set('pool', list(range(12))) + self.call('game/sync') + self.player('ui/open')
        c += self.score('#dialog', 'ce', 1, 'draft_all_twelve_characters_compile')
        c += self.player('ui/open', 2) + self.score('#dialog', 'ce', 2, 'waiting_draft_dialog_compiles')
        self.case('draft_codec', c)

        for kind, options in {'alchemist': [0, 1], 'rocket': [0, 1], 'genius': list(range(7)), 'hypnotist': [-1, 0, 1], 'egg': [0, 21, 35], 'thirdwheel': [-1, 0, 13, 29], 'copycat': [0, 1], 'suckerfish': [0, 1]}.items():
            c = self.setup() + self.set('phase', 3) + self.set('pending', {'kind': kind, 'owner': 1, 'pawn': 0, 'options': options})
            for i in range(2):
                c += self.set(f'racers[{i}]', {'owner': i + 1, 'char': i, 'power': i, 'copy': -1, 'pos': 5, 'trip': 0, 'status': 0, 'first': 1, 'prediction': -1, 'done': 0})
            c += self.call('game/sync') + self.player('ui/open') + self.score('#dialog', 'ce', 1, kind + '_dialog_macro_compiles')
            self.case('skill_' + kind, c)

        c = self.setup() + self.set('phase', 3) + self.set('racers[0]', {'owner': 1, 'char': 10, 'power': 21, 'copy': -1, 'pos': 5, 'trip': 0, 'status': 0, 'first': 1, 'prediction': -1, 'done': 0})
        c += self.call('game/sync') + self.player('ui/open') + self.click(7)
        c += self.score('#dialog', 'ce', 2, 'public_inherited_power_dialog_compiles') + self.check('data storage magical_athlete:ui power{id:21}', 'public_inherited_power_matches_racer')
        self.case('public_inherited_power', c)

        for label, changes in {
            'epoch': [f'scoreboard players add {TABLE} ma_epoch 1'],
            'load': ['scoreboard players add #ui_load ma_ctx 1'],
            'table': [f'scoreboard players set {person()} ma_ui_table 202'],
            'seat': [f'scoreboard players add {person()} ct_seat 1'],
            'role': [f'tag {person()} remove ct.player'],
            'paused': [f'scoreboard players set {TABLE} ct_paused 1'],
        }.items():
            c = self.setup() + self.set('p1.hand', [21]) + self.player('ui/open') + self.snapshot() + changes + self.click(221) + self.unchanged('stale_' + label + '_no_commit')
            self.case('stale_' + label, c)

        c = self.setup(state=0) + self.open_settings() + self.score('#setting_dialog', 'ce', 1, 'settings_dialog_compiles')
        for field, value, key in ((1, 0, 'draft'), (2, 2, 'track'), (3, 1, 'music'), (4, 0, 'speed'), (5, 1, 'orient')):
            c += self.setting(field, value) + self.score(TABLE, 'ma_' + key, value, 'setting_' + key + '_immediate')
        c += self.score('#setting_dialog', 'ce', 6, 'settings_same_page_refreshed')
        self.case('settings_immediate', c)

        for label, changes in {
            'seat': [f'scoreboard players add {person()} ct_seat 1'],
            'table': [f'scoreboard players set {person()} ct_id 202'],
            'layout': [f'scoreboard players add {TABLE} ct_ch_epoch 1'],
            'epoch': [f'scoreboard players add {TABLE} ma_epoch 1'],
            'load': ['scoreboard players add #settings_load ma_ctx 1'],
            'game': [f'scoreboard players set {TABLE} ct_game 1'],
            'active': [f'scoreboard players set {TABLE} ct_state 1'],
            'leave': [f'tag {person()} remove ct.player'],
        }.items():
            c = self.setup(state=0) + self.open_settings() + changes + self.setting(1, 0) + self.score(TABLE, 'ma_draft', 1, 'settings_stale_' + label)
            self.case('settings_stale_' + label, c)

        c = self.setup(state=0) + self.setup(state=0, table=202, reset=False) + self.open_settings() + self.setting(1, 0)
        c += self.score(TABLE, 'ma_draft', 0, 'settings_own_table') + self.score(OTHER, 'ma_draft', 1, 'settings_other_table_unchanged')
        c += self.call('game/remove') + self.check('entity @e[tag=mg.table,tag=ma.controller,scores={ct_id=202}]', 'remove_other_controller_preserved')
        self.case('table_isolation', c)

        c = self.setup() + self.set('epoch', 9) + self.set('p1.points', 7) + self.call('game/sync') + self.snapshot() + self.call('system/reload') + self.unchanged('reload_preserves_rules')
        c += self.data('p1.points', 7, 'reload_preserves_points') + self.score(TABLE, 'ma_epoch', 9, 'reload_preserves_epoch')
        self.case('reload_preserve', c)

        c = self.setup(state=0) + [f'execute as {TABLE} at @s run function cardtable:game/start']
        c += self.score(TABLE, 'ct_start', 1, 'common_start_handshake') + self.score(TABLE, 'ct_state', 1, 'common_start_active') + self.score(TABLE, 'ct_expected', 2, 'common_session_members')
        c += self.data('p1.seat', 1, 'sparse_first_actual_seat') + self.data('p2.seat', 8, 'sparse_high_actual_seat')
        c += [f'tag {person(2)} remove mg.person', f'execute as {TABLE} at @s run function cardtable:session/check_table'] + self.score(TABLE, 'ct_paused', 1, 'offline_pauses')
        c += self.snapshot() + self.call('game/tick') + self.unchanged('paused_tick_no_mutation')
        c += [f'tag {identity(2)} add mg.person', f'execute as {TABLE} at @s run function cardtable:session/check_table'] + self.score(TABLE, 'ct_paused', 0, 'rejoin_resumes')
        c += [f'tag {person(2)} remove mg.person'] + self.call('game/cleanup') + self.score(TABLE, 'ct_state', 0, 'cleanup_returns_lobby')
        c += [f'tag {identity(2)} add mg.person', f'execute as {person(2)} at @s run function cardtable:session/reconcile_player']
        c += self.check('entity @e[tag=mg.identity,tag=!ma.player,scores={mg_pid=1012}]', 'late_old_player_cleared')
        self.case('session_lifecycle', c)

        for capacity, n in ((4, 3), (4, 4), (8, 6)):
            c = self.setup(state=0, n=n) + [f'scoreboard players set {TABLE} ct_capacity {capacity}']
            for side in range(1, n + 1):
                seat = [1, 3, 4][side-1] if capacity == 4 and n == 3 else side
                c += [f'scoreboard players set {person(side)} ct_seat {seat}']
            c += [f'execute as {TABLE} at @s run function cardtable:game/start']
            c += self.score(TABLE, 'ct_start', 1, f'start_{capacity}_{n}_handshake') + self.score(TABLE, 'ct_expected', n, f'start_{capacity}_{n}_members')
            for side in range(1, n + 1):
                c += self.player('ui/open', side) + self.score(person(side), 'ma_side', side, f'start_{capacity}_{n}_side_{side}')
            # 公共层在game/start返回后才置ct_state=1；此处逐人打开才有有效窗口。
            c += self.score('#dialog', 'ce', n, f'start_{capacity}_{n}_all_lineup_dialogs')
            c += self.call('game/cleanup') + self.score(TABLE, 'ct_state', 0, f'start_{capacity}_{n}_cleanup')
            self.case(f'capacity_{capacity}_{n}', c)

        c = self.setup() + [f'scoreboard players set {TABLE} ma_music 1'] + self.call('sound/start')
        c += self.score(TABLE, 'ma_music_tick', 640, 'music_full_loop_duration')
        c += self.call('sound/pause') + self.score(TABLE, 'ma_music_tick', 0, 'music_stream_stops_on_pause')
        c += self.call('sound/resume') + self.score(TABLE, 'ma_music_tick', 640, 'music_restarts_on_resume')
        self.case('music_pause_resume', c)

        table_fixture = self.files['table']
        self.finish()
        self.files['table'] = table_fixture
        self.files['bootstrap'] = '\n'.join(['forceload add 0 0 63 31', 'scoreboard objectives add ce dummy', 'scoreboard objectives add mg_pid dummy', 'scoreboard objectives add ct_ctx dummy', 'function cardtable:system/install', 'scoreboard objectives add ct_chairs dummy', 'scoreboard objectives add ct_ch_epoch dummy', 'function cardtable:session/load', 'function magical_athlete:load', f'schedule function catan_engine_test:case/{next(iter(self.cases))} 5t']) + '\n'
        self.files['finish'] = 'kill @e[tag=mg.fixture]\nkill @e[tag=ma.visual]\nsay CATAN_FINISHED\n'
        return self


def fixture_line(line):
    if any(part in line for part in ('dialog show ', 'dialog clear ', 'tellraw ', 'playsound ', 'stopsound ', 'particle ', 'run title ', 'title @')):
        return line
    return re.sub(r'@a\[', '@e[type=minecraft:marker,tag=mg.person,', line).replace('@a ', '@e[type=minecraft:marker,tag=mg.person] ')


def prepare(target):
    roots = [target / 'data/magical_athlete/function', target / 'data/cardtable/function/session']
    extra = [target / ('data/cardtable/function/' + name + '.mcfunction') for name in ('game/start', 'game/remove_offline_player', 'game/return_lobby', 'seat/remove_player')]
    for path in [p for root in roots for p in root.rglob('*.mcfunction')] + extra:
        if not path.exists():
            continue
        lines = []
        for line in path.read_text(encoding='utf-8').splitlines():
            lines.append(fixture_line(line))
            if 'dialog show ' in line:
                lines.append('scoreboard players add #' + ('setting_dialog' if '/settings/' in path.as_posix() else 'dialog') + ' ce 1')
        path.write_text('\n'.join(lines) + '\n', encoding='utf-8')
    (target / 'data/magical_athlete/function/name/capture.mcfunction').write_text('data modify storage magical_athlete:runtime name.value set from entity @s data.name\n', encoding='utf-8')
    (target / 'data/minecraft/tags/function/load.json').write_text(json.dumps({'values': ['magical_athlete:load']}), encoding='utf-8')


if __name__ == '__main__':
    raise SystemExit(run(Suite().build(), full=True, prepare_target=prepare, prefix='fimel-magical-athlete-game-', setup_ticks=3500))
