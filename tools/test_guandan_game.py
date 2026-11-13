"""原版26.2掼蛋生命周期：108张守恒、贡还、接风、升级、恢复及两桌隔离。"""
from pathlib import Path
import itertools
from test_guandan_cards import Suite as CardSuite, PACK, TABLE, OTHER, run


def part(seat=1,table=101):
    return f'@e[type=minecraft:marker,tag=gd.part,scores={{ct_id={table},gd_seat={seat}}},limit=1]'


def person(seat=1,table=101):
    return f'@e[type=minecraft:armor_stand,tag=gt.person,scores={{ct_id={table},ct_seat={seat}}},limit=1]'


def card(value,table=101):
    return f'@e[type=minecraft:marker,tag=gd.card,scores={{ct_id={table},gd_id={value}}},limit=1]'


def prepare_target(target):
    # 仅拓宽服务端玩家状态筛选以支持替身，客户端 Dialog/title/音频仍保留真实玩家命令。
    paths=list((target/'data/guandan/function').rglob('*.mcfunction'))
    paths+=list((target/'data/cardtable/function/animation/deal').rglob('*.mcfunction'))
    paths+=[target/'data/cardtable/function/game/return_lobby.mcfunction']
    for path in paths:
        out=[]
        for line in path.read_text(encoding='utf-8').splitlines():
            if not any(word in line for word in ('tellraw ','dialog ','title ','playsound ','clear @s','give @s','item replace ')):
                line=line.replace('@a[','@e[')
            out.append(line)
        path.write_text('\n'.join(out)+'\n',encoding='utf8')


