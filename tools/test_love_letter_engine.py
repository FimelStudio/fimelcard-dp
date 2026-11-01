"""独立原版 26.2 情书规则 GameTest；不启动或改动玩家世界。"""
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
TABLE = '@e[type=minecraft:marker,tag=lt.table,scores={ct_id=101},limit=1]'
OTHER = '@e[type=minecraft:marker,tag=lt.table,scores={ct_id=202},limit=1]'


def part(seat=1, table=101):
    return f'@e[type=minecraft:marker,tag=ll.part,scores={{ct_id={table},ll_seat={seat}}},limit=1]'


class Suite:
    def __init__(self):
        self.files, self.cases, self.expected = {}, [], []

    def file(self, name, lines):
        self.files[name] = ('\n'.join(lines) if isinstance(lines, list) else lines).strip()+'\n'

    def check(self, condition, name):
        assert name not in self.expected, name
        self.expected.append(name)
        return [f'execute if {condition} run say LOVELETTER_PASS {name}',
                f'execute unless {condition} run say LOVELETTER_FAIL {name}']

    def score(self, target, obj, value, name):
        return self.check(f'score {target} {obj} matches {value}', name)

    def data(self, target, path, value, name):
        return [f'data modify storage love_letter_test:run cmp set value {json.dumps(value,separators=(",",":"))}',
                f'execute store success score #source lt run data get entity {target} {path}',
                f'execute store success score #different lt run data modify storage love_letter_test:run cmp set from entity {target} {path}',
                'execute unless score #source lt matches 1 run scoreboard players set #different lt 1']+self.score('#different','lt',0,name)

    def count(self, selector, expected, name):
        return ['scoreboard players set #count lt 0', f'execute as {selector} run scoreboard players add #count lt 1']+self.score('#count', 'lt', expected, name)

    def call(self, name, table=101):
        return [f'execute as {TABLE if table==101 else OTHER} at @s run function love_letter:{name}']

    def setup(self, hands=(2,3,4), seats=None, extra=1, deck=(0,1,2,3,4,5,6,7,8,9), reserve=9, table=101, reset=True):
        seats = seats or tuple(range(1,len(hands)+1))
        lines = ['function love_letter_test:reset'] if reset else []
        lines += [f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:marker run function love_letter_test:table {{table:{table}}}',
                  f'data modify entity {TABLE if table==101 else OTHER} data.love_letter.deck set value {list(deck)}',
                  f'data modify entity {TABLE if table==101 else OTHER} data.love_letter.reserve set value {reserve}']
        for seat,hand in zip(seats,hands):
            lines += [f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:marker run function love_letter_test:part {{table:{table},seat:{seat},hand:{hand}}}']
        ctrl = TABLE if table==101 else OTHER
        lines += [f'scoreboard players set {ctrl} ll_turn {seats[0]}', f'scoreboard players set {part(seats[0],table)} ll_extra {extra}']
        return lines+self.call('system/context',table)

    def play(self, slot=0, actor=1):
        return [f'scoreboard players set #actor ll_ctx {actor}',f'scoreboard players set #slot ll_ctx {slot}']+self.call('engine/play')

    def target(self, target=2, actor=1):
        return [f'scoreboard players set #actor ll_ctx {actor}',f'scoreboard players set #target ll_ctx {target}']+self.call('engine/target')

    def case(self,name,lines):
        self.cases.append(name);self.file('case/'+name,lines)

    def prepare(self):
        self.file('reset',['kill @e[tag=lt.fixture]','scoreboard players set #after lt 0','scoreboard players set #await lt 0','scoreboard players set #round lt 0'])
        self.file('table','''
tag @s add lt.fixture
tag @s add lt.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
scoreboard players set @s ct_game 17
scoreboard players set @s ct_state 1
scoreboard players set @s ct_capacity 8
scoreboard players set @s ll_state 2
scoreboard players set @s ll_phase 1
scoreboard players set @s ll_anim 0
scoreboard players set @s ll_scored 0
scoreboard players set @s ll_first 0
scoreboard players set @s ll_actor 0
scoreboard players set @s ll_target 0
scoreboard players set @s ll_card -1
data modify entity @s data set value {love_letter:{deck:[],reserve:9,public:[],action:{eliminated:[]}},ll_private:{},ll_buffer:[]}
''')
        self.file('part','''
tag @s add lt.fixture
tag @s add ll.part
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ll_seat $(seat)
$scoreboard players set @s ll_hand $(hand)
scoreboard players set @s ll_extra -1
scoreboard players set @s ll_alive 1
scoreboard players set @s ll_protect 0
scoreboard players set @s ll_spy 0
scoreboard players set @s ll_points 0
scoreboard players set @s ll_won 0
scoreboard players set @s ll_bonus 0
data modify entity @s data set value {discards:[],ll_name:{text:"Test"}}
''')
        self.file('conservation','''
function love_letter:system/context
scoreboard players set #total lt 0
execute store result score #size lt run data get entity @s data.love_letter.deck
scoreboard players operation #total lt += #size lt
execute store result score #size lt run data get entity @s data.love_letter.public
scoreboard players operation #total lt += #size lt
execute store result score #reserve lt run data get entity @s data.love_letter.reserve
execute if score #reserve lt matches 0..9 run scoreboard players add #total lt 1
execute as @e[tag=ll.board] run function love_letter_test:conservation_part
execute store result score #size lt run data get entity @s data.ll_buffer
execute if score @s ll_phase matches 4 run scoreboard players remove #size lt 1
execute if score @s ll_phase matches 4..5 run scoreboard players operation #total lt += #size lt
''')
        self.file('conservation_part','''
execute if score @s ll_hand matches 0..9 run scoreboard players add #total lt 1
execute if score @s ll_extra matches 0..9 run scoreboard players add #total lt 1
execute store result score #size lt run data get entity @s data.discards
scoreboard players operation #total lt += #size lt
''')
        self.file('gather', '''
function love_letter:system/context
data modify storage love_letter_test:run cards set value []
data modify storage love_letter_test:run todo set from entity @s data.love_letter.deck
function love_letter_test:gather_list
data modify storage love_letter_test:run todo set from entity @s data.love_letter.public
function love_letter_test:gather_list
execute store result score #value lt run data get entity @s data.love_letter.reserve
function love_letter_test:gather_value
execute as @e[tag=ll.board] run function love_letter_test:gather_part
execute if score @s ll_phase matches 4..5 run data modify storage love_letter_test:run todo set from entity @s data.ll_buffer
execute if score @s ll_phase matches 4 run data remove storage love_letter_test:run todo[0]
execute if score @s ll_phase matches 4..5 run function love_letter_test:gather_list
''')
        self.file('gather_list','''
execute unless data storage love_letter_test:run todo[0] run return 0
data modify storage love_letter_test:run cards append from storage love_letter_test:run todo[0]
data remove storage love_letter_test:run todo[0]
execute if data storage love_letter_test:run todo[0] run function love_letter_test:gather_list
''')
        self.file('gather_value','''
execute unless score #value lt matches 0..9 run return 0
execute store result storage love_letter_test:run card int 1 run scoreboard players get #value lt
data modify storage love_letter_test:run cards append from storage love_letter_test:run card
''')
        self.file('gather_part','''
data modify storage love_letter_test:run todo set from entity @s data.discards
function love_letter_test:gather_list
scoreboard players operation #value lt = @s ll_hand
function love_letter_test:gather_value
scoreboard players operation #value lt = @s ll_extra
function love_letter_test:gather_value
''')
        self.file('roles',['function love_letter_test:gather']+[f'scoreboard players set #r{role} lt 0' for role in range(10)]+['function love_letter_test:count_role']+[f'execute unless score #r{role} lt matches {count} run scoreboard players set #broken lt 1' for role,count in enumerate((2,6,2,2,2,2,2,1,1,1))])
        self.file('count_role',['execute unless data storage love_letter_test:run cards[0] run return 0','execute store result score #value lt run data get storage love_letter_test:run cards[0]','data remove storage love_letter_test:run cards[0]']+[f'execute if score #value lt matches {role} run scoreboard players add #r{role} lt 1' for role in range(10)]+['execute if data storage love_letter_test:run cards[0] run function love_letter_test:count_role'])
        self.file('step','''
execute if score @s ll_phase matches 6 run return 0
execute if score @s ll_phase matches 0 run function love_letter_test:next_turn
execute if score @s ll_phase matches 6 run return 0
function love_letter:engine/auto
function love_letter_test:roles
execute if score @s ll_phase matches 0 run function love_letter:engine/check_round
''')
        self.file('next_turn','''
function love_letter:engine/check_round
execute if score #over ll_ctx matches 1 run return 0
scoreboard players operation #previous ll_ctx = @s ll_turn
scoreboard players set #next lt 99
scoreboard players set #first lt 99
execute as @e[tag=ll.board,scores={ll_alive=1}] run scoreboard players operation #first lt < @s ll_seat
execute as @e[tag=ll.board,scores={ll_alive=1}] if score @s ll_seat > #previous ll_ctx run scoreboard players operation #next lt < @s ll_seat
execute if score #next lt matches 99 run scoreboard players operation #next lt = #first lt
scoreboard players operation @s ll_turn = #next lt
function love_letter:engine/start_turn
''')

    def finish(self):
        objectives=[line for line in (PACK/'data/love_letter/function/load.mcfunction').read_text(encoding='utf-8').splitlines() if line.startswith('scoreboard objectives add ')]
        self.file('bootstrap',['forceload add 0 0 47 15','scoreboard objectives add lt dummy','scoreboard objectives add ct_id dummy','scoreboard objectives add ct_game dummy','scoreboard objectives add ct_state dummy','scoreboard objectives add ct_capacity dummy']+objectives+['function love_letter_test:reset',f'schedule function love_letter_test:case/{self.cases[0]} 2t'])
        self.file('finish','say LOVELETTER_FINISHED')
        for i,name in enumerate(self.cases):
            self.files['case/'+name]+='schedule function love_letter_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 1t\n'

    def build(self):
        self.prepare()
        for n in range(2,7):
            key=f'start_{n}'
            seats=(1,3,4,6,7,8)[:n]
            c=self.setup(hands=(0,)*n,seats=seats)+[f'scoreboard players set {TABLE} ll_first {seats[-1]}',f'scoreboard players set {part(seats[0])} ll_points 3']+self.call('engine/start_round')
            c+=self.score(TABLE,'ll_turn',seats[-1],key+'_specified_first')+self.score(part(seats[0]),'ll_points',3,key+'_points_preserved')
            c+=[f'execute store result score #len lt run data get entity {TABLE} data.love_letter.deck']+self.score('#len','lt',21-1-n-(3 if n==2 else 0),key+'_deck')
            c+=[f'execute as {TABLE} run function love_letter_test:conservation']+self.score('#total','lt',21,key+'_21_conserved')
            c+=self.count('@e[tag=ll.board,scores={ll_hand=0..9,ll_extra=-1,ll_alive=1}]',n,key+'_one_each')
            c+=self.call('engine/start_turn')+self.score(part(seats[-1]),'ll_extra','0..9',key+'_draws_extra')
            c+=[f'execute as {TABLE} run function love_letter_test:conservation']+self.score('#total','lt',21,key+'_after_draw_conserved')
            self.case(key,c)
        # 所有手牌组合下验证强制伯爵夫人；无效出牌完全不动手牌和牌库。
        for hand,extra,slot in itertools.product(range(10),range(10),range(2)):
            chosen=(hand,extra)[slot]
            forced=(hand==8 and extra in (5,7)) or (extra==8 and hand in (5,7))
            valid=not forced or chosen==8
            key=f'play_{hand}_{extra}_{slot}'
            c=self.setup((hand,4,2),extra=extra)+self.play(slot)
            c+=self.score('#ok','ll_ctx',int(valid),key+'_valid')
            if not valid:
                c+=self.score(part(),'ll_hand',hand,key+'_hand_kept')+self.score(part(),'ll_extra',extra,key+'_extra_kept')+self.data(part(),'data.discards',[],key+'_no_discard')
            else:
                c+=self.data(part(),'data.discards',[chosen]+([(hand,extra)[1-slot]] if chosen==9 else []),key+'_discard')
                if chosen not in (6,9):c+=self.score(part(),'ll_hand',(hand,extra)[1-slot],key+'_other_kept')
            self.case(key,c)
        for role,target_hand in itertools.product((1,2,3,5,7),range(10)):
            key=f'role_{role}_target_{target_hand}'
            c=self.setup((4,target_hand,2),extra=role)+self.play(1)+self.score(TABLE,'ll_phase',2,key+'_target_phase')+self.target()
            if role==1:
                c+=self.score(TABLE,'ll_phase',3,key+'_guess_phase')
                c+=['scoreboard players set #actor ll_ctx 1',f'scoreboard players set #guess ll_ctx {target_hand}']+self.call('engine/guess')
                if target_hand==1:
                    c+=self.score('#ok','ll_ctx',0,key+'_guard_cannot_guess_guard')+self.score(part(2),'ll_alive',1,key+'_guard_still_alive')
                else:
                    c+=self.score(part(2),'ll_alive',0,key+'_guard_eliminates')+self.data(part(2),'data.discards',[target_hand],key+'_guard_discards')
            elif role==2:
                c+=self.check(f'data entity {TABLE} data.ll_private{{kind:"priest",seat:1,target:2,actor_card:4,target_card:{target_hand}}}',key+'_private')+self.score(part(2),'ll_hand',target_hand,key+'_priest_does_not_change')
            elif role==3:
                c+=self.score(part(),'ll_alive',int(4>=target_hand),key+'_baron_actor')+self.score(part(2),'ll_alive',int(target_hand>=4),key+'_baron_target')
            elif role==5:
                c+=self.data(part(2),'data.discards',[target_hand],key+'_prince_discard')+self.score(part(2),'ll_alive',int(target_hand!=9),key+'_prince_princess')
                c+=self.score(part(2),'ll_hand',-1 if target_hand==9 else 0,key+'_prince_replacement')
            else:
                c+=self.score(part(),'ll_hand',target_hand,key+'_king_actor')+self.score(part(2),'ll_hand',4,key+'_king_target')
            self.case(key,c)
        for role in (1,2,3,5,7):
            key=f'protection_{role}'
            c=self.setup((role,9,3),extra=4)+[f'scoreboard players set {part(2)} ll_protect 1',f'scoreboard players set {part(3)} ll_protect 1']+self.play()
            c+=self.score(TABLE,'ll_phase',2 if role==5 else 0,key+'_no_unprotected_opponents')+self.target()
            c+=self.score('#ok','ll_ctx',0,key+'_protected_rejected')+self.score(part(2),'ll_alive',1,key+'_target_survives')
            if role==5:c+=self.target(1)+self.data(part(),'data.discards',[5,4],key+'_self_discard')
            self.case(key,c)
        c=self.setup((4,3,2),extra=1)+self.play()+self.score(part(),'ll_protect',1,'handmaid_protects')+[f'scoreboard players set {TABLE} ll_turn 1']+self.call('engine/start_turn')+self.score(part(),'ll_protect',0,'handmaid_expires_before_draw')
        self.case('handmaid_expiry',c)
        c=self.setup((5,2,3),extra=4,deck=(),reserve=7)+self.play()+self.target()+self.score(part(2),'ll_hand',7,'prince_empty_uses_reserve')+self.check(f'data entity {TABLE} data.love_letter{{reserve:-1}}','prince_reserve_used_once')
        self.case('prince_reserve',c)
        c=self.setup((5,2,3),extra=4,deck=(1,),reserve=7)+self.play()+self.target()+self.score(part(2),'ll_hand',1,'prince_ordinary_before_reserve')+self.check(f'data entity {TABLE} data.love_letter{{reserve:7}}','prince_reserve_untouched')
        self.case('prince_ordinary',c)
        c=self.setup((5,2,3),extra=9,deck=(),reserve=7)+self.play()+self.target(1)+self.score(part(),'ll_alive',0,'prince_self_princess_dies')+self.check(f'data entity {TABLE} data.love_letter{{reserve:7}}','prince_princess_no_replacement')+self.data(part(),'data.discards',[5,9],'prince_self_exact_discards')
        self.case('prince_princess_self',c)
        for deck in ((),(2,),(2,7),(2,7,9)):
            for keep in range(min(3,len(deck)+1)):
                key=f'chancellor_{len(deck)}_{keep}'
                c=self.setup((6,3,4),extra=8,deck=deck)+self.play()
                if not deck:
                    c+=self.score(TABLE,'ll_phase',0,key+'_empty_no_effect')+self.score(part(),'ll_hand',8,key+'_empty_keeps_hand')
                else:
                    candidates=[8]+list(deck[:2]);remain=candidates.copy();kept=remain.pop(keep)
                    c+=self.data(TABLE,'data.ll_buffer',candidates,key+'_candidate_buffer')+self.score(TABLE,'ll_phase',4,key+'_keep_phase')
                    c+=['scoreboard players set #actor ll_ctx 1',f'scoreboard players set #keep ll_ctx {keep}']+self.call('engine/keep')+self.score(part(),'ll_hand',kept,key+'_kept')
                    if len(remain)==2:
                        c+=self.score(TABLE,'ll_phase',5,key+'_order_phase')+['scoreboard players set #actor ll_ctx 1','scoreboard players set #bottom ll_ctx 1']+self.call('engine/bottom');remain.reverse()
                    c+=self.data(TABLE,'data.love_letter.deck',list(deck[2:])+remain,key+'_bottom_order')+self.data(TABLE,'data.ll_buffer',[],key+'_cleared_buffer')
                c+=self.check(f'data entity {TABLE} data.love_letter{{reserve:9}}',key+'_reserve_untouched')
                self.case(key,c)
        # 完整动作前牌库空不应提早结算大臣选择；恢复回底后仍有牌可继续。
        c=self.setup((6,3,4),extra=8,deck=(7,2))+self.play()+self.call('engine/check_round')+self.score('#over','ll_ctx',0,'chancellor_empty_waits_choice')
        c+=['scoreboard players set #actor ll_ctx 1','scoreboard players set #keep ll_ctx 1']+self.call('engine/keep')+['scoreboard players set #actor ll_ctx 1','scoreboard players set #bottom ll_ctx 0']+self.call('engine/bottom')+self.call('engine/check_round')+self.score('#over','ll_ctx',0,'chancellor_return_prevents_false_round_end')
        self.case('chancellor_round_timing',c)
        for a,b,cval in itertools.product(range(10),repeat=3):
            # 独立最高值判定，用三人全1000组覆盖并列和任意角色组合。
            key=f'score_{a}_{b}_{cval}'
            c=self.setup((a,b,cval),extra=-1,deck=())+self.call('engine/score_round')
            for seat,value in enumerate((a,b,cval),1):c+=self.score(part(seat),'ll_won',int(value==max(a,b,cval)),key+f'_p{seat}')
            c+=self.call('engine/score_round')
            for seat,value in enumerate((a,b,cval),1):c+=self.score(part(seat),'ll_points',int(value==max(a,b,cval)),key+f'_p{seat}_idempotent')
            self.case(key,c)
        for alive,spies in [((1,1,1),(1,0,0)),((1,1,1),(1,1,0)),((1,0,1),(1,1,0)),((1,0,1),(0,1,0)),((0,1,0),(1,1,1))]:
            key='spy_'+''.join(map(str,alive))+''.join(map(str,spies))
            c=self.setup((2,8,3),extra=-1,deck=())
            for seat,(living,spy) in enumerate(zip(alive,spies),1):c +=[f'scoreboard players set {part(seat)} ll_alive {living}',f'scoreboard players set {part(seat)} ll_spy {spy}']
            c+=self.call('engine/score_round')
            winners=max(v for v,living in zip((2,8,3),alive) if living)
            spy_count=sum(living and spy for living,spy in zip(alive,spies))
            for seat,(value,living,spy) in enumerate(zip((2,8,3),alive,spies),1):
                bonus=int(living and spy and spy_count==1)
                c+=self.score(part(seat),'ll_bonus',bonus,key+f'_p{seat}_bonus')+self.score(part(seat),'ll_won',int(living and value==winners),key+f'_p{seat}_winner')
            self.case(key,c)
        c=self.setup((2,3,4),extra=-1,deck=())+[f'scoreboard players set {TABLE} ll_phase 0']+self.call('engine/check_round')+self.call('engine/check_round')+self.score('#over','ll_ctx',1,'round_over_true')+self.score('#round','lt',1,'round_callback_once')+self.score(TABLE,'ll_phase',6,'round_phase_six')
        self.case('round_idempotent',c)
        c=self.setup((6,3,4),extra=8,deck=(2,7))+self.play()+['scoreboard players set #actor ll_ctx 1']+self.call('engine/resign')+self.data(TABLE,'data.love_letter.deck',[2,7],'resign_chancellor_draws_return')+self.data(part(),'data.discards',[6,8],'resign_chancellor_hand_once')
        self.case('resign_chancellor_keep',c)
        c=self.setup((6,3,4),extra=8,deck=(2,7))+self.play()+['scoreboard players set #actor ll_ctx 1','scoreboard players set #keep ll_ctx 1']+self.call('engine/keep')+['scoreboard players set #actor ll_ctx 1']+self.call('engine/resign')+self.data(TABLE,'data.love_letter.deck',[8,7],'resign_chancellor_remainder_return')+self.data(part(),'data.discards',[6,2],'resign_chancellor_selected_once')
        self.case('resign_chancellor_bottom',c)
        c=self.setup((1,3,4),extra=8)+self.play()+self.target()+['scoreboard players set #actor ll_ctx 2']+self.call('engine/resign')+self.score('#resume','ll_ctx',1,'resigning_guard_target_resolves_pending')+self.score(TABLE,'ll_phase',0,'resigning_guard_target_clears_phase')
        self.case('resign_target',c)
        c=self.setup((1,3,4),extra=8)+[f'scoreboard players set {part(3)} ll_protect 1']+self.play()+['scoreboard players set #actor ll_ctx 2']+self.call('engine/resign')+self.score('#resume','ll_ctx',1,'resigning_last_legal_target_resolves')+self.score(TABLE,'ll_phase',0,'resigning_last_legal_target_phase_zero')
        self.case('resign_last_legal_target',c)
        for phase in range(1,6):
            key=f'auto_{phase}'
            c=self.setup((6 if phase>=4 else 1,3,4),extra=8)+([] if phase==1 else self.play())
            if phase==3:c+=self.target()
            if phase==5:c+=['scoreboard players set #actor ll_ctx 1','scoreboard players set #keep ll_ctx 0']+self.call('engine/keep')
            c+=self.call('engine/auto')+self.score('#ok','ll_ctx',1,key+'_legal')
            self.case(key,c)
        c=self.setup((1,3,4),extra=8)+self.setup((7,8,9),table=202,reset=False)+self.play()+self.target()+['scoreboard players set #actor ll_ctx 1','scoreboard players set #guess ll_ctx 3']+self.call('engine/guess')
        c+=self.score(part(2,202),'ll_alive',1,'isolation_other_alive')+self.data(part(1,202),'data.discards',[],'isolation_other_discard')+self.data(OTHER,'data.love_letter.deck',list(range(10)),'isolation_other_deck')
        self.case('two_tables',c)
        for kind,change in [('actor',['scoreboard players set #actor ll_ctx 2']),('slot',['scoreboard players set #slot ll_ctx 3']),('animation',[f'scoreboard players set {TABLE} ll_anim 1']),('state',[f'scoreboard players set {TABLE} ll_state 3']),('phase',[f'scoreboard players set {TABLE} ll_phase 6'])]:
            c=self.setup((1,2,3),extra=9)+['scoreboard players set #actor ll_ctx 1','scoreboard players set #slot ll_ctx 0']+change+self.call('engine/play')+self.score('#ok','ll_ctx',0,'invalid_'+kind)+self.data(part(),'data.discards',[],'invalid_'+kind+'_no_mutation')
            self.case('invalid_'+kind,c)
        # 完整随机洗牌轮：每步逐角色核对 21 张，不仅核对总数；同一次运行保存可审阅日志。
        for players in range(2,7):
            for sample in range(4):
                key=f'round_{players}_{sample}'
                seats=(1,3,4,6,7,8)[:players]
                c=self.setup((0,)*players,seats=seats,extra=-1)+['scoreboard players set #broken lt 0']+self.call('engine/start_round')+self.call('engine/start_turn')
                self.case(key+'_init',c)
                for batch in range(4):
                    c=[f'execute as {TABLE} at @s run function love_letter_test:step']*20+self.score('#broken','lt',0,key+f'_batch{batch}_all_21_roles')
                    if batch==3:c+=self.score(TABLE,'ll_phase',6,key+'_terminates')+self.call('engine/score_round')+self.score(TABLE,'ll_winners','1..6',key+'_has_winner')
                    self.case(key+f'_batch{batch}',c)
        # 最后一名对手在大臣中间认输：立即轮终但所有抽牌安全归底。
        for phase in (4,5):
            key=f'resign_last_chancellor_{phase}'
            c=self.setup((6,3),extra=8,deck=(2,7))+self.play()
            if phase==5:c+=['scoreboard players set #actor ll_ctx 1','scoreboard players set #keep ll_ctx 1']+self.call('engine/keep')
            c+=['scoreboard players set #actor ll_ctx 2']+self.call('engine/resign')+self.call('engine/check_round')+self.score('#over','ll_ctx',1,key+'_over')+self.data(TABLE,'data.ll_buffer',[],key+'_buffer_returned')+self.data(TABLE,'data.love_letter.deck',[2,7] if phase==4 else [8,7],key+'_deck_restored')+self.score(part(),'ll_hand',8 if phase==4 else 2,key+'_survivor_keeps_hand')
            self.case(key,c)
        self.finish()


def run(suite, isolated=True, prefix='fimel-loveletter-', prepare_target=None):
    """可被完整生命周期测试复用；isolated=False 复制全包且不替换回调。"""
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--java',type=Path,default=Path('C:/Temp/fimel-uno-java25/jdk-25.0.5+8-jre/bin/java.exe'))
    parser.add_argument('--minecraft-root',type=Path,default=Path('D:/PCL2/MinecraftPcl'))
    parser.add_argument('--version',default='26.2-Fabric_0.19.3')
    parser.add_argument('--case')
    args=parser.parse_args()
    if args.case:
        name=args.case
        if name not in suite.cases:raise SystemExit('Unknown case: '+name)
        suite.cases=[name]
        suite.files['case/'+name]=re.sub(r'schedule function love_letter_test:[a-z_0-9/]+ 1t','schedule function love_letter_test:finish 1t',suite.files['case/'+name])
        suite.files['bootstrap']=re.sub(r'schedule function love_letter_test:case/[a-z_0-9/]+ 2t',f'schedule function love_letter_test:case/{name} 2t',suite.files['bootstrap'])
        suite.expected=re.findall(r'LOVELETTER_PASS ([a-z0-9_]+)',suite.files['case/'+name])
    out=Path(tempfile.mkdtemp(prefix=prefix));target=out/'packs/fimel_cards'
    if not isolated:shutil.copytree(PACK/'data',target/'data')
    else:
        shutil.copytree(PACK/'data/love_letter/function/engine',target/'data/love_letter/function/engine')
        ctx=target/'data/love_letter/function/system/context.mcfunction';ctx.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(PACK/'data/love_letter/function/system/context.mcfunction',ctx)
        for name,body in {'after_action':'scoreboard players add #after lt 1','await_choice':'scoreboard players add #await lt 1','round_over':'scoreboard players add #round lt 1'}.items():
            dest=target/'data/love_letter/function/game'/(name+'.mcfunction');dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(body+'\n',encoding='utf-8')
    shutil.copy2(PACK/'pack.mcmeta',target/'pack.mcmeta')
    tagdir=target/'data/minecraft/tags/function';tagdir.mkdir(parents=True,exist_ok=True)
    (tagdir/'tick.json').write_text('{"values":[]}',encoding='utf-8')
    if isolated:(tagdir/'load.json').write_text('{"values":[]}',encoding='utf-8')
    if prepare_target is not None:prepare_target(target)
    for name,body in suite.files.items():
        dest=target/'data/love_letter_test/function'/(name+'.mcfunction');dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(body,encoding='utf-8')
    for name,body in {'test_environment/default.json':{'type':'minecraft:function','setup':'love_letter_test:bootstrap'},'test_instance/game.json':{'type':'minecraft:function','environment':'love_letter_test:default','function':'minecraft:always_pass','max_ticks':1,'setup_ticks':len(suite.cases)+100,'required':True,'structure':'minecraft:empty'}}.items():
        dest=target/'data/love_letter_test'/name;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(json.dumps(body),encoding='utf-8')
    launch=args.minecraft_root/'versions'/args.version/(args.version+'.json');meta=json.loads(launch.read_text(encoding='utf-8-sig'));cp=[launch.with_suffix('.jar')]
    for lib in meta['libraries']:
        entry=lib.get('downloads',{}).get('artifact',{});path=args.minecraft_root/'libraries'/entry.get('path','')
        if entry.get('path') and path.is_file():cp.append(path)
    options=['-Xms256M','-Xmx1536M','-Djava.awt.headless=true','-Dfile.encoding=UTF-8','--enable-native-access=ALL-UNNAMED','-cp',';'.join(map(str,cp)),'net.minecraft.gametest.Main','--packs',str(out/'packs'),'--universe',str(out/'universe'),'--tests','love_letter_test:*','--report',str(out/'gametest.xml')]
    argfile=out/'java-args.txt';argfile.write_text('\n'.join('"'+v.replace('\\','\\\\').replace('"','\\"')+'"' for v in options),encoding='utf-8')
    print('Love Letter GameTest: '+str(out),flush=True);start=time.monotonic()
    proc=subprocess.run([str(args.java),'@'+str(argfile)],cwd=out,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf-8',errors='replace',timeout=300)
    (out/'game.log').write_text(proc.stdout,encoding='utf-8')
    passed=set(re.findall(r'LOVELETTER_PASS ([a-z0-9_]+)',proc.stdout));failed=sorted(set(re.findall(r'LOVELETTER_FAIL ([a-z0-9_]+)',proc.stdout)))
    errors=[line for line in proc.stdout.splitlines() if any(s in line for s in ['[ERROR]','/ERROR]','Failed to load','Failed to parse','Unknown function','Unknown or incomplete command',"Couldn't parse",'Command execution stopped'])]
    result={'exit_code':proc.returncode,'seconds':round(time.monotonic()-start,1),'assertions':len(suite.expected),'passed':len(passed),'failed':failed,'missing':sorted(set(suite.expected)-passed),'errors':errors,'finished':'LOVELETTER_FINISHED' in proc.stdout,'isolated':isolated,'output':str(out)}
    (out/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8')
    printable=dict(result);printable['missing']=printable['missing'][:25];printable['failed']=printable['failed'][:25]
    print(json.dumps(printable,ensure_ascii=False,indent=2),flush=True)
    return int(bool(proc.returncode or failed or result['missing'] or errors or not result['finished']))


if __name__=='__main__':
    suite=Suite();suite.build();raise SystemExit(run(suite))
