"""统一旧游戏设置的真实Dialog、即时参数、权限及旧窗口回归。"""
from pathlib import Path
import json
import re
from test_guandan_cards import run
from test_table_chair_settings import Suite as ChairSuite, TABLE, OTHER, actor, prepare_target as prepare_chairs
from build_legacy_settings import GAMES, PACK


def validate_styles():
    pages = []
    for path in (PACK / 'data').glob('*/function/settings/*.mcfunction'):
        text = path.read_text(encoding='utf-8')
        if 'dialog show' not in text or 'ct_chair_pick set 1' not in text:
            continue
        source = next(line for line in text.splitlines() if 'dialog show' in line)
        encoded = source[source.index(' {') + 1:]
        dialog = json.loads(re.sub(r'\$\([a-z_0-9]+\)', '0', encoded))
        assert dialog['type'] == 'minecraft:notice', path
        assert dialog['title']['text'].endswith(' · 游戏设置'), path
        assert dialog['title']['color'] == 'gold', path
        assert not dialog.get('inputs'), path
        assert dialog['body'][0]['contents']['click_event']['command'] == 'trigger ct_skin_pick set 4', path
        assert dialog['body'][1]['contents']['click_event']['command'] == 'trigger ct_chair_pick set 1', path
        assert all(row['width'] == 440 for row in dialog['body']), path
        assert dialog['pause'] is False, path
        pages.append(path)
    from build_table_chair_settings import MINIMUM
    assert len(pages) == len(MINIMUM), [str(path) for path in pages]
    return pages


