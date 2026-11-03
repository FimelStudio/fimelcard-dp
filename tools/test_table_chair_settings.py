"""公共椅子设置原版26.2测试：两桌、人数下限、已占座与过期窗口。

仅临时测试包将参与者选择器适配成 marker；Dialog 保留真实玩家接收者和宏编译哨兵。
"""
from pathlib import Path
import re
from test_guandan_cards import Suite as BaseSuite, run
from build_table_chair_settings import MINIMUM, PACK

TABLE = '@e[type=minecraft:marker,tag=gt.table,scores={ct_id=101},limit=1]'
OTHER = '@e[type=minecraft:marker,tag=gt.table,scores={ct_id=202},limit=1]'


def actor(table=101, seat=1):
    return f'@e[type=minecraft:marker,tag=cs.person,scores={{ct_id={table},ct_seat={seat}}},limit=1]'


class Suite(BaseSuite):
    def fixture(self, cap=8, game=2, table=101, reset=True, seats=(1,)):
        target = TABLE if table == 101 else OTHER
        result = ['function guandan_test:reset'] if reset else []
        result += [f'summon minecraft:marker {8 if table == 101 else 40} 64 8 {{Tags:["gt.fixture","gt.table","ct.controller"]}}',
                   f'scoreboard players set @e[tag=gt.table,sort=nearest,limit=1,x={8 if table == 101 else 40},y=64,z=8] ct_id {table}',
                   f'scoreboard players set {target} ct_game {game}',
                   f'scoreboard players set {target} ct_state 0',
                   f'scoreboard players set {target} ct_capacity {cap}',
                   f'scoreboard players set {target} ct_skin 0',
                   f'scoreboard players set {target} ct_ch_epoch 1',
                   'scoreboard players set #chair_compiled gt 0']
        for seat in seats:
            result += [f'summon minecraft:marker {8 if table == 101 else 40} 65 8 {{Tags:["gt.fixture","cs.person","ct.player","cs.new"]}}',
                       f'scoreboard players set @e[tag=cs.new,limit=1] ct_id {table}',
                       f'scoreboard players set @e[tag=cs.new,limit=1] ct_seat {seat}',
                       'tag @e[tag=cs.new] remove cs.new']
        return result

    def call(self, name, table=101):
        return [f'execute as {TABLE if table == 101 else OTHER} at @s run function cardtable:chairs/settings/{name}']

    def open(self, table=101, seat=1):
        return [f'scoreboard players set {actor(table,seat)} ct_chair_pick 1',
                f'execute as {actor(table,seat)} at @s run function cardtable:chairs/settings/handle']

    def choose(self, count, table=101, seat=1, replay=False):
        result = [] if replay else [f'scoreboard players operation #submitted gt = {actor(table,seat)} ct_ch_nonce',
                                    'scoreboard players set #factor gt 10',
                                    'scoreboard players operation #submitted gt *= #factor gt',
                                    f'scoreboard players add #submitted gt {count}']
        return result + [f'scoreboard players operation {actor(table,seat)} ct_chair_pick = #submitted gt',
                         f'execute as {actor(table,seat)} at @s run function cardtable:chairs/settings/handle']

    def build(self):
        self.file('reset', ['kill @e[tag=gt.fixture]', 'kill @e[tag=ct.seat]', 'kill @e[tag=ct.skin]'])
        for cap in (4, 8):
            for game, minimum in MINIMUM.items():
                if minimum > cap:
                    continue
                c = self.fixture(cap, game) + self.open()
                c += self.score('#chair_compiled', 'gt', 1, f'game_{game}_{cap}_actual_dialog_compiles')
                c += self.score(TABLE, 'ct_chairs', cap, f'game_{game}_{cap}_default_full')
                c += self.score('#chair_min', 'ct_ctx', minimum, f'game_{game}_{cap}_minimum')
                c += self.check(f'score {actor()} ct_ch_nonce matches 1..', f'game_{game}_{cap}_nonce')
                c += self.choose(minimum) + self.score(TABLE, 'ct_chairs', minimum, f'game_{game}_{cap}_choose_minimum')
                if minimum > 1:
                    c += self.choose(minimum - 1) + self.score(TABLE, 'ct_chairs', minimum, f'game_{game}_{cap}_reject_below_minimum')
                self.case(f'game_{game}_{cap}', c)
        c = self.fixture(game=12, seats=(1, 8)) + self.open() + self.choose(1)
        c += self.score(TABLE, 'ct_chairs', 8, 'occupied_rejects_one')
        c += self.choose(2) + self.score(TABLE, 'ct_c1', 1, 'occupied_preserves_first')
        c += self.score(TABLE, 'ct_c8', 1, 'occupied_preserves_sparse_last')
        c += self.score(TABLE, 'ct_chairs', 2, 'occupied_accepts_two')
        self.case('occupied', c)
        c = self.fixture(game=15) + [f'scoreboard players set {TABLE} ac_fill 2'] + self.open()
        c += self.score('#chair_min', 'ct_ctx', 2, 'aeroplane_no_ai_minimum_two')
        c += self.choose(1) + self.score(TABLE, 'ct_chairs', 8, 'aeroplane_no_ai_reject_one')
        self.case('aeroplane_no_ai', c)
        c = self.fixture(game=12) + self.fixture(game=12, table=202, reset=False) + self.open() + self.open(202)
        c += self.choose(2) + self.score(TABLE, 'ct_chairs', 2, 'first_table_changed')
        c += self.score(OTHER, 'ct_chairs', 8, 'other_table_preserved')
        c += self.choose(3, table=202) + self.score(OTHER, 'ct_chairs', 3, 'second_table_changed')
        c += self.score(TABLE, 'ct_chairs', 2, 'second_keeps_first')
        self.case('two_tables', c)
        mutations = {
            'state': [f'scoreboard players set {TABLE} ct_state 1'],
            'game': [f'scoreboard players set {TABLE} ct_game 13'],
            'game_roundtrip': ['scoreboard players set #pick_choice ct_ctx 2',
                               f'execute as {TABLE} at @s run function cardtable:menu/select_game',
                               'scoreboard players set #pick_choice ct_ctx 12',
                               f'execute as {TABLE} at @s run function cardtable:menu/select_game'],
            'seat': [f'scoreboard players set {actor()} ct_seat 2'],
            'table': [f'scoreboard players set {actor()} ct_id 202'],
            'epoch': [f'scoreboard players add {TABLE} ct_ch_epoch 1'],
            'reload': ['function cardtable:chairs/settings/load'],
            'leave': [f'tag {actor()} remove ct.player'],
        }
        for kind, mutation in mutations.items():
            c = self.fixture(game=12) + self.open()
            c += [f'scoreboard players operation #submitted gt = {actor()} ct_ch_nonce',
                  'scoreboard players set #factor gt 10', 'scoreboard players operation #submitted gt *= #factor gt',
                  'scoreboard players add #submitted gt 2'] + mutation
            # A stable marker selector permits delivering a stale submission even after table/seat changes.
            stable = '@e[type=minecraft:marker,tag=cs.person,limit=1]'
            c += [f'scoreboard players operation {stable} ct_chair_pick = #submitted gt',
                  f'execute as {stable} at @s run function cardtable:chairs/settings/handle']
            c += self.score(TABLE, 'ct_chairs', 8, f'stale_{kind}_no_change')
            self.case('stale_' + kind, c)
        c = self.fixture(game=12) + self.open() + self.choose(2)
        c += [f'scoreboard players set {TABLE} ct_chairs 3'] + self.choose(2, replay=True)
        c += self.score(TABLE, 'ct_chairs', 3, 'replay_cannot_repeat_mutation')
        self.case('replay', c)
        c = self.fixture(game=12) + self.open()
        c += [f'scoreboard players set {TABLE} ct_game 1'] + self.call('minimum')
        c += [f'execute as {TABLE} at @s run function cardtable:chairs/layout/ensure']
        c += self.score(TABLE, 'ct_chairs', 8, 'switch_retains_above_minimum')
        c += [f'scoreboard players set {TABLE} ct_chairs 1', f'execute as {TABLE} at @s run function cardtable:chairs/layout/ensure']
        c += self.score(TABLE, 'ct_chairs', 4, 'switch_grows_to_new_game_minimum')
        self.case('minimum_switch', c)
        self.file('bootstrap', ['forceload add 0 0 47 15', 'scoreboard objectives add gt dummy',
                                'function cardtable:chairs/settings/load',
                                f'schedule function guandan_test:case/{self.cases[0]} 2t'])
        self.file('finish', ['function guandan_test:reset', 'say GUANDAN_FINISHED'])
        for index, name in enumerate(self.cases):
            self.files['case/' + name] += 'schedule function guandan_test:' + (
                'case/' + self.cases[index + 1] if index + 1 < len(self.cases) else 'finish') + ' 1t\n'


