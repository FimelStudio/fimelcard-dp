# -*- coding: utf-8 -*-
"""Isolated vanilla 26.2 GameTests executing the shipped racing functions."""
from pathlib import Path
import json
import shutil
from test_catan_engine import Suite,TABLE,OTHER,run
PACK=Path(__file__).resolve().parents[1]
NS='magical_athlete'

class AthleteSuite(Suite):
    def call(self,name,table=101):return [f'execute as {TABLE if table==101 else OTHER} at @s run function {NS}:engine/{name}']
    def setup(self,n=4,table=101,reset=True):
        return (['kill @e[tag=ce.fixture]'] if reset else [])+[f'execute positioned {8 if table==101 else 40} 64 8 summon minecraft:marker run function catan_engine_test:table {{table:{table}}}',f'scoreboard players set #players ma_ctx {n}']+self.call('init',table)
    def set(self,path,value,table=101):return [f'data modify entity {TABLE if table==101 else OTHER} data.{NS}.{path} set value '+json.dumps(value,separators=(',',':'))]
    def data(self,path,value,name,table=101):return [f'execute store result score #value ce run data get entity {TABLE if table==101 else OTHER} data.{NS}.{path}']+self.score('#value','ce',value,name)
    def action(self,actor,code,target=-1,epoch=None,table=101):
        req=dict(actor=actor,code=code,target=target,epoch=epoch or -1)
        out=['data modify storage magical_athlete:action input set value '+json.dumps(req,separators=(',',':'))]
        if epoch is None:out +=[f'data modify storage magical_athlete:action input.epoch set from entity {TABLE if table==101 else OTHER} data.{NS}.epoch']
        return out+self.call('action',table)
    def snapshot(self,table=101):return [f'data modify storage magical_athlete:test saved set from entity {TABLE if table==101 else OTHER} data.{NS}']
    def unchanged(self,name,table=101):return [f'execute store success score #different ce run data modify storage magical_athlete:test saved set from entity {TABLE if table==101 else OTHER} data.{NS}']+self.score('#different','ce',0,name)
    def race(self,chars,positions=None,n=None):
        n=n or len(chars);r=[]
        for i in range(6):r.append(dict(owner=i+1,char=chars[i] if i<len(chars) else -1,power=chars[i] if i<len(chars) else -1,copy=-1,pos=(positions or [0]*6)[i] if i<len(chars) else 0,trip=0,status=0 if i<len(chars) else 2,first=1,prediction=-1,done=0))
        return self.setup(n)+self.set('phase',3)+self.set('turn',1)+self.set('racers',r)+self.set('queue',[])+self.set('pending',dict(kind='',owner=0,pawn=-1,options=[]))
    def job(self,kind,table=101,**kw):
        req=dict(type=kind,**kw)
        return self.call('context',table)+['data modify storage magical_athlete:engine s.queue append value '+json.dumps(req,separators=(',',':'))]+self.call('drain',table)+self.call('commit',table)
    def flush(self,times=10):return sum((self.call('pump') for _ in range(times)),[])
    def main(self,distance,die=0):return self.set('active',0)+self.set('pawn',0)+self.set('distance',distance)+self.set('dice',die)+self.set('start_pos',0)+self.job('main')+self.flush(20)
    def roll(self,die,prediction=0):return self.set('active',0)+self.set('pawn',0)+self.set('distance',die)+self.set('dice',die)+self.set('prediction',prediction)+self.job('roll_done')+self.flush(20)

