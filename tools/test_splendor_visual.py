"""隔离原版26.2：璀璨宝石转盘、数量、选择、资产 HUD、动画与声音。"""
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
            if i <= n:
                out += self.set(f'p{i}.name', {'text': f'Player{i}'}, table)
        out += self.call('game/sync', table)
        return out+self.call('visual/refresh', table)

    def count(self, selector, value, name):
        return ['scoreboard players set #count ce 0',
                f'execute as {selector} run scoreboard players add #count ce 1']+self.score('#count', 'ce', value, name)

    def numeric(self, entity, path, value, name):
        expected = round(value*100000)
        return [f'execute store result score #numeric ce run data get entity {entity} {path} 100000']+self.score('#numeric', 'ce', f'{expected-8}..{expected+8}', name)

    def relative_position(self, entity, axis, value, name):
        expected = round(value*100000)
        return [f'execute store result score #numeric ce run data get entity {entity} Pos[{axis}] 100000',
                f'execute store result score #base ce run data get entity {TABLE} Pos[{axis}] 100000',
                'scoreboard players operation #numeric ce -= #base ce']+self.score('#numeric','ce',f'{expected-8}..{expected+8}',name)

    def display(self, kind, id=0, table=101):
        return f'@e[type=minecraft:item_display,tag=sp.visual,scores={{sp_table={table},sp_vkind={kind},sp_vid={id}}},limit=1]'

    def label(self, kind, id=0):
        return f'@e[type=minecraft:text_display,tag=sp.label,scores={{sp_table=101,sp_vkind={kind},sp_vid={id}}},limit=1]'

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
                    body += self.count(f'@e[type=minecraft:item_display,tag=sp.visual,scores={{sp_table=101,sp_vkind={kind}}}]', expected, key+'_kind'+str(kind))
                body += self.count('@e[type=minecraft:item_display,tag=sp.visual,scores={sp_table=101}]', 23+n, key+'_bounded_models')
                body += self.count('@e[type=minecraft:interaction,tag=sp.hit]', 22+n, key+'_all_public_slots_interactive')
                body += self.count('@e[type=minecraft:text_display,tag=sp.label,scores={sp_table=101}]', 9, key+'_separate_bank_and_deck_counts')
                body += self.check(f'data entity {self.display(1)} transformation{{right_rotation:[0.0f,1.0f,0.0f,0.0f]}}', key+'_none_renderer_compensated')
                body += self.call('visual/refresh')
                body += self.count('@e[type=minecraft:item_display,tag=sp.visual,scores={sp_table=101}]', 23+n, key+'_refresh_no_duplicates')
                self.case(key, body)
        body = self.setup()+self.setup(8, table=202, reset=False)
        body += self.call('visual/refresh')+self.call('visual/clear')
        body += self.count('@e[tag=sp.visual,scores={sp_table=101}]', 0, 'clear_own_table')
        body += self.count('@e[type=minecraft:item_display,tag=sp.visual,scores={sp_table=202}]', 27, 'clear_preserves_other_table')
        body += self.check(f'entity {TABLE}', 'clear_preserves_controller')
        body += self.call('visual/refresh')
        body += self.count('@e[type=minecraft:item_display,tag=sp.visual,scores={sp_table=101}]', 27, 'refresh_after_clear')
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
        body += self.count('@e[type=minecraft:item_display,tag=sp.visual,scores={sp_table=101}]', 27, 'finished_review_keeps_public_board')
        self.case('secrecy_reload_review', body)
        self.rotation_cases()
        self.selection_and_labels()
        self.hud_cases()
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

    def rotation_cases(self):
        for cap in (4, 8):
            for seat in range(1, cap+1):
                side = seat if cap == 4 else (seat+1)//2
                x, z = {1: (0, -1.15), 2: (1.15, 0), 3: (0, 1.15), 4: (-1.15, 0)}[side]
                factor = 1 if cap == 4 else 1.28
                body = self.setup(cap)+self.set('p1.seat', seat)+self.call('visual/refresh')
                # 金币和钻石的中点给出银行朝向；四元数旋转必须与平移同向。
                for axis, value in ((0, x*factor), (2, z*factor)):
                    body += [f'execute store result score #a ce run data get entity {self.display(4, 0)} transformation.translation[{axis}] 100000',
                             f'execute store result score #b ce run data get entity {self.display(4, 5)} transformation.translation[{axis}] 100000',
                             'scoreboard players operation #a ce += #b ce']
                    body += self.score('#a', 'ce', f'{round(value*200000)-8}..{round(value*200000)+8}', f'c{cap}s{seat}_bank_axis{axis}')
                # 第一层比第三层靠近玩家，源槽编号仍然保持不变。
                axis = 2 if side in (1, 3) else 0
                positive = side in (2, 3)
                body += [f'execute store result score #near ce run data get entity {self.display(2, 0)} transformation.translation[{axis}] 100000',
                         f'execute store result score #far ce run data get entity {self.display(2, 8)} transformation.translation[{axis}] 100000']
                body += self.check(f'score #near ce {">" if positive else "<"} #far ce', f'c{cap}s{seat}_tier1_closest')
                # 数量标签的偏移必须在实体Pos中，不能放进朝向镜头的translation。
                angle = {1: 180, 2: 270, 3: 0, 4: 90}[side]
                import math
                for kind, px, pz, py in ((10, -1.05, 1.15, .27), (8, -1.03, .409375, .15)):
                    a = math.radians(angle)
                    xx = (px*math.cos(a)-pz*math.sin(a))*factor
                    zz = (px*math.sin(a)+pz*math.cos(a))*factor
                    entity = self.label(kind)
                    key = f'c{cap}s{seat}_label{kind}'
                    for axis, value in ((0,xx),(1,1.045+py),(2,zz)):
                        body += self.relative_position(entity, axis, value, key+'_world_axis'+str(axis))
                    body += self.check(f'data entity {entity} {{billboard:"vertical",transformation:{{translation:[0.0f,0.0f,0.0f]}}}}', key+'_camera_cannot_orbit_offset')
                self.case(f'rotation_c{cap}s{seat}', body)

    def selection_and_labels(self):
        body = self.setup()+self.set('market', [0]*12)+self.set('p1.bonus', [8]*5)+self.call('visual/refresh')
        body += self.count('@e[tag=sp.label,scores={sp_vkind=7,sp_table=101}]', 12, 'discounts_mark_all_twelve_free')
        body += self.set('turn', 2)+self.call('game/sync')+self.call('visual/refresh')
        body += self.count('@e[tag=sp.label,scores={sp_vkind=7,sp_table=101}]', 0, 'free_uses_current_player_discount')
        body += self.set('deck1', [])+self.set('bank', [0]*6)+self.call('visual/refresh')
        body += self.count('@e[type=minecraft:interaction,tag=sp.hit,scores={sp_table=101}]', 26, 'empty_bank_and_deck_still_explain_clicks')
        body += self.check('entity @e[tag=sp.label,scores={sp_table=101,sp_vkind=8,sp_vid=0},nbt={text:{text:"0"}}]', 'empty_deck_count_zero')
        body += self.count('@e[tag=sp.label,scores={sp_table=101,sp_vkind=10},nbt={text:{text:"0"}}]', 6, 'empty_bank_counts_zero')
        self.case('discounts_counts', body)

        body = self.setup()+self.call('visual/context')
        body += ['execute positioned 8 64 8 summon minecraft:marker run function catan_engine_test:visual_person {table:101,side:1}',
                 'execute as @e[tag=ce.person,limit=1] run function splendor:visual/selection_player']
        body += self.check(f'data entity {self.display(2, 3)} {{Glowing:1b}}', 'selected_market_glows')
        body += ['scoreboard players set @e[tag=ce.person,limit=1] sp_select_kind 0',
                 'scoreboard players set @e[tag=ce.person,limit=1] sp_pick0 1',
                 'scoreboard players set @e[tag=ce.person,limit=1] sp_pick2 1']+self.call('visual/selection')
        body += ['execute as @e[tag=ce.person,limit=1] run function splendor:visual/selection_player']
        body += self.check(f'entity {self.display(2, 3)[:-1]},nbt=!{{Glowing:1b}}]', 'cancel_removes_old_card_glow')
        for i in (0, 2):
            body += self.check(f'data entity {self.display(4, i)} {{Glowing:1b}}', f'gem_selected_{i}_glows')
        body += self.set('eligible', [0, 2])+self.set('phase', 3)+self.call('game/sync')+self.call('visual/selection')
        for i in (0, 2):
            body += self.check(f'data entity {self.display(3, i)} {{Glowing:1b}}', f'eligible_noble_{i}_glows')
        self.case('selection', body)
        body = self.setup()+self.event(code=3, card=0, noble=1)
        body += self.count('@e[tag=sp.anim,scores={sp_table=101}]', 2, 'automatic_noble_gets_separate_flight')
        body += self.check('entity @e[tag=sp.anim,nbt={item:{components:{"minecraft:item_model":"card:splendor/noble/sapphire_emerald"}}}]', 'automatic_noble_face_visible')
        body += self.call('visual/tick')
        body += [f'execute store result score #primary_y ce run data get entity {self.display(9, 0)} transformation.translation[1] 100000',
                 f'execute store result score #noble_y ce run data get entity {self.display(9, 1)} transformation.translation[1] 100000',
                 'scoreboard players operation #noble_y ce -= #primary_y ce']
        body += self.score('#noble_y', 'ce', '11992..12008', 'automatic_noble_flight_above_bought_card')
        self.case('automatic_noble', body)

    def hud_cases(self):
        self.file('visual_person', ['tag @s add ce.fixture', 'tag @s add ce.person', 'tag @s add sp.player', 'tag @s add ct.player',
            '$scoreboard players set @s ct_id $(table)', '$scoreboard players set @s sp_table $(table)',
            '$scoreboard players set @s sp_side $(side)', 'scoreboard players set @s sp_select_kind 2',
            'scoreboard players set @s sp_select_id 3', 'scoreboard players set @s sp_select_epoch 1'])
        person = '@e[tag=ce.person,limit=1]'
        body = self.setup()+self.set('p1.tokens', [1, 2, 3, 4, 0, 1])+self.set('p1.bonus', [1, 2, 0, 1, 0])
        body += self.set('p1.cards', [0, 0, 0, 1])+self.set('p1.nobles', [2])+self.set('p1.vp', 7)+self.set('p1.reserve', [89, 88])
        body += ['function fimel_title:code/load',
                 'execute positioned 8 64 8 summon minecraft:marker run function catan_engine_test:visual_person {table:101,side:1}',
                 f'scoreboard players set {person} sp_hpanel 901', f'scoreboard players set {person} fbt_panel 3']
        body += self.call('system/context')+[f'execute as {person} run function splendor:hud/build']
        body += self.score(person, 'fbt_panel', 901, 'hud_bound_to_player_panel')
        body += self.check('data storage fimel_title:io panels[901][][{font:"card:splendor/hud"}]', 'hud_icons_use_positive_font')
        for i in range(1, 5):
            body += self.check(f'data storage fimel_title:io panels[901][][].extra[].extra[{{text:"Player{i}"}}]', f'hud_includes_player{i}')
        body += self.check('data storage splendor:hud row{reserved:0}', 'hud_reserve_identity_not_copied_into_row')
        # 检查实际展开的BetterTitle panel：每位玩家四行，左右列独立锚定。
        for side in range(1, 5):
            first = 9+(side-1)*36
            xx = 8 if side%2 else -8
            yy = -24 if side<=2 else -80
            origin = '5' if side%2 else '6'
            for line in range(4):
                offset = first+line*9
                xglyph = chr(int(str(4000+xx*2),16))
                yglyph = chr(int(str(2500+(yy-line*12)*2),16))
                for pos, font, glyph in ((offset,'x_displace',xglyph),(offset+1,'y_displace',yglyph),(offset+2,'o_displace',origin)):
                    body += [f'data modify storage splendor_visual_test:probe part set from storage fimel_title:io panels[901][{pos}]']
                    body += self.check('data storage splendor_visual_test:probe part'+json.dumps({'font':'title:'+font,'text':glyph},ensure_ascii=False,separators=(',',':')),f'hud_p{side}_line{line}_{font}')
        body += self.check('data storage fimel_title:io {x:0.0d,y:0.0d,dx:0,dy:0,origin:"default",align:"middle",font:"minecraft:default_mod",neg_font:"minecraft:default_neg"}', 'status_has_own_center_anchor')
        body += [f'data modify storage catan_engine_test:snapshot saved set from entity {TABLE} data.splendor',
                 f'execute as {person} run function splendor:hud/notice {{text:{{text:"本次出牌失败",color:"red"}}}}']
        body += self.score(person, 'sp_htimer', 100, 'notice_last_five_seconds')
        body += self.check('data storage splendor:hud notices.p901{text:"本次出牌失败"}', 'notice_stored_by_unique_panel')
        body += self.check('data storage fimel_title:io {x:0.0d,y:0.0d,origin:"default",align:"middle",font:"minecraft:default_mod",neg_font:"minecraft:default_neg"}', 'notice_uses_same_center_anchor')
        body += ['execute store success score #different ce run data modify storage catan_engine_test:snapshot saved set from entity '+TABLE+' data.splendor']
        body += self.score('#different', 'ce', 0, 'notice_does_not_mutate_rules_state')
        body += [f'scoreboard players set {person} sp_htimer 1', f'execute as {person} run function splendor:hud/tick']
        body += self.score(person, 'sp_htimer', 0, 'notice_expires_exactly')
        body += [f'execute as {person} run function splendor:hud/deactivate']
        body += self.score(person, 'fbt_panel', 3, 'hud_restores_prior_panel')
        body += self.check('data storage splendor:hud notices', 'hud_notice_storage_remains_well_formed')
        body += self.check('data storage fimel_title:io panels[901]', 'hud_own_panel_retained_for_reuse')
        self.case('hud', body)


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
    from build_splendor_visual import pose
    for yaw in (0, 90, 180, 270):
        p = pose(0, 1, yaw=yaw)
        # 四元数将局部前沿+Z旋转到与牌桌布局相同的世界方向。
        x, z = 2*p['qy']*p['qw'], 1-2*p['qy']**2
        assert abs(x-p['x']) < 1e-6 and abs(z-p['z']) < 1e-6
    print('Static audience scope, neutral reservation and four cardinal rotations verified')


