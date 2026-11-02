"""隔离原版26.2：璀璨宝石公开展示、实际座椅动画、保密与声音生命周期。"""
from __future__ import annotations

import json
import re

from boardgame_assets import PACK, RP
from build_splendor_assets import check
from test_catan_engine import Suite as Base, run, TABLE, OTHER


class Suite(Base):
    def call(self, name, table=101):
        return [f'execute as {TABLE if table == 101 else OTHER} at @s run function splendor:{name}']

    def set(self, path, value, table=101):
        return [f'data modify entity {TABLE if table == 101 else OTHER} data.splendor.{path} set value '+json.dumps(value, separators=(',', ':'))]

    def setup(self, cap=4, n=4, table=101, reset=True):
        who = TABLE if table == 101 else OTHER
        out = ['kill @e[tag=sp.visual]', 'kill @e[tag=ce.fixture]'] if reset else []
        out += [f'execute positioned {8 if table == 101 else 40} 64 8 summon minecraft:marker run function catan_engine_test:table {{table:{table}}}',
                f'scoreboard players set {who} ct_id {table}', f'scoreboard players set {who} ct_game 22',
                f'scoreboard players set {who} ct_state 1', f'scoreboard players set {who} ct_capacity {cap}',
                f'scoreboard players set {who} ct_paused 0', f'scoreboard players set {who} sp_music 1',
                f'scoreboard players set #players sp_ctx {n}']
        out += [f'scoreboard players set {who} ct_c{i} 1' for i in range(1, 9)]
        out += self.call('engine/init', table)
        for i in range(1, 5):
            out += self.set(f'p{i}.seat', i if cap == 4 else 2*i-1, table)
        return out+self.call('visual/refresh', table)

    def count(self, selector, value, name):
        return ['scoreboard players set #count ce 0',
                f'execute as {selector} run scoreboard players add #count ce 1']+self.score('#count', 'ce', value, name)

    def numeric(self, entity, path, value, name):
        expected = round(value*100000)
        return [f'execute store result score #numeric ce run data get entity {entity} {path} 100000']+self.score('#numeric', 'ce', f'{expected-8}..{expected+8}', name)

    def display(self, kind, id=0, table=101):
        return f'@e[tag=sp.visual,scores={{sp_table={table},sp_vkind={kind},sp_vid={id}}},limit=1]'

    def event(self, code=1, actor=1, card=0, noble=0, table=101):
        event = dict(code=code, actor=actor, target=0, card=card, noble=noble,
                     take=[1, 0, 1, 0, 1, 0], pay=[0]*6)
        return self.set('last', event, table)+self.call('visual/animate', table)

    def timeline(self, name, body, ticks, checks):
        self.case(name, body+[f'schedule function catan_engine_test:timeline/{name}/1 1t'])
        self.waiting.add(name)
        self.file('done/'+name, [])
        for frame in range(1, ticks+1):
            lines = self.call('visual/tick')+checks.get(frame, [])
            lines += [f'function catan_engine_test:done/{name}'] if frame == ticks else [f'schedule function catan_engine_test:timeline/{name}/{frame+1} 1t']
            self.file(f'timeline/{name}/{frame}', lines)

    def build(self):
        for cap in (4, 8):
            for n in (2, 3, 4):
                key = f'c{cap}n{n}'
                body = self.setup(cap, n)
                for kind, expected in ((1, 1), (2, 12), (3, n+1), (4, 6), (5, 3)):
                    body += self.count(f'@e[tag=sp.visual,scores={{sp_table=101,sp_vkind={kind}}}]', expected, key+'_kind'+str(kind))
                body += self.count('@e[tag=sp.visual,scores={sp_table=101}]', 24+n, key+'_bounded_entities')
                body += self.count('@e[type=minecraft:interaction]', 0, key+'_no_interactions')
                body += self.check(f'data entity {self.display(1)} transformation{{right_rotation:[0.0f,1.0f,0.0f,0.0f]}}', key+'_none_renderer_compensated')
                body += self.call('visual/refresh')
                body += self.count('@e[tag=sp.visual,scores={sp_table=101}]', 24+n, key+'_refresh_no_duplicates')
                self.case(key, body)
        body = self.setup()+self.setup(8, table=202, reset=False)
        body += self.call('visual/refresh')+self.call('visual/clear')
        body += self.count('@e[tag=sp.visual,scores={sp_table=101}]', 0, 'clear_own_table')
        body += self.count('@e[tag=sp.visual,scores={sp_table=202}]', 28, 'clear_preserves_other_table')
        body += self.check(f'entity {TABLE}', 'clear_preserves_controller')
        body += self.call('visual/refresh')
        body += self.count('@e[tag=sp.visual,scores={sp_table=101}]', 28, 'refresh_after_clear')
        self.case('two_tables', body)
        body = self.setup()+self.set('market', [0]*12)+self.set('p1.reserve', [89])+self.call('visual/refresh')
        body += self.check('entity @e[tag=sp.visual,nbt={item:{components:{"minecraft:item_model":"card:splendor/tier1/diamond_01"}}}]', 'public_market_visible')
        body += self.count('@e[tag=sp.visual,nbt={item:{components:{"minecraft:item_model":"card:splendor/tier3/onyx_04"}}}]', 0, 'private_reserve_never_displayed')
        body += self.event(code=2, card=89)
        body += self.check(f'data entity {self.display(9)} item.components{{"minecraft:item_model":"card:splendor/bag"}}', 'blind_reserve_neutral_animation')
        body += self.count('@e[tag=sp.visual,nbt={item:{components:{"minecraft:item_model":"card:splendor/tier3/onyx_04"}}}]', 0, 'blind_reserve_animation_no_leak')
        body += self.call('visual/refresh')
        body += self.count('@e[tag=sp.anim,scores={sp_table=101}]', 0, 'reload_drops_unfinished_effect')
        body += self.check(f'data entity {TABLE} data.splendor.p1{{reserve:[89]}}', 'reload_preserves_private_reserve')
        body += self.check(f'data entity {TABLE} data.splendor.last{{card:89}}', 'reload_preserves_committed_last')
        body += self.set('review', True)+self.set('phase', 4)+self.call('visual/refresh')
        body += self.count('@e[tag=sp.visual,scores={sp_table=101}]', 28, 'finished_review_keeps_public_board')
        self.case('secrecy_reload_review', body)
        # 普通四人桌、满八人桌偏置椅与删椅后同侧居中三种实际终点。
        for key, cap, sparse, end in (('four', 4, False, (0, -1.2)),
                                      ('eight_pair', 8, False, (-.6, -1.5)),
                                      ('eight_center', 8, True, (0, -1.5))):
            body = self.setup(cap)
            if sparse:
                body += [f'scoreboard players set {TABLE} ct_c2 0']
            body += self.event(code=1)
            body += self.check(f'data entity {self.display(9)} item.components{{"minecraft:item_model":"card:splendor/token/onyx"}}', key+'_takes_public_token')
            body += self.numeric(TABLE, 'data.splendor.visual_active.motion[9].x', end[0], key+'_actual_chair_x')
            body += self.numeric(TABLE, 'data.splendor.visual_active.motion[9].z', end[1], key+'_actual_chair_z')
            checks = {5: self.numeric(self.display(9), 'transformation.translation[0]', end[0]/2, key+'_animated_half_x')+
                      self.numeric(self.display(9), 'transformation.translation[2]', end[1]/2, key+'_animated_half_z')+
                      self.numeric(self.display(9), 'transformation.translation[1]', .80, key+'_animated_arc'),
                      10: self.count('@e[tag=sp.anim,scores={sp_table=101}]', 0, key+'_animation_cleans')+
                      self.score(TABLE, 'sp_vtimer', 0, key+'_animation_done_timer')}
            self.timeline('motion_'+key, body, 10, checks)
        body = self.setup()+self.event(code=4)
        body += self.numeric(TABLE, 'data.splendor.visual_active.motion[9].x', 0, 'return_motion_bank_x')
        body += self.numeric(TABLE, 'data.splendor.visual_active.motion[9].z', 0, 'return_motion_bank_z')
        body += self.call('visual/tick')+[f'scoreboard players set {TABLE} ct_paused 1']+self.call('visual/tick')*2
        body += self.score(TABLE, 'sp_vtimer', 9, 'paused_animation_does_not_advance')
        body += self.call('visual/clear')
        body += self.count('@e[tag=sp.anim]', 0, 'clear_works_while_paused')
        self.case('return_pause_clear', body)
        manifest = json.loads((RP/'.source/splendor/audio/manifest.json').read_text(encoding='utf-8'))
        loop = manifest['loop_ticks']
        body = self.setup()+self.setup(8, table=202, reset=False)
        body += self.call('sound/start')+self.call('sound/start', 202)
        body += self.score(TABLE, 'sp_bgm', loop, 'music_sets_exact_loop')
        body += self.call('sound/tick')+self.score(TABLE, 'sp_bgm', loop-1, 'music_tick_decrements')
        body += self.score(OTHER, 'sp_bgm', loop, 'music_tick_table_isolation')
        body += [f'scoreboard players set {TABLE} ct_paused 1']+self.call('sound/pause')
        body += self.score(TABLE, 'sp_bgm', 0, 'music_pause_stops')+self.score(OTHER, 'sp_bgm', loop, 'music_pause_other_unaffected')
        body += self.call('sound/start')+self.score(TABLE, 'sp_bgm', 0, 'music_does_not_start_paused')
        body += [f'scoreboard players set {TABLE} ct_paused 0']+self.call('sound/tick')
        body += self.score(TABLE, 'sp_bgm', loop, 'music_resume_restarts')
        body += [f'scoreboard players set {TABLE} sp_music 0']+self.call('sound/tick')
        body += self.score(TABLE, 'sp_bgm', 0, 'music_setting_stops')
        body += [f'scoreboard players set {TABLE} sp_music 1']+self.call('sound/reload')
        body += self.score(TABLE, 'sp_bgm', loop, 'music_reload_restarts')
        body += self.set('phase', 4)+self.call('sound/tick')+self.score(TABLE, 'sp_bgm', 0, 'music_finish_stops')
        for event in ('take', 'reserve', 'buy', 'return', 'noble', 'win', 'illegal'):
            body += self.call('sound/'+event)
        self.case('sound_lifecycle', body)
        self.finish()
        return self