class Suite(CardSuite):
    def prepare(self):
        self.file('reset','''
kill @e[tag=gt.fixture]
kill @e[tag=gd.part]
kill @e[tag=gd.card]
kill @e[tag=gd.visual]
kill @e[tag=gd.firework]
kill @e[tag=ct.seat]
kill @e[tag=ct.menu]
kill @e[tag=ct.vote]
kill @e[tag=ct.dealt_card]
kill @e[tag=ct.new_dealt_card]
''')
        self.file('table','''
tag @s add gt.fixture
tag @s add gt.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_capacity $(cap)
$scoreboard players set @s ct_joined $(joined)
scoreboard players set @s ct_game 18
scoreboard players set @s ct_state 0
scoreboard players set @s ct_start 0
data merge entity @s {data:{cardtable:{menu_version:18,rules_version:5,chairs_version:1,vote_version:1}}}
function cardtable:table/ensure_seats
function guandan:game/init_table
scoreboard players set @s gd_pair 0
''')
        self.file('person','''
tag @s add gt.fixture
tag @s add gt.person
tag @s add ct.player
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_seat $(seat)
scoreboard players set @s ct_online 1
$data merge entity @s {NoGravity:1b,Invulnerable:1b,CustomName:{text:"测试$(seat)"}}
''')
        self.file('conservation','''
function guandan:system/context
scoreboard players set #total gt 0
scoreboard players set #invalid gt 0
execute as @e[tag=gd.cards] run scoreboard players add #total gt 1
execute as @e[tag=gd.cards] unless score @s gd_id matches 0..107 run scoreboard players add #invalid gt 1
execute as @e[tag=gd.cards] unless score @s gd_type matches 0..53 run scoreboard players add #invalid gt 1
execute as @e[tag=gd.board] run function guandan_test:count_part
''')
        self.file('count_part','''
scoreboard players operation #who gt = @s gd_seat
scoreboard players set #own gt 0
execute as @e[tag=gd.cards] if score @s gd_owner = #who gt run scoreboard players add #own gt 1
execute unless score @s gd_count = #own gt run scoreboard players add #invalid gt 1
''')
        self.file('auto_step','''
execute unless score @s gd_state matches 3 run return 0
scoreboard players set @s gd_anim 0
function guandan:clock/timeout
function guandan_test:conservation
execute unless score #total gt matches 108 run scoreboard players add #broken gt 1
execute unless score #invalid gt matches 0 run scoreboard players add #broken gt 1
''')

    def setup_game(self,cap=4,seats=(1,2,3,4),table=101,reset=True,claimed=None):
        c=['function guandan_test:reset'] if reset else []
        x=8.0 if table==101 else 40.0
        c +=[f'execute positioned {x} 64.0 8.0 summon minecraft:marker run function guandan_test:table {{table:{table},cap:{cap},joined:{len(seats) if claimed is None else claimed}}}']
        c +=[f'execute positioned {x} 64.0 8.0 summon minecraft:armor_stand run function guandan_test:person {{table:{table},seat:{seat}}}' for seat in seats]
        return c

    def start(self,table=101):
        ctrl=TABLE if table==101 else OTHER
        return self.call('game/start',table)+[f'execute if score {ctrl} ct_start matches 1 run scoreboard players set {ctrl} ct_state 1']

    def deal_ticks(self,n=224,table=101):return self.call('deal/tick',table)*n

    def playable(self,cap=4,seats=(1,2,3,4),table=101,reset=True):
        return self.setup_game(cap,seats,table,reset)+self.start(table)+self.deal_ticks(224,table)

    def fixture_hands(self,hands,table=101):
        ctrl=TABLE if table==101 else OTHER
        c=self.call('system/context',table)+['scoreboard players set @e[tag=gd.cards] gd_owner -2','scoreboard players set @e[tag=gd.cards] gd_sel 0','scoreboard players set @e[tag=gd.board] gd_count 0','scoreboard players set @e[tag=gd.board] gd_rank 0']
        for seat,values in hands.items():
            c +=[f'scoreboard players set {card(v,table)} gd_owner {seat}' for v in values]
            c +=[f'scoreboard players set {part(seat,table)} gd_count {len(values)}']
        c +=[f'scoreboard players set {ctrl} gd_anim 0',f'scoreboard players set {ctrl} gd_lastkind 0',f'scoreboard players set {ctrl} gd_done 0',f'scoreboard players set {ctrl} gd_state 3',f'scoreboard players set {ctrl} gd_scored 0']
        return c

    def play(self,values,actor=1,table=101):
        return self.call('system/context',table)+['scoreboard players set @e[tag=gd.cards] gd_sel 0']+[f'scoreboard players set {card(v,table)} gd_sel 1' for v in values]+[f'scoreboard players set #actor gd_ctx {actor}']+self.call('game/play',table)

    def tribute(self,value,actor=1,table=101):
        return [f'scoreboard players set #actor gd_ctx {actor}',f'scoreboard players set #card gd_ctx {value}']+self.call('tribute/submit',table)

    def finish(self):
        self.file('bootstrap',['forceload add 0 0 47 15','scoreboard objectives add gt dummy','function guandan:load','function guandan_test:reset',f'schedule function guandan_test:case/{self.cases[0]} 2t'])
        self.file('finish','say GUANDAN_FINISHED')
        for i,name in enumerate(self.cases):self.files['case/'+name]+='schedule function guandan_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 1t\n'

    def build(self):
        self.prepare()
        # 完整真实入口、108次实际发牌，每个physical id与type各自核对。
        for cap,seats in ((4,(1,2,3,4)),(8,(2,3,6,7)),(8,(1,4,5,8))):
            key=f'deal_{cap}_{"".join(map(str,seats))}'
            c=self.playable(cap,seats)+self.score(TABLE,'ct_start',1,key+'_handshake')+self.score(TABLE,'gd_state',3,key+'_play')+self.count('@e[tag=gd.part]',4,key+'_parts')+self.count('@e[tag=gd.card]',108,key+'_108')
            for seat in seats:
                c+=self.score(part(seat),'gd_count',27,key+f'_seat{seat}_27')+self.score(person(seat),'ct_seat',seat,key+f'_seat{seat}_kept')
                c+=self.count(f'@e[tag=gd.card,scores={{gd_owner={seat}}}]',27,key+f'_seat{seat}_owned')
                c+=self.count(f'@e[type=minecraft:item,tag=ct.dealt_card,scores={{ct_id=101,ct_seat={seat}}}]',27,key+f'_seat{seat}_backs')
            c+=self.count('@e[type=minecraft:item,tag=ct.dealt_card,nbt={Item:{components:{"minecraft:item_model":"card:poker/back"}}}]',108,key+'_all_backs')
            for value in range(108):c+=self.count(f'@e[tag=gd.card,scores={{gd_id={value},gd_type={value%54}}}]',1,key+f'_id{value}')
            for value in range(54):c+=self.count(f'@e[tag=gd.card,scores={{gd_type={value}}}]',2,key+f'_type{value}')
            c+=self.call('system/context')+[f'execute as {TABLE} run function guandan_test:conservation']+self.score('#invalid','gt',0,key+'_conservation')
            self.case(key,c)
        for cap,players in itertools.product((4,8),(0,1,2,3,5)):
            key=f'badcount_{cap}_{players}'
            c=self.setup_game(cap,tuple(range(1,players+1)))+self.start()+self.score(TABLE,'ct_start',0,key+'_rejected')+self.count('@e[tag=gd.card]',0,key+'_no_cards')+self.count('@e[tag=gd.part]',0,key+'_no_parts')
            self.case(key,c)
        c=self.setup_game(8,(1,2,5,6))+self.start()+self.score(TABLE,'ct_start',0,'same_side_rejected')+self.count('@e[tag=gd.part]',0,'same_side_no_parts')
        self.case('same_sides',c)
        c=self.setup_game(8,(1,2,5,6))+[f'scoreboard players set {TABLE} gd_pair 1']+self.start()+self.score(TABLE,'ct_start',1,'random_handshake')
        for seat in (1,3,5,7):c+=self.count(f'@e[tag=gd.part,scores={{gd_seat={seat}}}]',1,f'random_side{seat}')
        c+=self.count('@e[tag=gd.part,scores={gd_team=0}]',2,'random_two_team0')+self.count('@e[tag=gd.part,scores={gd_team=1}]',2,'random_two_team1')+self.count('@e[type=minecraft:interaction,tag=ct.seat]',8,'random_keeps_common_chairs')
        self.case('random_sides',c)
        # 出牌扣同一physical id，逆时针轮转；发牌/出牌动画锁拒绝重入。
        c=self.playable(8,(2,3,6,7))+self.fixture_hands({2:(1,2),3:(3,4),6:(5,6),7:(7,8)})+[f'scoreboard players set {TABLE} gd_turn 2']+self.play((1,),2)
        c+=self.score('#ok','gd_ctx',1,'play_accept')+self.score(card(1),'gd_owner',-2,'play_discard_exact')+self.score(card(2),'gd_owner',2,'play_other_kept')+self.score(part(2),'gd_count',1,'play_count_decrement')+self.score(TABLE,'gd_turn',7,'turn_counterclockwise_sparse')+self.score(TABLE,'gd_anim',8,'play_locks_eight')+self.data(TABLE,'data.guandan.action.cardtypes',[1],'play_public_only_played')+self.data(part(2),'data.last_play',[1],'play_part_public')
        c+=self.play((7,),7)+self.score('#ok','gd_ctx',0,'animation_blocks_next')+self.score(card(7),'gd_owner',7,'animation_keeps_hand')
        self.case('play_turn_lock',c)
        # 无法领出PASS；三人过牌后原领出者重新领；出完牌者则对家接风。
        for finished in (False,True):
            key='wind' if finished else 'trick'
            hands={1:(1,) if finished else (1,2),2:(3,4),3:(5,6),4:(7,8)}
            c=self.playable()+self.fixture_hands(hands)+[f'scoreboard players set {TABLE} gd_turn 1','scoreboard players set #actor gd_ctx 1']+self.call('game/pass')+self.score('#ok','gd_ctx',0,key+'_lead_cannot_pass')+self.play((1,))
            c+=[f'scoreboard players set {TABLE} gd_anim 0']
            for actor in (4,3,2):c+=[f'scoreboard players set #actor gd_ctx {actor}']+self.call('game/pass')
            c+=self.score(TABLE,'gd_turn',3 if finished else 1,key+'_leader')+self.score(TABLE,'gd_lastkind',0,key+'_new_lead')+self.data(part(),'data.last_play',[],key+'_table_cleared')+self.count('@e[tag=gd.card]',108,key+'_108')
            self.case(key,c)
        # 双下立即结算、三个名次结束时补末游；升1/2/3，级牌最多A。
        for partner_rank,startlevel in itertools.product((2,3,4),(2,12,14)):
            key=f'upgrade_{partner_rank}_{startlevel}'
            c=self.playable()+[f'scoreboard players set {TABLE} gd_team0 {startlevel}',f'scoreboard players set {TABLE} gd_level {startlevel}',f'scoreboard players set {TABLE} gd_done {2 if partner_rank==2 else 3}']
            ranks={1:1,3:partner_rank};others=[r for r in (2,3,4) if r!=partner_rank]
            ranks.update(dict(zip((2,4),others)))
            for seat,rank in ranks.items():c+=[f'scoreboard players set {part(seat)} gd_rank {rank if rank<=2 or partner_rank!=2 else 0}']
            c+=self.call('round/over')+self.score(TABLE,'gd_steps',5-partner_rank,key+'_steps')+self.score(TABLE,'gd_team0',min(14,startlevel+5-partner_rank),key+'_newlevel')+self.score(TABLE,'gd_team1',2,key+'_opponent_kept')+self.score(TABLE,'gd_state',5 if startlevel==14 and partner_rank<=3 else 4,key+'_pass_a')+self.count('@e[tag=gd.part,scores={gd_prevrank=1..4}]',4,key+'_four_places')
            oldtimer=43;c+=[f'scoreboard players set {TABLE} gd_timer {oldtimer}']+self.call('round/over')+self.call('round/match_over') if startlevel==14 and partner_rank<=3 else c+self.call('round/over')
            c+=self.score(TABLE,'gd_team0',min(14,startlevel+5-partner_rank),key+'_idempotent_level')
            self.case(key,c)
        for level0,level1,winner in ((4,3,0),(3,4,1),(4,4,2)):
            key=f'fixed_{level0}_{level1}'
            c=self.playable()+[f'scoreboard players set {TABLE} gd_team0 {level0}',f'scoreboard players set {TABLE} gd_team1 {level1}']+self.call('round/fixed_over')+self.score(TABLE,'gd_matchwin',winner,key+'_winner')+self.score(TABLE,'gd_state',5,key+'_finished')
            self.case(key,c)
        self.build_tributes()
        # 各阶段reload不得重抽牌；旧epoch失效但计时/实卡/贡还选择保持。
        for state,phase in ((1,0),(2,1),(2,2),(3,0),(4,0),(5,0)):
            key=f'reload_{state}_{phase}'
            c=self.playable()+[f'scoreboard players set {TABLE} gd_state {state}',f'scoreboard players set {TABLE} gd_phase {phase}',f'scoreboard players set {TABLE} gd_clock 37',f'scoreboard players set {TABLE} gd_timer 58',f'scoreboard players set {TABLE} gd_dealt 51',f'scoreboard players set {part()} gd_giftid 7',f'scoreboard players set {part()} gd_returnid 8',f'scoreboard players set {card(7)} gd_owner 1',f'scoreboard players set {card(7)} gd_sel 1',f'scoreboard players operation #oldepoch gt = {TABLE} gd_epoch']+self.call('system/reload')
            c+=self.score(TABLE,'gd_state',state,key+'_state')+self.score(TABLE,'gd_phase',phase,key+'_phase')+self.score(TABLE,'gd_clock',37,key+'_clock')+self.score(TABLE,'gd_timer',58,key+'_timer')+self.score(TABLE,'gd_dealt',51,key+'_progress')+self.score(part(),'gd_giftid',7,key+'_gift')+self.score(part(),'gd_returnid',8,key+'_return')+self.score(card(7),'gd_owner',1,key+'_owner')+self.score(card(7),'gd_sel',1,key+'_selection')+self.check(f'score {TABLE} gd_epoch > #oldepoch gt',key+'_epoch')
            c+=self.call('game/abort')+self.score(TABLE,'ct_state',0,key+'_lobby')+self.count('@e[tag=gd.card]',0,key+'_cleans_cards')+self.count('@e[tag=gd.part]',0,key+'_cleans_parts')+self.count('@e[tag=ct.controller]',1,key+'_keeps_controller')+self.count('@e[tag=ct.seat]',4,key+'_keeps_seats')
            self.case(key,c)
        c=self.playable()+self.playable(8,(2,3,6,7),202,False)+[f'scoreboard players set {OTHER} gd_clock 71',f'scoreboard players set {card(7,202)} gd_sel 1']+self.call('game/abort')+self.count('@e[tag=gd.card,scores={ct_id=101}]',0,'two_first_cleared')+self.count('@e[tag=gd.card,scores={ct_id=202}]',108,'two_second_kept')+self.score(OTHER,'gd_state',3,'two_other_state')+self.score(OTHER,'gd_clock',71,'two_other_clock')+self.score(card(7,202),'gd_sel',1,'two_other_selection')+self.count('@e[tag=gd.part,scores={ct_id=202}]',4,'two_other_parts')
        self.case('two_tables',c)
        c=self.playable()+[f'tag {person(3)} remove ct.player',f'scoreboard players set {TABLE} gd_tick 19']+self.call('game/tick')+self.score(TABLE,'ct_state',0,'offline_lobby')+self.count('@e[tag=gd.card]',0,'offline_cards_clear')+self.count('@e[tag=gd.part]',0,'offline_parts_clear')
        self.case('offline',c)
        # 每一步使用真实超时策略，完整一副终结并逐步核对每张实卡和人数。
        c=self.playable()+['scoreboard players set #broken gt 0']
        self.case('full_round_begin',c)
        for batch in range(8):
            c=[f'execute as {TABLE} at @s run function guandan_test:auto_step']*30+self.score('#broken','gt',0,f'full_round_conserved_{batch}')
            if batch==7:c+=self.score(TABLE,'gd_state',4,'full_round_terminates')+self.count('@e[tag=gd.part,scores={gd_prevrank=1..4}]',4,'full_round_ranks')
            self.case(f'full_round_{batch}',c)
        self.finish()

    def build_tributes(self):
        # 用少量指定持有牌构造单贡、双贡，未涉及牌全部在弃牌仍保持108。
        for doubled,equal in ((False,False),(True,False),(True,True)):
            key=f'tribute_{int(doubled)}_{int(equal)}'
            hands={1:(1,5,10),2:(53 if not equal else 12,3),3:(2,6,11),4:(52 if not equal else 25,4)}
            c=self.playable()+self.fixture_hands(hands)+[f'scoreboard players set {TABLE} gd_round 2']
            for seat,rank in {1:1,2:3 if doubled else 2,3:2 if doubled else 3,4:4}.items():c+=[f'scoreboard players set {part(seat)} gd_prevrank {rank}']
            c+=self.call('tribute/begin')+self.score(TABLE,'gd_state',2,key+'_state')+self.score(TABLE,'gd_phase',1,key+'_phase')+self.score(TABLE,'gd_tribn',2 if doubled else 1,key+'_donors')
            c+=self.tribute(4,4)+self.score('#ok','gd_ctx',0,key+'_not_max_rejected')+self.score(card(4),'gd_owner',4,key+'_bad_owner_kept')
            gift4=25 if equal else 52
            if doubled:
                gift2=12 if equal else 53
                c+=self.tribute(gift4,4)+self.score('#ok','gd_ctx',1,key+'_first_choice')+self.score(card(gift4),'gd_owner',4,key+'_wait_both_gifts')+self.tribute(gift2,2)
                # 较大或同大顺时针邻座(座2)给上游座1。
                c+=self.score(card(gift2),'gd_owner',1,key+'_larger_to_head')+self.score(card(gift4),'gd_owner',3,key+'_other_to_partner')+self.score(TABLE,'gd_first',2,key+'_lead_donor')
            else:
                c+=self.tribute(gift4,4)+self.score(card(gift4),'gd_owner',1,key+'_single_to_head')+self.score(TABLE,'gd_first',4,key+'_lead_donor')
            c+=self.score(TABLE,'gd_phase',2,key+'_return_phase')+self.tribute(10,1)+self.score('#ok','gd_ctx',0,key+'_return_j_rejected')+self.tribute(1,1)
            if doubled:
                c+=self.score(card(1),'gd_owner',1,key+'_hidden_wait_both_returns')+self.tribute(2,3)+self.score(card(2),'gd_owner',4,key+'_second_return')
            c+=self.score(card(1),'gd_owner',2 if doubled else 4,key+'_return_destination')+self.score(TABLE,'gd_state',3,key+'_plays')+self.score(TABLE,'gd_turn',2 if doubled else 4,key+'_correct_first')+self.score(TABLE,'gd_anim',8,key+'_return_animation_lock')
            self.case(key,c)
        # 红桃级牌绝不进贡；其他花色级牌比A高。单方两大王及双方各一张大王均可抗贡。
        for doubled,split in ((False,False),(True,False),(True,True)):
            key=f'resist_{int(doubled)}_{int(split)}'
            hands={1:(1,),2:(53,) if split else (3,),3:(2,),4:(107,) if split else (53,107)}
            c=self.playable()+self.fixture_hands(hands)+[f'scoreboard players set {TABLE} gd_round 2']
            for seat,rank in {1:1,2:3 if doubled else 2,3:2 if doubled else 3,4:4}.items():c+=[f'scoreboard players set {part(seat)} gd_prevrank {rank}']
            c+=self.call('tribute/begin')+self.score(TABLE,'gd_state',3,key+'_no_tribute')+self.score(TABLE,'gd_turn',1,key+'_head_leads')+self.score(card(53),'gd_owner',2 if split else 4,key+'_jokers_kept')
            self.case(key,c)
        c=self.playable()+self.fixture_hands({1:(12,11),2:(1,),3:(2,),4:(26,0,12+54)})+[f'scoreboard players set {TABLE} gd_round 2']
        for seat,rank in {1:1,2:2,3:3,4:4}.items():c+=[f'scoreboard players set {part(seat)} gd_prevrank {rank}']
        c+=self.call('tribute/begin')+self.tribute(26,4)+self.score('#ok','gd_ctx',0,'wild_cannot_tribute')+self.tribute(66,4)+self.score('#ok','gd_ctx',0,'ace_less_than_level')+self.tribute(0,4)+self.score('#ok','gd_ctx',1,'nonheart_level_tributes')
        # 接到级2自然点<=10，可原牌还；没有低点牌的独立用例下方另测。
        c+=self.tribute(0,1)+self.score('#ok','gd_ctx',1,'level_point_can_return')
        self.case('tribute_wild_level',c)
        c=self.playable()+self.fixture_hands({1:(10,11,12),2:(1,),3:(2,),4:(53,3)})+[f'scoreboard players set {TABLE} gd_round 2']
        for seat,rank in {1:1,2:2,3:3,4:4}.items():c+=[f'scoreboard players set {part(seat)} gd_prevrank {rank}']
        c+=self.call('tribute/begin')+self.tribute(53,4)+self.tribute(11,1)+self.score('#ok','gd_ctx',0,'all_high_rejects_nonminimum')+self.tribute(10,1)+self.score('#ok','gd_ctx',1,'all_high_returns_minimum')+self.score(card(10),'gd_owner',4,'all_high_transfers')
        self.case('return_all_high',c)
        # 低点级牌仍可还；不能让非级Q因strength较小而抢占自动还牌。
        c=self.playable()+self.fixture_hands({1:(10,11,12,26),2:(1,),3:(2,),4:(53,3)})+[f'scoreboard players set {TABLE} gd_round 2']
        for seat,rank in {1:1,2:2,3:3,4:4}.items():c+=[f'scoreboard players set {part(seat)} gd_prevrank {rank}']
        c+=self.call('tribute/begin')+self.tribute(53,4)+self.call('tribute/auto')+self.score('#ok','gd_ctx',1,'auto_returns_low_point_level')+self.score(card(26),'gd_owner',4,'auto_return_level_owner')+self.score(TABLE,'gd_state',3,'auto_low_level_progresses')
        self.case('return_auto_low_level',c)


if __name__=='__main__':
    suite=Suite();suite.build();raise SystemExit(run(suite,isolated=False,prefix='fimel-guandan-game-',prepare_target=prepare_target))