class Suite(ChairSuite):
    def opening(self, table=101):
        return [f'tag {actor(table)} add ct.settings_actor',
                f'execute as {TABLE if table == 101 else OTHER} at @s run function cardtable:game/open_settings',
                f'tag {actor(table)} remove ct.settings_actor']

    def setting(self, field, value, table=101, replay=False):
        commands = [] if replay else [f'scoreboard players operation #setting_encoded gt = {actor(table)} ct_st_nonce',
                                      'scoreboard players set #setting_factor gt 100000',
                                      'scoreboard players operation #setting_encoded gt *= #setting_factor gt',
                                      f'scoreboard players add #setting_encoded gt {field*1000+value}']
        return commands + [f'scoreboard players operation {actor(table)} ct_setting = #setting_encoded gt',
                           f'execute as {actor(table)} at @s run function cardtable:settings/handle']

    def build(self):
        self.file('reset', ['kill @e[tag=gt.fixture]', 'kill @e[tag=ct.seat]', 'kill @e[tag=ct.skin]',
                            'scoreboard players set #settings_compiled gt 0'])
        for cap in (4, 8):
            for game, (namespace, _, _, fields) in GAMES.items():
                if game == 16 and cap == 4:
                    continue
                c = self.fixture(cap=cap, game=game) + self.opening()
                c += self.score('#settings_compiled', 'gt', 1, f'entry_{game}_{cap}_dialog_compiles')
                c += self.score(actor(), 'ct_st_table', 101, f'entry_{game}_{cap}_table')
                c += self.check(f'score {actor()} ct_st_nonce matches 1..9999', f'entry_{game}_{cap}_nonce')
                for index, field in enumerate(fields, 1):
                    c += self.score(TABLE, field['key'], field['default'], f'entry_{game}_{cap}_default_{index}')
                self.case(f'entry_{game}_{cap}', c)
        for game, (namespace, _, _, fields) in GAMES.items():
            for index, field in enumerate(fields, 1):
                values = [v for v, _ in field['choices']] if 'choices' in field else [field['low'], field['high']]
                for value in values:
                    c = self.fixture(game=game)
                    if field['key'] == 'dd_hide_score':
                        c = self.fixture(game=game, cap=8) + [f'scoreboard players set {TABLE} dd_mode 2']
                    c += self.opening() + self.setting(index, value)
                    c += self.score(TABLE, field['key'], value, f'instant_{game}_{index}_{value}_changes')
                    c += self.score('#settings_compiled', 'gt', 2, f'instant_{game}_{index}_{value}_same_page_reopens')
                    self.case(f'instant_{game}_{index}_{value}', c)
                c = self.fixture(game=game) + self.opening() + self.setting(index, field['high'] + 1)
                c += self.score(TABLE, field['key'], field['default'], f'invalid_{game}_{index}_range_rejected')
                self.case(f'invalid_{game}_{index}', c)
        for mode in (1, 2):
            c = self.fixture(game=10, cap=8) + [f'scoreboard players set {TABLE} dd_mode {mode}',
                                              f'scoreboard players set {TABLE} dd_classic_bid 2'] + self.opening()
            c += self.check('data storage cardtable:settings field3.extra[{text:" [叫分制] ",color:"gold"}]', f'team_{mode}_shows_fixed_bid')
            c += self.check('data storage cardtable:settings field3.extra[{text:" [叫抢制] [手速制] ",color:"dark_gray"}]', f'team_{mode}_shows_disabled_bid_options')
            c += self.setting(3, 1) + self.score(TABLE, 'dd_classic_bid', 2, f'team_{mode}_rejects_bid_change')
            self.case(f'doudizhu_team_bid_{mode}', c)
        for mode in (0, 1, 2):
            c = self.fixture(game=10, cap=8) + [f'scoreboard players set {TABLE} dd_mode {mode}',
                                              f'scoreboard players set {TABLE} dd_scoring 1'] + self.opening()
            if mode == 2:
                c += self.check('data storage cardtable:settings field8.extra[{text:" [隐藏比分] "}]', 'duplicate_wins_can_hide_scores')
            else:
                c += self.check('data storage cardtable:settings field8.extra[{text:" 仅4v4可设置",color:"dark_gray"}]', f'mode_{mode}_shows_unavailable_prediction')
                c += self.setting(8, 1) + self.score(TABLE, 'dd_hide_score', 0, f'mode_{mode}_rejects_prediction_setting')
            self.case(f'doudizhu_prediction_setting_{mode}', c)
        changes = {
            'start': [f'scoreboard players set {TABLE} ct_state 1'],
            'game': [f'scoreboard players set {TABLE} ct_game 3'],
            'seat': [f'scoreboard players set {actor()} ct_seat 2'],
            'table': [f'scoreboard players set {actor()} ct_id 202'],
            'reload': ['function cardtable:settings/load'],
            'layout': [f'scoreboard players add {TABLE} ct_ch_epoch 1'],
            'leave': [f'tag {actor()} remove ct.player'],
        }
        stable = '@e[type=minecraft:marker,tag=cs.person,limit=1]'
        input_field = next(index for index, field in enumerate(GAMES[19][3], 1) if field['key'] == 'it_input')
        for name, mutation in changes.items():
            c = self.fixture(game=19) + self.opening()
            c += [f'scoreboard players operation #setting_encoded gt = {actor()} ct_st_nonce',
                  'scoreboard players set #setting_factor gt 100000',
                  'scoreboard players operation #setting_encoded gt *= #setting_factor gt',
                  f'scoreboard players add #setting_encoded gt {input_field*1000+1}'] + mutation
            c += [f'scoreboard players operation {stable} ct_setting = #setting_encoded gt',
                  f'execute as {stable} at @s run function cardtable:settings/handle']
            c += self.score(TABLE, 'it_input', 0, f'ito_stale_{name}_preserved')
            self.case('stale_' + name, c)
        c = self.fixture(game=19) + self.fixture(game=19, table=202, reset=False) + self.opening() + self.opening(202)
        c += self.setting(input_field, 1) + self.score(TABLE, 'it_input', 1, 'two_tables_own_changes')
        c += self.score(OTHER, 'it_input', 0, 'two_tables_other_preserved')
        c += [f'scoreboard players set {TABLE} it_input 0'] + self.setting(input_field, 1, replay=True)
        c += self.score(TABLE, 'it_input', 0, 'replay_rejected')
        self.case('isolation_replay', c)
        c = self.fixture(game=19) + self.opening()
        c += [f'scoreboard players set {actor()} it_settings 12', f'execute as {actor()} run function ito:settings/save']
        c += self.score(TABLE, 'it_input', 0, 'old_ito_save_disabled')
        self.case('old_save', c)
        self.file('bootstrap', ['forceload add 0 0 47 15', 'scoreboard objectives add gt dummy',
                                'function cardtable:settings/load', 'function cardtable:chairs/settings/load',
                                f'schedule function guandan_test:case/{self.cases[0]} 2t'])
        self.file('finish', ['function guandan_test:reset', 'say GUANDAN_FINISHED'])
        for index, name in enumerate(self.cases):
            self.files['case/' + name] += 'schedule function guandan_test:' + (
                'case/' + self.cases[index + 1] if index + 1 < len(self.cases) else 'finish') + ' 1t\n'


def prepare(target):
    prepare_chairs(target)
    folder = target / 'data/cardtable/function/settings'
    for path in list(folder.glob('*.mcfunction')) + [target / 'data/cardtable/function/game/open_settings.mcfunction']:
        text = path.read_text(encoding='utf-8')
        lines = [line if 'dialog show' in line or 'tellraw' in line else line.replace('@a[', '@e[type=minecraft:marker,tag=cs.person,') for line in text.splitlines()]
        if path.stem.startswith('show_'):
            lines.append('scoreboard players add #settings_compiled gt 1')
        path.write_bytes(('\n'.join(lines) + '\n').encode('utf-8'))


if __name__ == '__main__':
    validate_styles()
    suite = Suite()
    suite.build()
    raise SystemExit(run(suite, isolated=False, prefix='fimel-unified-settings-', prepare_target=prepare))