def build_suite():
    s=AthleteSuite()
    def ok(n):return s.score('#ok','ma_ctx',1,n)
    def bad(name,a,code):return s.snapshot()+a+s.score('#ok','ma_ctx',0,name+'_reject')+s.score('#error','ma_ctx',code,name+'_error')+s.unchanged(name+'_atomic')
    for n in range(2,7):
        b=s.setup(n)+s.data('phase',1,f'init{n}_draft')+s.data('pool',8 if n==2 else n*2,f'init{n}_pool')+s.data('deck',28 if n==2 else 36-n*2,f'init{n}_remaining')+s.data('draft_order',8 if n==2 else n*2,f'init{n}_order')
        b+=['data modify storage magical_athlete:test cards set from entity '+TABLE+f' data.{NS}.pool','data modify storage magical_athlete:test cards append from entity '+TABLE+f' data.{NS}.deck[]']
        for c in range(36):b+=s.check(f'data storage magical_athlete:test {{cards:[{c}]}}',f'init{n}_unique{c}')
        s.case('init'+str(n),b)
    b=s.setup()+s.set('turn',1)+s.set('pool',[0,1,2,3,4,5,6,7])+s.set('draft_order',[1,2,3,4,4,3,2,1])+s.set('draft_at',0)
    b+=bad('draft_absent',s.action(1,1,35),8)+bad('draft_wrong',s.action(2,1,0),4)+bad('draft_stale',s.action(1,1,0,epoch=0),3)
    b+=s.action(1,1,0)+ok('draft_valid')+s.data('p1.hand[0]',0,'draft_get')+s.data('pool',7,'draft_remove')+s.data('turn',2,'draft_next')
    b+=bad('draft_reuse',s.action(2,1,0),8)
    s.case('draft_atomic',b)
    b=s.setup()+s.set('phase',2)+s.set('p1.hand',[0,1])+s.set('p2.hand',[2,3])+s.set('p3.hand',[4,5])+s.set('p4.hand',[6,7])
    b+=bad('lineup_absent',s.action(1,2,35),8)+s.action(1,2,0)+ok('lineup_one')+s.data('p1.hand',1,'lineup_removed')+s.data('p1.selected[0]',0,'lineup_secret')+bad('lineup_too_many',s.action(1,2,1),8)
    b+=s.action(2,2,2)+s.action(3,2,4)+s.action(4,2,6)+s.flush()+s.data('phase',3,'lineup_race')+s.data('racers[0].char',0,'lineup_revealed')+s.data('racers[3].char',6,'lineup_fourth')
    s.case('lineup',b)
    b=s.race([0,2,4],[2,4,8])+s.job('move',pawn=0,amount=5,source=-2)+s.flush()+s.data('racers[0].pos',7,'normal_move')+s.data('racers[0].trip',1,'banana_pass')
    b+=s.race([4,21,22],[2,4,5])+s.job('move',pawn=0,amount=5,source=-2)+s.flush()+s.data('racers[1].pos',2,'centaur_first')+s.data('racers[2].pos',3,'centaur_second')
    b+=s.race([2,21,22],[0,0,0])+s.job('move',pawn=1,amount=1,source=-2)+s.flush()+s.data('racers[1].trip',0,'banana_equal_not_pass')
    s.case('passing',b)
    b=s.race([0,2,2],[2,4,12])+s.job('move',pawn=0,amount=5,source=-2)
    b+=s.check(f'data entity {TABLE} data.magical_athlete{{events:[{{kind:3,pawn:0,source:2,source_actor:1}}]}}','banana_event_keeps_actual_source')
    b+=s.race([4,21,22],[2,4,5])+s.job('move',pawn=0,amount=5,source=-2)
    b+=['scoreboard players set #source_found ce 0']
    for _ in range(3):
        b+=[f'execute if data entity {TABLE} data.magical_athlete{{events:[{{kind:1,pawn:1,source:4,source_actor:0}}]}} run scoreboard players set #source_found ce 1']+s.call('pump')
    b+=s.score('#source_found','ce',1,'centaur_event_keeps_actual_source')
    s.case('ability_source_metadata',b)
    b=s.race([21,22,23],[5,2,8])+s.set('track',1)+s.job('move',pawn=0,amount=2,source=-2)+s.flush()+s.data('racers[0].pos',10,'wild_arrow')
    b+=s.race([21,22,23],[0,2,8])+s.set('track',1)+s.job('move',pawn=0,amount=1,source=-2)+s.flush()+s.data('p1.points',1,'wild_star')
    b+=s.race([21,22,23],[4,2,8])+s.set('track',1)+s.job('move',pawn=0,amount=1,source=-2)+s.flush()+s.data('racers[0].trip',1,'wild_trip')
    b+=s.race([16,21,22],[10,7,1])+s.job('move',pawn=1,amount=3,source=-2)+s.flush()+s.data('racers[1].pos',9,'baby_redirect')
    b+=s.race([20,21,22],[1,2,3])+s.job('move',pawn=0,amount=2,source=-2)+s.flush()+s.data('racers[0].pos',5,'leap_skip_two')
    b+=s.race([20,21,22],[6,4,3])+s.job('move',pawn=0,amount=-2,source=-2)+s.flush()+s.data('racers[0].pos',2,'leap_backward')
    s.case('track_and_geometry',b)
    b=s.race([32,21,22],[5,28,3])+s.job('move',pawn=1,amount=3,source=-2)+s.flush()+s.data('racers[1].pos',28,'stickler_overshoot_blocks')+s.data('finishers',0,'stickler_no_win')
    b+=s.job('move',pawn=1,amount=2,source=-2)+s.flush()+s.data('finishers[0]',1,'stickler_exact')+s.data('p2.points',3,'first_gold_three')
    b+=s.job('move',pawn=2,amount=30,source=-2)+s.flush()+s.data('racers[2].pos',3,'stickler_extra_block')
    b+=s.race([21,22,23],[28,29,1])+s.job('move',pawn=0,amount=3,source=-2)+s.flush()+s.data('p1.points',3,'gold_first')+s.job('move',pawn=1,amount=1,source=-2)+s.flush()+s.data('p2.points',1,'silver_first')+s.data('phase',4,'second_ends')+s.data('queue',0,'end_cancels_queue')
    b+=s.action(1,5)+ok('continue_race')+s.data('round',2,'second_round')+s.data('track',1,'alternating_wild')+s.data('phase',2,'next_lineup')
    s.case('finish',b)
    b=s.race([25,21,22],[2,5,12])+s.job('move',pawn=0,amount=3,source=-2)+s.flush()+s.data('racers[1].status',2,'mouth_eliminates')+s.data('eliminated[0]',1,'mouth_order')
    b+=s.race([1,21,22],[5,2,12])+s.job('move',pawn=1,amount=3,source=-2)+s.flush()+s.data('racers[1].trip',1,'baba_trip')
    b+=s.race([28,21,22],[1,2,5])+s.job('move',pawn=1,amount=3,source=-2)+s.flush()+s.data('racers[0].pos',3,'romantic_pair')
    b+=s.race([33,21,22],[2,2,8])+s.job('move',pawn=1,amount=3,source=-2)+s.data('pending.owner',1,'follower_owner')+s.check(f'data entity {TABLE} data.{NS}.pending{{kind:"suckerfish"}}','follower_choice')+s.action(1,4,1)+s.flush()+s.data('racers[0].pos',5,'follower_moves')+s.data('racers[1].pos',5,'followed_moves')
    s.case('landing_powers',b)
    b=s.race([21,22,23])+[f'scoreboard players set {TABLE} ct_paused 1']+bad('pause_lock',s.action(1,3,0),13)
    b+=s.setup(3)+s.setup(4,table=202,reset=False)+s.snapshot(202)+s.set('turn',1)+s.action(1,1,35)+s.unchanged('other_table_unchanged',202)
    s.case('pause_isolation',b)
    add_skills(s)
    add_loop_and_two_player(s)
    add_match(s)
    s.finish();return s