def prepare_target(target):
    root = target / 'data/cardtable/function'
    for folder in ('chairs/settings', 'chairs/layout'):
        for path in (root / folder).glob('*.mcfunction'):
            text = path.read_text(encoding='utf-8')
            lines = []
            for line in text.splitlines():
                if 'dialog show' not in line and 'tellraw' not in line:
                    line = line.replace('@a[', '@e[type=minecraft:marker,tag=cs.person,')
                lines.append(line)
            if path.name == 'show.mcfunction':
                lines.append('scoreboard players add #chair_compiled gt 1')
            path.write_text('\n'.join(lines) + '\n', encoding='utf-8')


if __name__ == '__main__':
    from table_chair_settings import augment_dialog
    pages = [p for p in (PACK / 'data').glob('*/function/settings/*.mcfunction')
             if 'ct_chair_pick set 1' in p.read_text(encoding='utf-8')]
    assert len(pages) == len(MINIMUM), f'Expected all {len(MINIMUM)} games, found {len(pages)}'
    for path in pages:
        text = path.read_text(encoding='utf-8')
        assert text.index('ct_skin_pick') < text.index('ct_chair_pick'), path
        assert augment_dialog(text).rstrip() == text.rstrip(), path
    suite = Suite()
    suite.build()
    raise SystemExit(run(suite, isolated=False, prefix='fimel-table-chair-settings-', prepare_target=prepare_target))