def static_sound():
    for event in ('take', 'reserve', 'buy', 'return', 'noble', 'win', 'illegal'):
        text = (PACK/f'data/splendor/function/sound/{event}.mcfunction').read_text(encoding='utf-8')
        assert 'if score @s sp_table = #sound_table sp_ctx if score @s ct_id = #sound_table sp_ctx' in text
        assert '@a[tag=sp.player,tag=ct.player' in text
        assert 'at @s run playsound' in text
    text = (PACK/'data/splendor/function/sound/stop.mcfunction').read_text(encoding='utf-8')
    assert 'if score @s sp_bgm_table = #sound_table sp_ctx' in text
    for path in (PACK/'data/splendor/function/visual').rglob('*.mcfunction'):
        text = path.read_text(encoding='utf-8')
        assert 'summon minecraft:interaction' not in text
        assert not re.search(r'data\.splendor\.p\$\(actor\)\.(?!seat)', text)
        assert not re.search(r'data\.splendor\.p\d\.(?:reserve|tokens)', text)
    print('Static audience scope, neutral reservation and zero per-slot interactions verified')


def prepare(target):
    (target/'data/minecraft/tags/function/load.json').write_text(json.dumps({'values': ['cardtable:load', 'splendor:load']}), encoding='utf-8')
    # 安装全游戏入口在测试控制器出现前执行，tick 仍为空，只使用显式生产tick。


if __name__ == '__main__':
    check()
    static_sound()
    raise SystemExit(run(Suite().build(), full=True, prepare_target=prepare,
                         prefix='fimel-splendor-visual-', setup_ticks=250))