def add_skills(s):
    def ok(n):return s.score('#ok','ma_ctx',1,n)
    b=s.race([0,21,22],[1,10,20])+s.set('active',0)+s.set('pawn',0)+s.set('dice',2)+s.job('roll_accept')+s.check(f'data entity {TABLE} data.{NS}.pending{{kind:"alchemist"}}','alchemist_choice')+s.action(1,4,1)+s.flush()+s.data('racers[0].pos',5,'alchemist_four')
    b+=s.race([3,21,22],[0,10,20])+s.main(2,2)+s.data('racers[0].pos',5,'blimp_early')
    b+=s.race([3,21,22],[16,10,20])+s.set('start_pos',16)+s.set('active',0)+s.set('distance',2)+s.job('main')+s.flush()+s.data('racers[0].pos',17,'blimp_late')
    b+=s.race([21,13,6],[0,0,0])+s.main(5)+s.data('racers[0].pos',5,'coach_and_gunk')
    b+=s.race([14,21,22],[10,4,3])+s.action(1,3,0)+s.flush()+s.data('racers[0].pos',10,'hare_sits')+s.data('turn',2,'hare_passes_turn')+s.data('p1.points',0,'hare_no_old_bonus')
    b+=s.race([14,21,22],[0,10,20])+s.main(2,2)+s.data('racers[0].pos',4,'hare_bonus')
    b+=s.race([21,13,29],[0,5,10])+s.main(5)+s.data('racers[0].pos',4,'gunk_minus_one')+s.data('racers[2].pos',12,'scooch_for_gunk_and_legs')
    s.case('main_modifiers',b)
    b=s.race([7,21,22],[10,5,1])+s.call('context')+s.call('powers')+s.score('#p0','ma_ctx',-1,'copy_sole_lead_none')
    b+=s.set('racers[1].pos',20)+s.call('context')+s.call('powers')+s.score('#p0','ma_ctx',21,'copy_unique_legs')
    b+=s.race([7,21,22],[0,5,5])+s.job('pre')+s.data('pending.owner',1,'copy_tie_owner')+s.check(f'data entity {TABLE} data.{NS}.pending{{kind:"copycat",options:[1,2]}}','copy_tie_options')+s.action(1,4,2)+s.call('context')+s.call('powers')+s.score('#p0','ma_ctx',22,'copy_tie_choice')
    b+=s.race([10,21,22])+s.set('deck',[21,30,35,1,2])+s.job('prerace',pawn=0)+s.data('pending.options',3,'egg_three')+s.data('deck',2,'egg_removes_three')+s.action(1,4,30)+s.flush()+s.data('racers[0].power',30,'egg_inherits')+s.data('p1.points',4,'egg_prerace_sisyphus')
    b+=s.race([35,21,22])+s.set('history',[30,14])+s.job('prerace',pawn=0)+s.action(1,4,30)+s.flush()+s.data('racers[0].power',30,'twin_inherits')+s.data('p1.points',4,'twin_prerace')
    s.case('copy_egg_twin',b)
    b=s.race([5,21,22],[0,0,10])+s.set('active',0)+s.job('cheer')+s.flush()+s.data('racers[0].pos',3,'cheer_self_two_then_one')+s.data('racers[1].pos',2,'cheer_all_last')
    b+=s.race([5,28,22],[10,0,0])+s.set('active',0)+s.job('cheer')+s.flush()+s.data('racers[1].pos',2,'cheer_simultaneous_no_romance')+s.data('racers[2].pos',2,'cheer_simultaneous_other')
    b+=s.race([26,28,22],[10,4,4])+s.set('active',0)+s.job('party')+s.flush()+s.data('racers[1].pos',5,'party_simultaneous_no_romance')+s.data('racers[2].pos',5,'party_both_move')
    b+=s.race([26,28,22],[5,4,6])+s.set('active',0)+s.job('party')+s.flush()+s.data('racers[1].pos',5,'party_joins_from_both_sides')
    b+=s.race([17,21,22],[4,15,20])+s.set('racers[0].trip',1)+s.action(1,3,0)+s.check(f'data entity {TABLE} data.{NS}.pending{{kind:"hypnotist"}}','tripped_hypnotist_keeps_power')+s.action(1,4,1)+s.flush()+s.data('racers[1].pos',4,'hypnotist_pulls')+s.data('racers[0].trip',0,'tripped_hypnotist_recovers')+s.data('racers[0].pos',4,'tripped_hypnotist_no_roll')
    b+=s.race([34,21,22],[0,5,5])+s.set('racers[0].trip',1)+s.action(1,3,0)+s.action(1,4,5)+s.flush()+s.data('racers[0].pos',5,'thirdwheel_warp')+s.data('racers[0].trip',0,'thirdwheel_recovery')
    b+=s.race([11,21,22],[2,15,20])+s.action(1,3,0)+s.action(1,4,1)+s.flush()+s.data('racers[0].pos',15,'flip_self')+s.data('racers[1].pos',2,'flip_other')+s.data('turn',2,'flip_no_main_after')
    s.case('before_main_and_simultaneous',b)
    b=s.race([12,21,22],[0,10,20])+s.roll(3,3)+s.data('forced',0,'genius_extra')+s.data('turn',1,'genius_turn_owner')
    b+=s.race([21,18,19],[2,10,20])+s.roll(1)+s.data('racers[0].pos',2,'worm_cancels_main')+s.data('racers[1].pos',11,'worm_advances')
    b+=s.race([21,19,22],[2,10,20])+s.roll(6)+s.data('racers[0].pos',8,'six_main')+s.data('racers[1].pos',12,'lackey_two')
    b+=s.race([30,21,22],[15,10,20])+s.job('prerace',pawn=0)+s.data('p1.points',4,'sisyphus_starts_four')+s.roll(6)+s.data('racers[0].pos',0,'sisyphus_home')+s.data('p1.points',3,'sisyphus_loses_one')
    b+=s.race([22,21,23],[0,10,20])+s.set('racers[0].trip',1)+s.action(1,3,0)+s.flush()+s.data('p1.points',1,'loser_scores_when_tripped')+s.data('racers[0].trip',0,'loser_recovers')
    b+=s.race([21,15,22],[0,10,20])+s.set('racers[0].trip',1)+s.action(1,3,0)+s.flush()+s.data('racers[1].pos',12,'heckler_recovery')
    b+=s.race([12,31,22],[0,10,20])+s.roll(1,1)+s.data('turn',2,'skipper_beats_genius')+s.data('forced',1,'skipper_forced')
    s.case('dice_triggers',b)
    b=s.race([27,21,22],[0,10,20])+s.set('active',0)+s.set('dice',4)+s.job('roll_accept')+s.action(1,4,1)+s.flush()+s.data('racers[0].pos',8,'rocket_double')+s.data('racers[0].trip',1,'rocket_trip')
    b+=s.race([23,21,22],[0,10,20])+s.set('active',0)+s.set('dice',2)+s.call('context')+s.call('powers')+s.call('roll_offer')+s.call('commit')+s.action(1,4,1)+s.data('rerolls',1,'magician_first_reroll')+s.action(1,4,1)+s.flush()+s.data('rerolls',2,'magician_two_rerolls')+s.data('turn',2,'magician_resolves_once')
    b+=s.race([21,8,22],[0,10,20])+s.set('active',0)+s.set('dice',2)+s.call('context')+s.call('powers')+s.call('roll_offer')+s.call('commit')+s.action(1,4,1)+s.flush()+s.data('racers[1].pos',11,'dicemonger_moves_before')+s.check(f'data entity {TABLE} data.{NS}{{used_merchants:[1]}}','dicemonger_allowance_used')
    b+=s.race([9,21,22],[5,2,20])+s.job('move',pawn=1,amount=3,source=-2)+s.flush()+s.check(f'data entity {TABLE} data.{NS}.pending{{kind:"duel",owner:1,options:[-1,1]}}','duel_reactive_offer')+s.action(1,4,1)+s.flush()+s.data('racers[0].pos','5..7','duel_a_bounded')+s.data('racers[1].pos','5..7','duel_b_bounded')
    s.case('optional_dice_powers',b)
    b=s.race([24,21,22],[0,28,20])+s.action(1,3,0)+s.action(1,4,1)+s.flush()+s.job('move',pawn=1,amount=2,source=-2)+s.flush()+s.data('phase',4,'mastermind_ends_on_prediction')+s.data('p1.points',1,'mastermind_silver')+s.data('p2.points',3,'mastermind_predicted_gold')
    b+=s.race([24,21,22],[28,2,3])+s.set('racers[0].prediction',0)+s.job('move',pawn=0,amount=2,source=-2)+s.flush()+s.data('p1.points',4,'mastermind_self_both')+s.data('finishers',2,'mastermind_two_awards')
    b+=s.race([24,21,22],[0,28,20])+s.set('racers[0].prediction',1)+s.set('racers[0].status',2)+s.job('move',pawn=1,amount=2,source=-2)+s.flush()+s.data('phase',3,'eliminated_mastermind_inactive')+s.data('p1.points',0,'eliminated_mastermind_no_award')
    b+=s.race([25,21,22],[2,5,5])+s.job('move',pawn=0,amount=3,source=-2)+s.flush()+s.data('racers[1].status',0,'mouth_not_two')+s.data('racers[2].status',0,'mouth_not_two_other')
    b+=s.race([16,2,22],[2,5,10])+s.job('move',pawn=0,amount=3,source=-2)+s.flush()+s.data('racers[0].trip',1,'baby_passes_displaced_banana')
    b+=s.race([16,21,22],[10,2,20])+s.job('warp',pawn=1,to=10,source=17)+s.flush()+s.data('racers[1].pos',9,'warp_stops_behind_baby')
    b+=s.race([16,21,22],[10,2,20])+s.job('warp',pawn=0,to=2,source=17)+s.flush()+s.data('racers[1].pos',1,'warped_baby_displaces_occupant')
    b+=s.race([5,32,21],[29,29,29])+s.set('active',0)+s.job('cheer')+s.flush()+s.data('racers[2].pos',29,'cheer_obeys_stickler')
    b+=s.race([5,20,22],[5,0,1])+s.set('active',0)+s.job('cheer')+s.flush()+s.data('racers[1].pos',3,'cheer_obeys_leaptoad')
    s.case('end_and_special_cases',b)
    b=s.race([21,22,23,31],n=2)+s.set('racers[0].owner',1)+s.set('racers[1].owner',1)+s.set('racers[2].owner',2)+s.set('racers[3].owner',2)
    b+=s.snapshot()+s.action(1,3,1)+s.score('#ok','ma_ctx',0,'two_player_fixed_order_reject')+s.unchanged('two_player_order_atomic')
    b+=s.roll(1)+s.data('turn',2,'two_player_skip_owner')+s.data('forced',3,'two_player_skip_pawn')+s.set('active',3)+s.set('start_pos',0)+s.job('turn_end')+s.flush()+s.data('turn',1,'skipper_circle_next_owner')+s.data('forced',0,'skipper_circle_next_pawn')
    s.case('two_player_circle',b)

