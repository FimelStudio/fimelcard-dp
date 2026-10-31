"""飞行棋原版 26.2 GameTest：独立临时世界，不接触玩家存档。

穷举计划器，再检查投骰锁、逐段提交、撞机等待、重载、排名、设置和座椅。
测试复制品仅将服务端玩家筛选扩为测试盔甲架；客户端画面、声音、Q 操作另验。
"""
from pathlib import Path
import argparse
import itertools
import json
import re
import shutil
import subprocess
import tempfile
import time

PACK = Path(__file__).resolve().parents[1]
TABLE = '@e[type=minecraft:marker,tag=ag.table,scores={ct_id=101},limit=1]'
OTHER = '@e[type=minecraft:marker,tag=ag.table,scores={ct_id=202},limit=1]'


def plane(color=0, number=0, table=101):
    return f'@e[type=minecraft:marker,tag=ac.plane,scores={{ct_id={table},ac_color={color},ac_plane={number}}},limit=1]'


def person(number=1):
    return f'@e[type=minecraft:armor_stand,tag=ag.p{number},limit=1]'


def oracle(pos, dice, takeoff, jump, fly, finish):
    """独立的棋谱计算；逐格轨迹与特殊落点均保存，方便严格比较顺序。"""
    if pos < 0:
        return ([{'pos': 0, 'kind': 1, 'land': 1}]
                if dice == 6 or takeoff == 2 or takeoff == 1 and dice == 5 else [])
    total = pos + dice
    if pos == 57 or finish == 1 and total > 57:
        return []
    travel = [p if p <= 57 else 114-p for p in range(pos+1, total+1)]
    result = [{'pos': p, 'kind': 0, 'land': int(i == len(travel)-1)}
              for i, p in enumerate(travel)]
    at = travel[-1]
    used = set()
    while True:
        if at == 19 and fly and 'fly' not in used:
            at = 31; used.add('fly'); kind = 3
        elif 3 <= at <= 47 and at % 4 == 3 and jump and 'jump' not in used:
            at += 4; used.add('jump'); kind = 2
        else:
            break
        result.append({'pos': at, 'kind': kind, 'land': 1})
    return result