def hud_font_geometry():
    """实际位图advance与两次负字距相加须为0，避免每行及居中原点累积偏移。"""
    from PIL import Image
    providers = json.loads((RP/'assets/card/font/splendor/small.json').read_text(encoding='utf-8'))['providers']
    negative = json.loads((RP/'assets/card/font/splendor/hud_neg.json').read_text(encoding='utf-8'))['providers'][0]['advances']
    checked = 0
    for p in providers:
        if p['type'] != 'bitmap':
            continue
        with Image.open(RP/'assets'/p['file'].replace(':','/textures/')) as image:
            w,h = image.width//len(p['chars'][0]), image.height//len(p['chars'])
            for y,row in enumerate(p['chars']):
                for x,ch in enumerate(row):
                    if ch not in negative:
                        continue
                    box=image.convert('RGBA').getchannel('A').crop((x*w,y*h,(x+1)*w,(y+1)*h)).getbbox()
                    advance=int((box[2] if box else 0)*p['height']/h+.5)+1
                    assert advance+2*negative[ch]==0,(hex(ord(ch)),advance,negative[ch])
                    checked+=1
    assert checked==6
    print('HUD bitmap half-width rewinds verified:',checked)


def prepare(target):
    (target/'data/minecraft/tags/function/load.json').write_text(json.dumps({'values': ['cardtable:load', 'splendor:load']}), encoding='utf-8')
    # 安装全游戏入口在测试控制器出现前执行，tick 仍为空，只使用显式生产tick。


if __name__ == '__main__':
    check()
    static_sound()
    hud_font_geometry()
    raise SystemExit(run(Suite().build(), full=True, prepare_target=prepare,
                         prefix='fimel-splendor-visual-', setup_ticks=250))