def add_loop_and_two_player(s):
    b=s.setup(2)+s.set('turn',1)+s.set('draft_first',1)+s.set('pool',list(range(8)))+s.set('deck',list(range(8,36)))+s.set('draft_order',[1,2,2,1,1,2,2,1])
    for char,actor in enumerate([1,2,2,1,1,2,2,1]):b +=s.action(actor,1,char)
    b+=s.data('draft_batch',2,'two_player_second_batch')+s.data('turn',2,'two_player_second_starts_b')+s.data('pool[0]',8,'two_player_second_pool')
    for char,actor in zip(range(8,16),[2,1,1,2,2,1,1,2]):b +=s.action(actor,1,char)
    b+=s.data('phase',2,'two_player_draft_complete')+s.data('p1.hand',8,'two_player_a_eight')+s.data('p2.hand',8,'two_player_b_eight')+s.data('deck',20,'two_player_twenty_unused')
    s.case('two_player_full_draft',b)
    b=s.race([29,16,22],[9,10,20])+s.job('move',pawn=0,amount=1,source=29)+s.flush(20)+s.data('racers[0].pos',9,'stationary_loop_position')+s.data('queue',0,'stationary_loop_drained')+s.data('loop',1,'stationary_loop_detected')
    s.case('stationary_loop',b)
    # A progress-producing Scoocher/Suckerfish sequence is expressly not an
    # infinite loop. Accept the off-turn follow prompt until both cross Finish.
    body=s.race([29,33,22],[0,0,20])+s.job('move',pawn=0,amount=1,source=29)+['scoreboard players set #chain_ticks ce 0','schedule function catan_engine_test:wait/follow_chain 1t']
    s.case('follow_chain',body);s.waiting.add('follow_chain')
    tick=['scoreboard players add #chain_ticks ce 1',f'execute if data entity {TABLE} data.{NS}.pending{{kind:"suckerfish"}} run function catan_engine_test:auto/follow',f'execute unless data entity {TABLE} data.{NS}.pending.options[0] if data entity {TABLE} data.{NS}.queue[0] run execute as {TABLE} at @s run function magical_athlete:engine/pump',f'execute unless data entity {TABLE} data.{NS}{{phase:4}} if score #chain_ticks ce matches ..499 run return run schedule function catan_engine_test:wait/follow_chain 1t','function catan_engine_test:done/follow_chain']
    s.file('wait/follow_chain',tick)
    s.file('auto/follow',['data modify storage magical_athlete:action input set value {actor:2,code:4,target:1,epoch:0}',f'data modify storage magical_athlete:action input.epoch set from entity {TABLE} data.{NS}.epoch']+s.call('action'))
    s.file('done/follow_chain',s.score('#chain_ticks','ce','..499','follow_chain_bounded')+s.data('phase',4,'follow_chain_two_finish')+s.data('finishers',2,'follow_chain_both_awarded')+s.data('racers[0].pos',30,'follow_chain_scooch_finish')+s.data('racers[1].pos',30,'follow_chain_fish_finish')+s.data('loop',0,'follow_chain_not_loop'))