class Suite:
    def __init__(self):
        self.files, self.cases, self.expected = {}, [], []

    def file(self, name, lines):
        self.files[name] = ('\n'.join(lines) if isinstance(lines, list) else lines).strip()+'\n'

    def check(self, condition, name):
        assert name not in self.expected, name
        self.expected.append(name)
        return [f'execute if {condition} run say AEROPLANE_PASS {name}',
                f'execute unless {condition} run say AEROPLANE_FAIL {name}']

    def score(self, target, obj, value, name):
        return self.check(f'score {target} {obj} matches {value}', name)

    def count(self, selector, expected, name):
        return ['scoreboard players set #count ag 0',
                f'execute as {selector} run scoreboard players add #count ag 1']+self.score('#count', 'ag', expected, name)

    def call(self, name, table=101):
        return [f'execute as {TABLE if table == 101 else OTHER} at @s run function aeroplane_chess:{name}']

    def setup(self, cap=4, orient=0, table=101, reset=True, seats=()):
        lines = (['function aeroplane_test:reset'] if reset else [])+[
            f'execute positioned {8 if table == 101 else 40} 64 8 summon minecraft:marker run function aeroplane_test:table {{table:{table},cap:{cap},orient:{orient}}}']
        for number, seat in enumerate(seats, 1 if table == 101 else 5):
            lines += [f'execute positioned {8 if table == 101 else 40} 64 8 summon minecraft:armor_stand run function aeroplane_test:person {{number:{number},table:{table},seat:{seat}}}']
        return lines+self.call('system/context', table)

    def active(self, colors=(0, 2)):
        lines = [f'scoreboard players set {TABLE} ct_state 1',
                 f'scoreboard players set {TABLE} ac_state 1',
                 f'scoreboard players set {TABLE} ac_players {len(colors)}',
                 f'scoreboard players set {TABLE} ac_ranked 0',
                 f'scoreboard players set {TABLE} ac_finished 0',
                 f'scoreboard players set {TABLE} ac_winner -1',
                 f'scoreboard players set {TABLE} ac_turn {colors[0]}',
                 f'scoreboard players set {TABLE} ac_pulse -100000',
                 'scoreboard players set @e[tag=ac.sides] ac_active 0']
        lines += [f'scoreboard players set @e[tag=ac.sides,scores={{ac_color={c}}}] ac_active 1' for c in colors]
        return lines+self.call('game/sync_active')

    def choose(self, pos, dice, jump=0, fly=0, finish=0):
        return [f'scoreboard players set {TABLE} ac_state 3',
                f'scoreboard players set {TABLE} ac_roll {dice}',
                f'scoreboard players set {TABLE} ac_jump {jump}',
                f'scoreboard players set {TABLE} ac_fly {fly}',
                f'scoreboard players set {TABLE} ac_finish {finish}',
                f'scoreboard players set {plane()} ac_pos {pos}',
                'scoreboard players set #plane ac_ctx 0']+self.call('game/choose_internal')

    def ticks(self, count):
        return self.call('system/tick')*count

    def case(self, name, lines):
        self.cases.append(name); self.file('case/'+name, lines)

    def build(self, exhaustive=True):
        self.file('reset', ['kill @e[tag=ag.fixture]', 'kill @e[tag=ac.visual]',
                            'kill @e[tag=ac.plane]', 'kill @e[tag=ac.side]',
                            'kill @e[tag=ac.firework]',
                            'kill @e[tag=ct.seat]', 'kill @e[tag=ct.menu]', 'kill @e[tag=ct.vote]'])
        self.file('table', '''
tag @s add ag.fixture
tag @s add ag.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_capacity $(cap)
$scoreboard players set @s ac_orient $(orient)
scoreboard players set @s ct_game 15
scoreboard players set @s ct_state 0
scoreboard players set @s ct_joined 0
scoreboard players set @s ct_start 0
data merge entity @s {data:{cardtable:{menu_version:15,rules_version:5,chairs_version:1,vote_version:1}}}
function cardtable:table/ensure_seats
function aeroplane_chess:game/init_table
''')
        self.file('person', '''
tag @s add ag.fixture
tag @s add ag.person
$tag @s add ag.p$(number)
tag @s add ct.player
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_seat $(seat)
scoreboard players set @s ct_online 1
data merge entity @s {NoGravity:1b,Invisible:1b,Invulnerable:1b}
''')
        # 每批 24 个样例，避免把整套穷举塞进同一函数链。
        batch, count = [], 0
        for takeoff, jump, fly, finish in itertools.product(range(3), range(2), range(2), range(2)):
            if not exhaustive: break
            for pos, dice in itertools.product(range(-1, 58), range(1, 7)):
                key = f'plan_{takeoff}{jump}{fly}{finish}_{pos+1}_{dice}'
                queue = oracle(pos, dice, takeoff, jump, fly, finish)
                batch += [f'scoreboard players set {TABLE} ac_takeoff {takeoff}',
                          f'scoreboard players set {TABLE} ac_jump {jump}',
                          f'scoreboard players set {TABLE} ac_fly {fly}',
                          f'scoreboard players set {TABLE} ac_finish {finish}',
                          f'scoreboard players set {TABLE} ac_roll {dice}',
                          f'scoreboard players set {plane()} ac_pos {pos}',
                          'scoreboard players set #plane ac_ctx 0', 'scoreboard players set #color ac_ctx 0']+self.call('engine/plan')
                batch += ['scoreboard players set #ok ag 1',
                          f'execute unless score #legal ac_ctx matches {int(bool(queue))} run scoreboard players set #ok ag 0',
                          f'execute unless score {TABLE} ac_roll matches {dice} run scoreboard players set #ok ag 0',
                          f'execute unless score {plane()} ac_pos matches {pos} run scoreboard players set #ok ag 0',
                          'data modify storage aeroplane_test:run cmp set value '+json.dumps(queue,separators=(',',':')),
                          'execute store success score #different ag run data modify storage aeroplane_test:run cmp set from storage aeroplane_chess:runtime plan.queue',
                          'execute unless score #different ag matches 0 run scoreboard players set #ok ag 0']
                if queue: batch += [f'execute unless score #dest ac_ctx matches {queue[-1]["pos"]} run scoreboard players set #ok ag 0']
                batch += self.score('#ok', 'ag', 1, key); count += 1
                if count % 24 == 0:
                    self.case('rules_'+str(count//24), batch); batch=[]
        if batch: self.case('rules_last', batch)
        # 传统环末格有半格延长，进入内道首格的间距为1.5个模板单位。
        from build_aeroplane_engine import path_manifest
        manifest = path_manifest()
        for color in manifest['colors']:
            last = manifest['ring'][(color['start']+50)%52]
            first = color['home'][0]
            assert abs(sum(abs(a-b) for a,b in zip(last,first))-1.5*manifest['unit_step'])<1e-7, (color['name'],last,first)
        for cap, orient in itertools.product((4, 8), range(2)):
            name=f'preview_{cap}_{orient}'
            self.case(name,self.setup(cap,orient)+self.count('@e[tag=ac.board]',16,name+'_planes')+
                      self.count('@e[tag=ac.sides]',4,name+'_sides')+self.score(TABLE,'ac_state',0,name+'_state')+
                      self.count('@e[tag=ac.man]',16,name+'_models')+self.count('@e[tag=ac.plane_click]',16,name+'_plane_clicks')+
                      self.count('@e[tag=ac.die]',1,name+'_die')+self.count('@e[tag=ac.dice_click]',1,name+'_dice_click'))
        c=self.setup()+self.active()+[f'scoreboard players set {TABLE} ac_takeoff 2']+self.call('game/roll_internal')
        c+=['scoreboard players operation #locked ag = '+TABLE+' ac_roll']+self.call('game/roll_internal')
        c+=self.check(f'score {TABLE} ac_roll = #locked ag','roll_lock_same_result')+self.score(TABLE,'ac_timer',20,'repeat_roll_does_not_reset_timer')
        c+=self.ticks(19)+self.score(TABLE,'ac_state',2,'dice_anim_last_tick_locked')+self.ticks(1)+self.score(TABLE,'ac_state',3,'dice_anim_unlocks_once')
        c+=self.check(f'score {TABLE} ac_roll = #locked ag','dice_result_not_rerolled')+self.count('@e[tag=ac.board,scores={ac_color=0,ac_legal=1}]',4,'all_takeoff_legal')
        self.case('dice_lock',c)
        c=self.setup()+self.active()+[f'scoreboard players set {TABLE} ac_takeoff 0',f'scoreboard players set {TABLE} ac_roll 1']+self.call('game/dice_done')
        c+=self.score(TABLE,'ac_state',1,'no_move_auto_next')+self.score(TABLE,'ac_turn',2,'inactive_colors_skipped')
        self.case('no_moves',c)
        c=self.setup()+self.active((0,1,2))+[f'scoreboard players set {plane(1,0)} ac_pos 44',f'scoreboard players set {plane(1,1)} ac_pos 44']+self.choose(4,1)
        c+=self.ticks(4)+self.score(plane(),'ac_pos',5,'capture_mover_lands')+self.score(plane(1,0),'ac_pos',-1,'capture_first_returns')+self.score(plane(1,1),'ac_pos',-1,'capture_stack_returns')
        c+=self.score(plane(1,0),'ac_prev',44,'capture_keeps_departure')+self.score(TABLE,'ac_state',6,'capture_animation_waits')
        c+=self.ticks(5)+self.score(TABLE,'ac_state',6,'capture_five_ticks_still_waits')+self.ticks(1)+self.score(TABLE,'ac_turn',1,'capture_wait_then_next_turn')
        self.case('capture_stack',c)
        c=self.setup()+self.active((0,1,2))+[f'scoreboard players set {plane(1)} ac_pos 41']+self.choose(1,3)+self.ticks(12)
        c+=self.score(plane(1),'ac_pos',41,'passing_enemy_not_captured')+self.score(plane(),'ac_pos',4,'three_steps_exact')
        self.case('no_capture_passing',c)
        c=self.setup()+self.active((0,1,2))+[f'scoreboard players set {plane(1)} ac_pos 2',f'scoreboard players set {plane(2)} ac_pos 5']+self.choose(14,1,jump=1,fly=1)
        c+=self.ticks(4)+self.score(TABLE,'ac_state',6,'chain_first_capture_wait')+self.score(plane(),'ac_pos',15,'chain_normal_landing')
        c+=self.ticks(6)+self.score(TABLE,'ac_topos',19,'chain_jump_after_wait')+self.ticks(4)+self.score(TABLE,'ac_topos',31,'chain_flight_follows_jump')
        c+=self.ticks(4)+self.score(plane(2),'ac_pos',-1,'chain_flight_capture')+self.score(TABLE,'ac_state',6,'chain_second_capture_wait')+self.ticks(6)+self.score(plane(),'ac_pos',31,'chain_finishes31')
        self.case('jump_flight_capture_chain',c)
        c=self.setup()+self.active()+self.choose(56,3)+self.ticks(12)+self.score(plane(),'ac_pos',55,'finish_rebounds_exact_steps')
        self.case('finish_rebound',c)
        c=self.setup()+self.active()+[f'scoreboard players set @e[tag=ac.board,scores={{ac_color=0}}] ac_pos 57']+self.choose(56,1)+self.ticks(4)
        c+=self.score(TABLE,'ac_state',5,'first_winner_finishes')+self.score(TABLE,'ac_winner',0,'red_winner')+self.score('@e[tag=ac.sides,scores={ac_color=0},limit=1]','ac_rank',1,'winner_rank1')
        c+=self.call('game/cleanup')+self.score(TABLE,'ct_state',0,'cleanup_returns_lobby')+self.check(f'data entity {TABLE} data.aeroplane_chess{{review:1b}}','cleanup_keeps_review')+self.score(plane(),'ac_pos',57,'cleanup_keeps_terminal_position')
        c+=self.call('game/preview')+self.score(plane(),'ac_pos',57,'preview_keeps_finished_game')+self.call('game/remove')+self.count('@e[tag=ac.plane]',0,'remove_clears_planes')+self.count('@e[tag=ac.visual]',0,'remove_clears_visuals')
        self.case('win_review_remove',c)
        c=self.setup()+self.active((0,1,2))+[f'scoreboard players set {TABLE} ac_ranking 1',f'scoreboard players set {TABLE} ac_ranked 1',f'scoreboard players set @e[tag=ac.sides,scores={{ac_color=1}}] ac_rank 99',f'scoreboard players set @e[tag=ac.board,scores={{ac_color=0}}] ac_pos 57']+self.choose(56,1)+self.ticks(4)
        c+=self.score('@e[tag=ac.sides,scores={ac_color=0},limit=1]','ac_rank',1,'resigned_opponent_does_not_steal_first_place')+self.score('@e[tag=ac.sides,scores={ac_color=2},limit=1]','ac_rank',2,'remaining_side_gets_second')
        self.case('ranking_after_resign',c)
        for state in (1,2,3,4,5,6):
            c=self.setup()+self.active()+[f'scoreboard players set {TABLE} ac_state {state}',f'scoreboard players set {TABLE} ac_timer 7',f'scoreboard players set {TABLE} ac_roll 5',f'data modify entity {TABLE} data.aeroplane_chess.queue set value [{{pos:8,kind:0,land:1}}]']+self.call('system/reload')
            c+=self.score(TABLE,'ac_state',state,f'reload_state{state}')+self.score(TABLE,'ac_roll',5,f'reload_roll{state}')+self.score(TABLE,'ac_timer',7,f'reload_timer{state}')+self.check(f'data entity {TABLE} data.aeroplane_chess.queue[{{pos:8}}]',f'reload_queue{state}')
            c+=self.call('game/abort')+self.score(TABLE,'ct_state',0,f'abort_state{state}')+self.check(f'data entity {TABLE} data.aeroplane_chess{{review:1b}}',f'abort_review{state}')
            self.case('reload_abort_'+str(state),c)
        c=self.setup()+self.active()+[f'scoreboard players set {TABLE} ac_state 3',f'scoreboard players set {TABLE} ac_roll 6',f'scoreboard players set {TABLE} ac_sixes 2',f'scoreboard players set {TABLE} ac_triple 1']+self.call('game/dice_done')
        c+=self.score(TABLE,'ac_turn',2,'third_six_ends_turn')+self.score(plane(),'ac_pos',-1,'third_six_no_move')
        self.case('triple_six',c)
        c=self.setup()+self.active()+[f'scoreboard players set {TABLE} ac_roll 6',f'scoreboard players set {TABLE} ac_sixes 3',f'scoreboard players set {TABLE} ac_triple 0']+self.call('game/action_done')+self.score(TABLE,'ac_turn',0,'unpenalized_third_six_extra')
        self.case('extra_turn',c)
        c=self.setup()+self.active((3,))+[f'scoreboard players set {TABLE} ac_first 0']+self.call('game/first_turn')+self.score(TABLE,'ac_turn',3,'random_first_uses_only_active_side')
        c+=self.active((0,1))+[f'scoreboard players set {TABLE} ac_first 4']+self.call('game/first_turn')+self.score(TABLE,'ac_turn',0,'specified_inactive_color_skips_forward')
        c+=[f'scoreboard players set {TABLE} ac_assign 1',f'scoreboard players set @e[tag=ac.sides] ac_active 1',f'scoreboard players set @e[tag=ac.sides,scores={{ac_color=2}}] ac_active 0',f'execute summon minecraft:armor_stand run function aeroplane_test:person {{number:1,table:101,seat:3}}',f'execute as {person()} at @s run function aeroplane_chess:player/init']+self.score(person(),'ac_color',2,'random_assignment_picks_unclaimed_side')
        self.case('sparse_random_choices',c)
        # 继续排名时，已完成者跳过；最后一方自动取得剩余名次。
        c=self.setup()+self.active((0,1,2))+[f'scoreboard players set {TABLE} ac_ranking 1',f'scoreboard players set @e[tag=ac.board,scores={{ac_color=0}}] ac_pos 57']+self.choose(56,1)+self.ticks(4)
        c+=self.score(TABLE,'ac_state',1,'ranking_continues')+self.score(TABLE,'ac_turn',1,'ranking_skips_completed_red')
        c+=[f'scoreboard players set @e[tag=ac.board,scores={{ac_color=1}}] ac_pos 57',f'scoreboard players set {plane(1)} ac_pos 56',f'scoreboard players set {TABLE} ac_state 3',f'scoreboard players set {TABLE} ac_roll 1','scoreboard players set #plane ac_ctx 0']+self.call('game/choose_internal')+self.ticks(4)
        c+=self.score('@e[tag=ac.sides,scores={ac_color=1},limit=1]','ac_rank',2,'ranking_second')+self.score('@e[tag=ac.sides,scores={ac_color=2},limit=1]','ac_rank',3,'ranking_last_third')+self.score(TABLE,'ac_state',5,'ranking_all_finished')
        self.case('continued_ranking',c)
        # 电脑复用相同的计划器，不额外抽随机数；终点与撞机优先于单纯推进。
        c=self.setup()+self.active()+[f'scoreboard players set {TABLE} ac_state 3',f'scoreboard players set {TABLE} ac_roll 1',f'scoreboard players set {TABLE} ac_jump 0',f'scoreboard players set {TABLE} ac_fly 0',f'scoreboard players set {plane()} ac_pos 56',f'scoreboard players set {plane(0,1)} ac_pos 20']+self.call('ai/choose')
        c+=self.score(TABLE,'ac_selected',0,'ai_prefers_finish')+self.score(TABLE,'ac_roll',1,'ai_does_not_reroll')
        self.case('ai_finish',c)
        c=self.setup()+self.active((0,1))+[f'scoreboard players set {TABLE} ac_state 3',f'scoreboard players set {TABLE} ac_roll 1',f'scoreboard players set {TABLE} ac_jump 0',f'scoreboard players set {TABLE} ac_fly 0',f'scoreboard players set {plane()} ac_pos 30',f'scoreboard players set {plane(0,1)} ac_pos 4',f'scoreboard players set {plane(1)} ac_pos 44']+self.call('ai/choose')+self.score(TABLE,'ac_selected',1,'ai_prefers_capture')
        self.case('ai_capture',c)
        c=self.setup()+self.active((0,1))+[f'scoreboard players set {TABLE} ac_state 3',f'scoreboard players set {TABLE} ac_roll 1',f'scoreboard players set {TABLE} ac_jump 0',f'scoreboard players set {TABLE} ac_fly 0',f'scoreboard players set {plane()} ac_pos 10',f'scoreboard players set {plane(0,1)} ac_pos 12',f'scoreboard players set {plane(0,2)} ac_pos 57',f'scoreboard players set {plane(0,3)} ac_pos 57',f'scoreboard players set {plane(1)} ac_pos 51']+self.call('ai/choose')+self.score(TABLE,'ac_selected',0,'ai_avoids_nearby_pursuer')
        self.case('ai_risk',c)
        c=self.setup()+self.active()+[f'scoreboard players set {TABLE} ac_takeoff 2',f'scoreboard players set @e[tag=ac.sides,scores={{ac_color=0}}] ac_bot 1',f'scoreboard players set {TABLE} ac_wait 1']+self.ticks(1)+self.score(TABLE,'ac_state',2,'ai_auto_rolls')+self.ticks(20)+self.score(TABLE,'ac_state',3,'ai_waits_for_dice_stop')+self.ticks(10)+self.score(TABLE,'ac_state',4,'ai_selects_legal_plane')
        self.case('ai_tick',c)
        c=self.setup()+self.active()+self.setup(table=202,reset=False)+self.call('system/context')+self.choose(4,1)+self.ticks(4)
        c+=self.score(plane(table=202),'ac_pos',-1,'other_table_unchanged')+self.call('game/remove')+self.count('@e[tag=ac.plane,scores={ct_id=101}]',0,'isolation_removes_only_target')+self.count('@e[tag=ac.plane,scores={ct_id=202}]',16,'isolation_keeps_other_markers')+self.count('@e[tag=ac.man,scores={ct_id=202}]',16,'isolation_keeps_other_models')
        self.case('table_isolation',c)
        c=self.setup()+self.active((0,1,2))+[f'scoreboard players set @e[tag=ac.sides,scores={{ac_color=0}}] ac_rank 1',f'scoreboard players set {TABLE} ac_turn 1',f'scoreboard players set {TABLE} ac_roll 4',f'scoreboard players set {TABLE} ac_state 2','scoreboard objectives remove ac_finished','scoreboard players set #version ac_ctx 1','function aeroplane_chess:load']
        c+=self.score('#version','ac_ctx',2,'upgrade_version2')+self.score(TABLE,'ac_finished',1,'upgrade_counts_completed_sides')+self.score(TABLE,'ac_state',2,'upgrade_preserves_phase')+self.score(TABLE,'ac_roll',4,'upgrade_preserves_dice')
        self.case('upgrade_v2',c)
        self.build_start_settings()
        c=self.setup(seats=(3,))+[f'tag {person()} add ct.settings_actor','scoreboard players set #settings_compiled ag 0']+self.call('settings/open')+self.score('#settings_compiled','ag',1,'settings_macro_compiles_actual_codec')
        c+=[f'tag {person()} add ac.player',f'scoreboard players set {person()} ac_table 101',f'scoreboard players set {person()} ac_color 0',f'scoreboard players set {TABLE} ct_state 1',f'scoreboard players set {TABLE} ac_state 1','scoreboard players set #ui_compiled ag 0',f'execute as {person()} at @s run function aeroplane_chess:ui/quick']+self.score('#ui_compiled','ag',1,'quick_multi_action_codec')
        c+=[f'scoreboard players set {TABLE} ac_state 5','scoreboard players set #ui_compiled ag 0',f'execute as {person()} at @s run function aeroplane_chess:ui/quick']+self.score('#ui_compiled','ag',1,'quick_empty_actions_notice_codec')
        self.case('dialog_codecs',c)
        c=self.setup(seats=(3,))+[f'execute as {person()} at @s run function aeroplane_chess:game/firework_player']
        c+=self.count('@e[type=minecraft:firework_rocket,tag=ac.firework,scores={ct_id=101}]',1,'sk_firework_api_spawns_tagged_rocket')+self.count('@e[tag=ac.firework.new]',0,'sk_firework_temporary_tag_cleared')
        self.case('sk_firework',c)
        # 电脑在对应桌边放 SK 烟花；重复 finish 不重复计时或庆祝。
        for cap,orient,color in itertools.product((4,8),range(2),range(4)):
            key=f'bot_firework_{cap}_{orient}_{color}'
            c=self.setup(cap,orient)+self.active((color,))+[f'scoreboard players set @e[tag=ac.sides,scores={{ac_color={color}}}] ac_bot 1']+self.call('game/firework')
            c+=self.count('@e[type=minecraft:firework_rocket,tag=ac.firework,scores={ct_id=101}]',1,key+'_one')
            anchors={4:[(0,2),(-2,0),(0,-2),(2,0)],8:[(1,2.5),(-2.5,1),(-1,-2.5),(2.5,-1)]}
            x,z=anchors[cap][(color+orient)%4]
            # setup 的整数绝对 x/z 会由 Minecraft 自动置中为8.5；比较点显式使用浮点。
            c+=[f'execute positioned {8.5+x:.2f} 65.32 {8.5+z:.2f} store success score #near ag if entity @e[type=minecraft:firework_rocket,tag=ac.firework,distance=..0.01]']+self.score('#near','ag',1,key+'_correct_side')
            c+=self.call('game/finish')+[f'scoreboard players set {TABLE} ac_timer 42']+self.call('game/finish')
            c+=self.score(TABLE,'ac_timer',42,key+'_finish_idempotent')+self.count('@e[type=minecraft:firework_rocket,tag=ac.firework,scores={ct_id=101}]',1,key+'_finish_no_duplicate')
            self.case(key,c)
        c=self.setup()+self.active((0,2))+[f'scoreboard players set @e[tag=ac.sides,scores={{ac_color=0}}] ac_rank 99',f'scoreboard players set @e[tag=ac.sides,scores={{ac_color=2}}] ac_bot 1',f'scoreboard players set {TABLE} ac_ranked 1']+self.call('game/last_side')
        c+=self.score(TABLE,'ac_winner',2,'last_ai_wins_after_resign')+self.score(TABLE,'ac_state',5,'last_ai_enters_result')+self.count('@e[type=minecraft:firework_rocket,tag=ac.firework,scores={ct_id=101}]',1,'last_ai_celebrates_after_resign')
        self.case('last_ai_winner',c)
        self.file('bootstrap',['scoreboard objectives add ag dummy','function aeroplane_chess:load','function aeroplane_test:reset']+self.setup()+[f'schedule function aeroplane_test:case/{self.cases[0]} 2t'])
        self.file('finish',['say AEROPLANE_FINISHED'])
        for i,name in enumerate(self.cases):
            self.files['case/'+name]+='schedule function aeroplane_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 1t\n'

    def build_start_settings(self):
        for cap, orient, players in itertools.product((4,8),range(2),range(1,5)):
            seats=([3,4,1,2] if cap==4 else [6,8,2,4])[:players]
            key=f'start_{cap}_{orient}_{players}'
            c=self.setup(cap,orient,seats=seats)+[f'scoreboard players set {TABLE} ct_joined {players}']+self.call('game/start')
            expected=2 if players==1 else players
            c+=self.score(TABLE,'ct_start',1,key+'_starts')+self.score(TABLE,'ac_players',expected,key+'_parties')+self.count('@e[tag=ac.sides,scores={ac_active=1}]',expected,key+'_active')
            c+=self.count('@e[tag=ac.man]',expected*4,key+'_active_models')+self.count('@e[tag=ac.plane_click]',expected*4,key+'_active_clicks')
            for p in range(1,players+1):
                c+=self.score(person(p),'ac_table',101,key+f'_p{p}_identity')
                c+=['scoreboard players set #mounted ag 0',f'execute as {person(p)} on vehicle if entity @s[tag=ct.seat,scores={{ct_id=101}}] run scoreboard players set #mounted ag 1']+self.score('#mounted','ag',1,key+f'_p{p}_mounted')
            c+=[f'scoreboard players set {TABLE} ct_state 1']+self.call('system/heartbeat')+self.score(TABLE,'ac_state',1,key+'_heartbeat')
            self.case(key,c)
        for mode,players,want,bots in [(2,1,0,0),(2,2,2,0),(0,1,2,1),(1,1,4,3),(1,2,4,2)]:
            key=f'bot_fill_{mode}_{players}'
            c=self.setup(seats=(3,1)[:players])+[f'scoreboard players set {TABLE} ct_joined {players}',f'scoreboard players set {TABLE} ac_fill {mode}']+self.call('game/start')
            c+=self.score(TABLE,'ct_start',int(bool(want)),key+'_handshake')
            if want:
                c+=self.score(TABLE,'ac_players',want,key+'_parties')+self.count('@e[tag=ac.sides,scores={ac_active=1,ac_bot=1}]',bots,key+'_bots')
            else:
                c+=self.count('@e[tag=ag.person,tag=ac.player]',0,key+'_no_partial_identity')+self.score(person(),'ct_seat',3,key+'_no_seat_mutation')
            self.case(key,c)
        from build_aeroplane_settings import FIELDS
        for field,key,_,choices in FIELDS:
            for value,_ in choices:
                label=f'setting_{field}_{value}'
                c=self.setup(seats=(3,))+[f'tag {person()} add ct.settings_actor']+self.call('settings/open')
                c+=[f'scoreboard players operation #setting_code ag = {person()} ac_setnonce', 'scoreboard players set #scale ag 10000','scoreboard players operation #setting_code ag *= #scale ag',f'scoreboard players add #setting_code ag {field*100+value}',f'scoreboard players operation {person()} ac_settings = #setting_code ag',f'execute as {person()} at @s run function aeroplane_chess:settings/save']
                c+=self.score(TABLE,'ac_'+key,value,label+'_instant')
                c+=[f'scoreboard players operation {person()} ac_settings = #setting_code ag',f'execute as {person()} at @s run function aeroplane_chess:settings/save']+self.score(TABLE,'ac_'+key,value,label+'_no_replay')
                self.case(label,c)
        for change,commands in [('table',[f'scoreboard players set {person()} ct_id 202']),('epoch',[f'scoreboard players add {TABLE} ac_epoch 1']),('game',[f'scoreboard players set {TABLE} ct_game 14']),('reload',['function aeroplane_chess:load'])]:
            c=self.setup(seats=(3,))+[f'tag {person()} add ct.settings_actor']+self.call('settings/open')
            c+=[f'scoreboard players operation #setting_code ag = {person()} ac_setnonce','scoreboard players set #scale ag 10000','scoreboard players operation #setting_code ag *= #scale ag','scoreboard players add #setting_code ag 102']+commands
            c+=[f'scoreboard players operation {person()} ac_settings = #setting_code ag',f'execute as {person()} at @s run function aeroplane_chess:settings/save']+self.score(TABLE,'ac_takeoff',0,'stale_setting_'+change)
            self.case('stale_setting_'+change,c)


def run(suite):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--java',type=Path,default=Path('C:/Temp/fimel-uno-java25/jdk-25.0.5+8-jre/bin/java.exe'))
    parser.add_argument('--minecraft-root',type=Path,default=Path('D:/PCL2/MinecraftPcl'))
    parser.add_argument('--version',default='26.2-Fabric_0.19.3')
    parser.add_argument('--allow-missing-visuals',action='store_true',help='开发中规则验收才允许，最终整体验收不传入')
    parser.add_argument('--skip-exhaustive',action='store_true',help='规则已穷举通过后，只检查生命周期和交互回归')
    parser.add_argument('--case',help='仅执行一个已命名用例，便于针对性回归')
    args=parser.parse_args()
    out=Path(tempfile.mkdtemp(prefix='fimel-aeroplane-'));target=out/'packs/fimel_cards'
    shutil.copytree(PACK/'data',target/'data');shutil.copy2(PACK/'pack.mcmeta',target/'pack.mcmeta')
    (target/'data/minecraft/tags/function/tick.json').write_text('{"values":[]}',encoding='utf-8')
    stubbed=[]
    if args.allow_missing_visuals:
        refs=set()
        for path in (target/'data/aeroplane_chess/function').rglob('*.mcfunction'):
            refs.update(re.findall(r'function aeroplane_chess:((?:visual|sound)/[a-z_0-9/]+)',path.read_text(encoding='utf-8')))
        for ref in refs:
            path=target/'data/aeroplane_chess/function'/(ref+'.mcfunction')
            if not path.exists():path.parent.mkdir(parents=True,exist_ok=True);path.write_text('# isolated rule fixture stub\n',encoding='utf-8');stubbed.append(ref)
    for path in (target/'data/aeroplane_chess/function').rglob('*.mcfunction'):
        lines=[]
        for line in path.read_text(encoding='utf-8').splitlines():
            if not any(token in line for token in ['tellraw ','dialog ','title ','playsound ','input/give','input/clear','clear @s','give @s','item replace']):
                line=line.replace('@a[','@e[')
            lines.append(line)
        path.write_text('\n'.join(lines)+'\n',encoding='utf-8')
    # 哨兵写在真正的宏函数内。只有整条 dialog JSON 被原版解析成功才会执行。
    for name,score in [('settings/root_show','settings_compiled'),('ui/show','ui_compiled'),('ui/notice','ui_compiled')]:
        path=target/'data/aeroplane_chess/function'/(name+'.mcfunction')
        path.write_text(path.read_text(encoding='utf-8')+f'scoreboard players set #{score} ag 1\n',encoding='utf-8')
    for name,body in suite.files.items():
        dest=target/'data/aeroplane_test/function'/(name+'.mcfunction');dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(body,encoding='utf-8')
    for name,body in {'test_environment/default.json':{'type':'minecraft:function','setup':'aeroplane_test:bootstrap'},'test_instance/game.json':{'type':'minecraft:function','environment':'aeroplane_test:default','function':'minecraft:always_pass','max_ticks':1,'setup_ticks':len(suite.cases)+100,'required':True,'structure':'minecraft:empty'}}.items():
        dest=target/'data/aeroplane_test'/name;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(json.dumps(body),encoding='utf-8')
    launch=args.minecraft_root/'versions'/args.version/(args.version+'.json');meta=json.loads(launch.read_text(encoding='utf-8-sig'));cp=[launch.with_suffix('.jar')]
    for lib in meta['libraries']:
        entry=lib.get('downloads',{}).get('artifact',{});path=args.minecraft_root/'libraries'/entry.get('path','')
        if entry.get('path') and path.is_file():cp.append(path)
    options=['-Xms256M','-Xmx1536M','-Djava.awt.headless=true','-Dfile.encoding=UTF-8','--enable-native-access=ALL-UNNAMED','-cp',';'.join(map(str,cp)),'net.minecraft.gametest.Main','--packs',str(out/'packs'),'--universe',str(out/'universe'),'--tests','aeroplane_test:*','--report',str(out/'gametest.xml')]
    argfile=out/'java-args.txt';argfile.write_text('\n'.join('"'+v.replace('\\','\\\\').replace('"','\\"')+'"' for v in options),encoding='utf-8')
    print('Aeroplane GameTest: '+str(out),flush=True);start=time.monotonic()
    proc=subprocess.run([str(args.java),'@'+str(argfile)],cwd=out,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf-8',errors='replace',timeout=240)
    (out/'game.log').write_text(proc.stdout,encoding='utf-8')
    passed=set(re.findall(r'AEROPLANE_PASS ([a-z0-9_]+)',proc.stdout));failed=sorted(set(re.findall(r'AEROPLANE_FAIL ([a-z0-9_]+)',proc.stdout)))
    errors=[line for line in proc.stdout.splitlines() if any(s in line for s in ['[ERROR]','/ERROR]','Failed to load','Failed to parse','Unknown function','Unknown or incomplete command',"Couldn't parse",'Command execution stopped'])]
    result={'exit_code':proc.returncode,'seconds':round(time.monotonic()-start,1),'assertions':len(suite.expected),'passed':len(passed),'failed':failed,'missing':sorted(set(suite.expected)-passed),'errors':errors,'finished':'AEROPLANE_FINISHED' in proc.stdout,'stubbed':sorted(stubbed),'output':str(out)}
    (out/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(result,ensure_ascii=False,indent=2),flush=True)
    return int(bool(proc.returncode or failed or result['missing'] or errors or not result['finished']))


if __name__=='__main__':
    import sys
    suite=Suite();suite.build(exhaustive='--skip-exhaustive' not in sys.argv)
    if '--case' in sys.argv:
        case=sys.argv[sys.argv.index('--case')+1]
        if case not in suite.cases:raise SystemExit('Unknown test case: '+case)
        suite.cases=[case]
        suite.files['case/'+case]=re.sub(r'schedule function aeroplane_test:[a-z_0-9/]+ 1t', 'schedule function aeroplane_test:finish 1t', suite.files['case/'+case])
        suite.files['bootstrap']=re.sub(r'schedule function aeroplane_test:case/[a-z_0-9/]+ 2t',f'schedule function aeroplane_test:case/{case} 2t',suite.files['bootstrap'])
        suite.expected=re.findall(r'AEROPLANE_PASS ([a-z0-9_]+)',suite.files['case/'+case])
    raise SystemExit(run(suite))