def add_match(s):
    # A complete four-race tournament uses only real public actions. Fixtures
    # control the initial deck only, never race positions, scores or phases.
    body=s.setup(3)+s.set('pool',[3,6,13,14,19,18])+s.set('deck',[21,22,29,2,4,27]+list(range(30,36)))+s.set('draft_order',[1,2,3,3,2,1])+s.set('draft_first',1)+s.set('turn',1)+['scoreboard players set #match_ticks ce 0','schedule function catan_engine_test:wait/full_match 1t']
    s.case('full_match',body);s.waiting.add('full_match')
    tick=['scoreboard players add #match_ticks ce 1',f'execute store result score #match_phase ce run data get entity {TABLE} data.{NS}.phase',f'execute if score #match_phase ce matches 1 run function catan_engine_test:auto/draft',f'execute if score #match_phase ce matches 2 run function catan_engine_test:auto/lineup',f'execute if score #match_phase ce matches 3 run function catan_engine_test:auto/race',f'execute if score #match_phase ce matches 4 run function catan_engine_test:auto/continue',f'execute unless data entity {TABLE} data.{NS}{{phase:5}} if score #match_ticks ce matches ..4999 run return run schedule function catan_engine_test:wait/full_match 1t','function catan_engine_test:done/full_match']
    s.file('wait/full_match',tick)
    s.file('auto/send',[f'data modify storage magical_athlete:action input.epoch set from entity {TABLE} data.{NS}.epoch']+s.call('action'))
    s.file('auto/draft',['data modify storage magical_athlete:action input set value {actor:0,code:1,target:-1,epoch:0}',f'data modify storage magical_athlete:action input.actor set from entity {TABLE} data.{NS}.turn',f'data modify storage magical_athlete:action input.target set from entity {TABLE} data.{NS}.pool[0]','function catan_engine_test:auto/send'])
    lineup=[]
    for p in range(1,4):
        lineup +=[f'execute unless data entity {TABLE} data.{NS}.p{p}.selected[0] run return run function catan_engine_test:auto/lineup{p}']
        s.file('auto/lineup'+str(p),[f'data modify storage magical_athlete:action input set value {{actor:{p},code:2,target:-1,epoch:0}}',f'data modify storage magical_athlete:action input.target set from entity {TABLE} data.{NS}.p{p}.hand[0]','function catan_engine_test:auto/send'])
    s.file('auto/lineup',lineup)
    s.file('auto/race',[f'execute if data entity {TABLE} data.{NS}.pending.options[0] run return run function catan_engine_test:auto/choice',f'execute if data entity {TABLE} data.{NS}.queue[0] run return run execute as {TABLE} at @s run function magical_athlete:engine/pump','data modify storage magical_athlete:action input set value {actor:0,code:3,target:0,epoch:0}',f'data modify storage magical_athlete:action input.actor set from entity {TABLE} data.{NS}.turn',f'execute store result score #start_turn ce run data get entity {TABLE} data.{NS}.turn','scoreboard players remove #start_turn ce 1','execute store result storage magical_athlete:action input.target int 1 run scoreboard players get #start_turn ce',f'execute store result score #forced ce run data get entity {TABLE} data.{NS}.forced',f'execute if score #forced ce matches 0..5 run data modify storage magical_athlete:action input.target set from entity {TABLE} data.{NS}.forced','function catan_engine_test:auto/send'])
    s.file('auto/choice',['data modify storage magical_athlete:action input set value {actor:0,code:4,target:0,epoch:0}',f'data modify storage magical_athlete:action input.actor set from entity {TABLE} data.{NS}.pending.owner',f'data modify storage magical_athlete:action input.target set from entity {TABLE} data.{NS}.pending.options[0]','function catan_engine_test:auto/send'])
    s.file('auto/continue',['data modify storage magical_athlete:action input set value {actor:1,code:5,target:-1,epoch:0}','function catan_engine_test:auto/send'])
    done=s.score('#match_ticks','ce','..4999','full_match_bounded')+s.data('phase',5,'full_match_complete')+s.data('round',4,'full_match_four_races')+s.data('history',4,'full_match_four_champions')+s.data('winners','1..3','full_match_winners')
    for p in range(1,4):done +=s.data(f'p{p}.hand',0,f'full_match_p{p}_all_used')+s.data(f'p{p}.points','0..100',f'full_match_p{p}_points')
    done +=['scoreboard players set #all_points ce 0']
    for p in range(1,4):done +=[f'execute store result score #point ce run data get entity {TABLE} data.{NS}.p{p}.points','scoreboard players operation #all_points ce += #point ce']
    done +=s.score('#all_points','ce','28..100','full_match_rewards_persist')
    s.file('done/full_match',done)

def prepare(target):
    shutil.copytree(PACK/'data/magical_athlete/function/engine',target/'data/magical_athlete/function/engine',dirs_exist_ok=True)
    p=target/'data/minecraft/tags/function/load.json';p.write_text(json.dumps({'values':['magical_athlete:engine/install','catan_engine_test:extra']}),encoding='utf-8')
    p=target/'data/catan_engine_test/function/extra.mcfunction';p.write_text('scoreboard objectives add ct_paused dummy\nscoreboard objectives add ma_draft dummy\nscoreboard objectives add ma_track dummy\n',encoding='utf-8')

if __name__=='__main__':raise SystemExit(run(build_suite(),prepare_target=prepare,prefix='fimel-magical-athlete-engine-',setup_ticks=12000))
