"""情书完整原版 26.2 生命周期 GameTest；生产回调、视觉与声音全部保留。"""
from pathlib import Path
import re
from test_love_letter_engine import Suite as EngineSuite, PACK, TABLE, OTHER, part, run


def person(seat=1,table=101):
    return f'@e[type=minecraft:armor_stand,tag=lg.person,scores={{ct_id={table},ct_seat={seat}}},limit=1]'


def prepare_target(target):
    # 服务端的参与者筛选拓宽至替身；tellraw/Dialog/音频等客户端命令仍保留玩家筛选。
    paths=list((target/'data/love_letter/function').rglob('*.mcfunction'))
    paths+=list((target/'data/cardtable/function/animation/deal').rglob('*.mcfunction'))
    paths+=[target/'data/cardtable/function/game/return_lobby.mcfunction']
    for path in paths:
        lines=[]
        for line in path.read_text(encoding='utf-8').splitlines():
            if not any(token in line for token in ('tellraw ','dialog ','title ','playsound ','clear @s','give @s','item replace ')):
                line=line.replace('@a[','@e[')
            lines.append(line)
        path.write_text('\n'.join(lines)+'\n',encoding='utf-8')


def audit_public_visuals():
    """公开实体生成器只可读取公开动作、弃牌和积分，不能接触任何秘密输入。"""
    checked=0
    for folder in ('visual','deal'):
        for path in (PACK/'data/love_letter/function'/folder).rglob('*.mcfunction'):
            body='\n'.join(line for line in path.read_text(encoding='utf-8').splitlines() if not line.lstrip().startswith('#'))
            assert not re.search(r'\bll_(?:hand|extra)\b|data\.ll_(?:private|buffer)|data\.love_letter\.(?:deck|reserve)',body),path
            checked+=1
    print(f'情书公开实体秘密访问静态检查：{checked} 个函数通过。',flush=True)


class Suite(EngineSuite):
    def prepare(self):
        super().prepare()
        self.file('reset',['kill @e[tag=lt.fixture]','kill @e[tag=ll.part]','kill @e[tag=ll.visual]','kill @e[tag=ll.firework]','kill @e[tag=ct.seat]','kill @e[tag=ct.menu]','kill @e[tag=ct.vote]','kill @e[tag=ct.dealt_card]','kill @e[tag=ct.new_dealt_card]','scoreboard players set #after lt 0'])
        self.file('game_table','''
tag @s add lt.fixture
tag @s add lt.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_capacity $(cap)
$scoreboard players set @s ct_joined $(joined)
scoreboard players set @s ct_game 17
scoreboard players set @s ct_state 0
scoreboard players set @s ct_start 0
data merge entity @s {data:{cardtable:{menu_version:17,rules_version:5,chairs_version:1,vote_version:1}}}
function cardtable:table/ensure_seats
function love_letter:game/init_table
''')
        self.file('person','''
tag @s add lt.fixture
tag @s add lg.person
tag @s add ct.player
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_seat $(seat)
scoreboard players set @s ct_online 1
$data merge entity @s {NoGravity:1b,Invulnerable:1b,CustomName:{text:"测试$(seat)"}}
''')
        self.file('play_step','''
execute unless score @s ll_state matches 2 run return 0
scoreboard players set @s ll_clock 0
function love_letter:game/tick
function love_letter_test:roles
''')

    def setup_game(self,cap=4,seats=(1,3),table=101,reset=True,claimed=None):
        ctrl=TABLE if table==101 else OTHER
        lines=['function love_letter_test:reset'] if reset else []
        lines +=[f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:marker run function love_letter_test:game_table {{table:{table},cap:{cap},joined:{len(seats) if claimed is None else claimed}}}']
        for seat in seats:
            lines +=[f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:armor_stand run function love_letter_test:person {{table:{table},seat:{seat}}}']
        lines +=[f'scoreboard players set {ctrl} ll_first_setting 1']
        return lines

    def start(self,table=101):
        ctrl=TABLE if table==101 else OTHER
        return self.call('game/start',table)+[f'execute if score {ctrl} ct_start matches 1 run scoreboard players set {ctrl} ct_state 1']

    def ticks(self,count,table=101):
        return self.call('game/tick',table)*count

    def playable(self,cap=4,seats=(1,3),table=101,reset=True):
        return self.setup_game(cap,seats,table,reset)+self.start(table)+self.ticks(3*(len(seats)+1)+16,table)

    def build(self):
        self.prepare()
        c=self.setup_game(4,(1,3))+self.start()+self.score(TABLE,'ct_start',1,'smoke_handshake')+self.score(TABLE,'ll_state',1,'smoke_initial_deal')+self.count('@e[tag=ll.part]',2,'smoke_two_parts')
        c+=self.ticks(25)+self.score(TABLE,'ll_state',2,'smoke_play_state')+self.score(TABLE,'ll_phase',1,'smoke_play_phase')+self.score(TABLE,'ll_anim',0,'smoke_animation_unlocks')
        c+=[f'execute as {TABLE} run function love_letter_test:conservation']+self.score('#total','lt',21,'smoke_21_conserved')
        self.case('smoke',c)
        for cap in (4,8):
            for players in range(2,7 if cap==8 else 5):
                seats=((4,1,3,2) if cap==4 else (8,1,6,3,7,4))[:players]
                key=f'start_{cap}_{players}'
                c=self.setup_game(cap,seats)+self.start()+self.score(TABLE,'ct_start',1,key+'_handshake')+self.score(TABLE,'ll_players',players,key+'_actual')+self.count('@e[tag=ll.part]',players,key+'_parts')
                c+=[f'execute as {TABLE} run function love_letter_test:conservation']+self.score('#total','lt',21,key+'_initial_21')
                c+=self.ticks(3*(players+1)+16)+self.score(TABLE,'ll_state',2,key+'_play')+self.score(TABLE,'ll_turn',min(seats),key+'_first_real_seat')+self.score(TABLE,'ll_anim',0,key+'_unlocked')
                c+=self.count('@e[tag=ll.part,scores={ll_extra=0..9}]',1,key+'_only_actor_extra')+self.count('@e[type=minecraft:item,tag=ct.dealt_card]',players+1,key+'_exact_initial_and_draw')
                c+=self.count('@e[type=minecraft:item,tag=ct.dealt_card,nbt={Item:{components:{"minecraft:item_model":"card:love_letter/back"}}}]',players+1,key+'_all_flying_backs')
                c+=[f'execute as {TABLE} run function love_letter_test:conservation']+self.score('#total','lt',21,key+'_after_draw_21')
                for seat in seats:
                    c+=self.score(person(seat),'ct_seat',seat,key+f'_seat{seat}_unchanged')
                    c+=self.count(f'@e[type=minecraft:item,tag=ct.dealt_card,scores={{ct_id=101,ct_seat={seat}}}]',1+int(seat==min(seats)),key+f'_seat{seat}_dealt_exactly_once')
                self.case(key,c)
        for cap,players in ((4,0),(4,1),(4,5),(8,1),(8,7)):
            key=f'reject_{cap}_{players}'
            c=self.setup_game(cap,tuple(range(1,players+1)))+self.start()+self.score(TABLE,'ct_start',0,key+'_no_handshake')+self.count('@e[tag=ll.part]',0,key+'_no_part_mutation')+self.count('@e[tag=ll.player]',0,key+'_no_player_identity')
            self.case(key,c)
        c=self.setup_game(4,(1,),claimed=2)+self.start()+self.score(TABLE,'ct_start',0,'claimed_count_rejected')+self.count('@e[tag=ll.part]',0,'claimed_count_no_partial_part')+self.count('@e[tag=ll.player]',0,'claimed_count_no_partial_player')
        self.case('count_mismatch',c)
        # 稀疏座号正常出一张，完整结算后才轮转；摸牌动画锁确实阻止输入。
        c=self.playable(8,(1,4,7))+[f'scoreboard players set {part(1)} ll_hand 4',f'scoreboard players set {part(1)} ll_extra 8',f'data modify entity {TABLE} data.love_letter.deck set value [2,3,5]']+self.play()
        c+=self.score(TABLE,'ll_turn',4,'next_turn_skips_empty')+self.score(part(1),'ll_protect',1,'played_handmaid_protects')+self.score(part(4),'ll_extra',2,'next_turn_draws_once')+self.data(TABLE,'data.love_letter.deck',[3,5],'next_turn_exact_deck')+self.score(TABLE,'ll_anim',8,'draw_animation_lock_eight')
        c+=self.play(actor=4)+self.score('#ok','ll_ctx',0,'draw_animation_rejects_action')+self.data(part(4),'data.discards',[],'draw_animation_no_discard')+self.ticks(7)+self.score(TABLE,'ll_anim',1,'draw_animation_seven_still_locked')+self.ticks(1)+self.score(TABLE,'ll_anim',0,'draw_animation_eight_unlocks')
        c+=[f'scoreboard players set {part(7)} ll_alive 0']+self.call('game/next_turn')+self.score(TABLE,'ll_turn',1,'next_turn_skips_dead_and_wraps')
        self.case('turn_animation',c)
        # 一张牌库在尚未完成 Guard/Priest/Chancellor 效果时不得提前轮终。
        c=self.playable(4,(1,3,4))+[f'scoreboard players set {part()} ll_hand 2',f'scoreboard players set {part()} ll_extra 8',f'data modify entity {TABLE} data.love_letter.deck set value []']+self.play()
        c+=self.score(TABLE,'ll_phase',2,'last_draw_priest_wait_target')+self.score(TABLE,'ll_state',2,'last_draw_priest_still_playing')+self.target(3)+self.score(TABLE,'ll_state',3,'last_draw_priest_then_round_end')+self.score(TABLE,'ll_phase',6,'last_draw_priest_phase_six')
        self.case('complete_before_round_end',c)
        # 轮胜者和唯一存活间谍分别计分；同时达到目标的全部共同获胜。
        c=self.playable(4,(1,3,4))+[f'scoreboard players set {TABLE} ll_goal 1',f'scoreboard players set {TABLE} ll_phase 0',f'data modify entity {TABLE} data.love_letter.deck set value []',f'scoreboard players set {part()} ll_hand 9',f'scoreboard players set {part(3)} ll_hand 8',f'scoreboard players set {part(4)} ll_hand 7',f'scoreboard players set @e[tag=ll.part] ll_extra -1',f'scoreboard players set {part(3)} ll_spy 1']+self.call('engine/check_round')
        c+=self.score(TABLE,'ll_state',4,'match_two_achievers')+self.score(part(),'ll_won',1,'match_high_hand_winner')+self.score(part(3),'ll_won',0,'spy_not_round_winner')+self.score(part(3),'ll_bonus',1,'spy_bonus')+self.count('@e[tag=ll.part,scores={ll_matchwin=1}]',2,'match_all_target_players')+self.count('@e[type=minecraft:firework_rocket,tag=ll.firework,scores={ct_id=101}]',2,'match_sk_fireworks_each_winner')
        c+=[f'scoreboard players set {TABLE} ll_timer 43']+self.call('game/match_over')+self.call('game/round_over')+self.score(TABLE,'ll_timer',43,'match_finish_idempotent_timer')+self.count('@e[type=minecraft:firework_rocket,tag=ll.firework,scores={ct_id=101}]',2,'match_finish_idempotent_fireworks')+self.call('game/cleanup')+self.score(TABLE,'ct_state',0,'match_cleanup_lobby')+self.count('@e[tag=ll.part]',0,'match_cleanup_parts')+self.count('@e[tag=ll.player]',0,'match_cleanup_players')
        self.case('scoring_match_finish',c)
        c=self.playable(4,(1,3,4))+[f'scoreboard players set {TABLE} ll_goal 10',f'scoreboard players set {TABLE} ll_phase 0',f'data modify entity {TABLE} data.love_letter.deck set value []',f'scoreboard players set {part()} ll_hand 9',f'scoreboard players set {part(3)} ll_hand 8',f'scoreboard players set {part(4)} ll_hand 7',f'scoreboard players set @e[tag=ll.part] ll_extra -1',f'scoreboard players set {part(3)} ll_spy 1']+self.call('engine/check_round')
        c+=self.score(TABLE,'ll_state',3,'next_round_wait')+[f'scoreboard players set {TABLE} ll_timer 1']+self.call('game/result_tick')+self.score(TABLE,'ll_round',2,'next_round_increment')+self.score(TABLE,'ll_first',1,'next_round_only_round_winner_starts')+self.score(part(),'ll_points',1,'next_round_keeps_winner_points')+self.score(part(3),'ll_points',1,'next_round_keeps_spy_points')+[f'execute as {TABLE} run function love_letter_test:conservation']+self.score('#total','lt',21,'next_round_new_21')
        self.case('next_round_first',c)
        # 保护、秘密选择、时钟和牌库在 /reload 后保持；不触发洗牌或再次摸牌。
        for state,phase in ((1,1),(2,1),(2,2),(2,3),(2,4),(2,5),(3,6),(4,6)):
            key=f'reload_{state}_{phase}'
            c=self.playable(4,(1,3,4))+[f'scoreboard players set {TABLE} ll_state {state}',f'scoreboard players set {TABLE} ll_phase {phase}',f'scoreboard players set {TABLE} ll_clock 37',f'scoreboard players set {TABLE} ll_timer 58',f'scoreboard players set {part()} ll_hand 8',f'scoreboard players set {part()} ll_extra 5',f'scoreboard players set {part(3)} ll_protect 1',f'data modify entity {TABLE} data.love_letter.deck set value [0,4,7]',f'data modify entity {TABLE} data.ll_buffer set value [8,2,7]']+self.call('system/reload')
            c+=self.score(TABLE,'ll_state',state,key+'_state')+self.score(TABLE,'ll_phase',phase,key+'_phase')+self.score(TABLE,'ll_clock',37,key+'_clock')+self.score(TABLE,'ll_timer',58,key+'_timer')+self.score(part(),'ll_hand',8,key+'_hand')+self.score(part(),'ll_extra',5,key+'_extra')+self.score(part(3),'ll_protect',1,key+'_protect')+self.data(TABLE,'data.love_letter.deck',[0,4,7],key+'_deck')+self.data(TABLE,'data.ll_buffer',[8,2,7],key+'_buffer')
            c+=self.call('game/abort')+self.score(TABLE,'ct_state',0,key+'_abort_lobby')+self.count('@e[tag=ll.part]',0,key+'_abort_parts')+self.count('@e[tag=ll.player]',0,key+'_abort_players')
            c+=[f'execute store success score #exists lt run data get entity {TABLE} data.ll_buffer']+self.score('#exists','lt',0,key+'_old_buffer_removed')+self.count('@e[tag=lt.table,scores={ct_id=101}]',1,key+'_controller_kept')
            self.case(key,c)
        # 两桌同时存在，清除第一桌不动第二桌任何逻辑、资源或专属掉落物。
        c=self.playable(4,(1,3))+self.playable(8,(2,6,8),202,False)
        c+=[f'data modify entity {OTHER} data.love_letter.deck set value [9,8,7]',f'execute positioned 8.0 65.0 8.0 run summon minecraft:item ~ ~ ~ {{Tags:["lt.drop101"],Item:{{id:"minecraft:purple_dye",count:1,components:{{"minecraft:custom_data":{{love_letter:{{tool:1b,table:101}}}}}}}}}}',f'execute positioned 40.0 65.0 8.0 run summon minecraft:item ~ ~ ~ {{Tags:["lt.drop202"],Item:{{id:"minecraft:purple_dye",count:1,components:{{"minecraft:custom_data":{{love_letter:{{tool:1b,table:202}}}}}}}}}}',f'execute positioned 8.0 65.0 8.0 run summon minecraft:item ~ ~ ~ {{Tags:["lt.normal"],Item:{{id:"minecraft:paper",count:1}}}}']+self.call('game/abort')
        c+=self.count('@e[tag=ll.part,scores={ct_id=101}]',0,'isolation_first_parts_cleared')+self.count('@e[tag=ll.part,scores={ct_id=202}]',3,'isolation_second_parts_kept')+self.score(OTHER,'ll_state',2,'isolation_second_playing')+self.data(OTHER,'data.love_letter.deck',[9,8,7],'isolation_second_deck_kept')+self.count('@e[tag=lt.drop101]',0,'isolation_own_tool_drop_removed')+self.count('@e[tag=lt.drop202]',1,'isolation_other_tool_drop_kept')+self.count('@e[tag=lt.normal]',1,'isolation_normal_item_kept')
        self.case('two_table_cleanup',c)
        # 超时推进沿用同一引擎，强制出牌和大臣多阶段不会跳过秘密选择。
        c=self.playable(4,(1,3,4))+[f'scoreboard players set {part()} ll_hand 4',f'scoreboard players set {part()} ll_extra 8',f'scoreboard players set {TABLE} ll_time_setting 30',f'scoreboard players set {TABLE} ll_clock 1']+self.ticks(1)
        c+=self.score(TABLE,'ll_turn',3,'timeout_finishes_action')+self.score(TABLE,'ll_clock',600,'timeout_next_clock_resets')+self.score(TABLE,'ll_anim',8,'timeout_next_draw_anim')
        self.case('timeout_simple',c)
        c=self.playable(4,(1,3,4))+[f'scoreboard players set {part()} ll_hand 6',f'scoreboard players set {part()} ll_extra 8',f'data modify entity {TABLE} data.love_letter.deck set value [2,9,3]',f'scoreboard players set {TABLE} ll_time_setting 30',f'scoreboard players set {TABLE} ll_clock 1']+self.ticks(1)+self.score(TABLE,'ll_phase',4,'timeout_chancellor_keep_phase')+self.ticks(1)+self.score(TABLE,'ll_phase',5,'timeout_chancellor_bottom_phase')+self.ticks(1)+self.score(TABLE,'ll_turn',3,'timeout_chancellor_completed')+self.score(part(),'ll_hand',9,'timeout_chancellor_keeps_high')+self.data(TABLE,'data.love_letter.deck',[8,2],'timeout_chancellor_bottom_order')
        self.case('timeout_chancellor',c)
        c=self.playable(4,(1,3,4))+[f'scoreboard players set {part()} ll_hand 1',f'scoreboard players set {part()} ll_extra 8']+self.play()+self.target(3)+['scoreboard players set #actor ll_ctx 3']+self.call('game/resign')+self.score(TABLE,'ll_turn',4,'resign_guard_target_advances')+self.score(part(3),'ll_alive',0,'resign_guard_target_dead')
        self.case('resign_target_integrated',c)
        c=self.playable(4,(1,3,4))+[f'scoreboard players set {part()} ll_hand 1',f'scoreboard players set {part()} ll_extra 8',f'scoreboard players set {part(4)} ll_protect 1']+self.play()+['scoreboard players set #actor ll_ctx 3']+self.call('game/resign')+self.score(TABLE,'ll_turn',4,'resign_last_legal_target_advances')+self.score(TABLE,'ll_phase',1,'resign_last_legal_target_new_phase')
        self.case('resign_last_legal_target_integrated',c)
        c=self.playable(4,(1,3))+[f'scoreboard players set {part()} ll_hand 6',f'scoreboard players set {part()} ll_extra 8',f'data modify entity {TABLE} data.love_letter.deck set value [2,7]']+self.play()+['scoreboard players set #actor ll_ctx 3']+self.call('game/resign')+self.score(TABLE,'ll_state',3,'resign_chancellor_last_round_end')+self.data(TABLE,'data.ll_buffer',[],'resign_chancellor_buffer_cleared')+self.data(TABLE,'data.love_letter.deck',[2,7],'resign_chancellor_cards_preserved')
        self.case('resign_chancellor_integrated',c)
        c=self.playable(4,(1,3))+[f'tag {person(3)} remove ct.player',f'scoreboard players set {TABLE} ll_tick 19']+self.ticks(1)+self.score(TABLE,'ct_state',0,'offline_aborts_match')+self.count('@e[tag=ll.part]',0,'offline_cleans_all_parts')
        self.case('offline_cleanup',c)
        # 不替换任何生产回调，依次自动完成一整轮；每个子阶段持续核对各角色数量。
        for players in range(2,7):
            key=f'full_round_{players}'
            seats=(8,2,6,4,7,1)[:players]
            c=self.playable(8,seats)+[f'scoreboard players set {TABLE} ll_goal 1',f'scoreboard players set {TABLE} ll_time_setting 30','scoreboard players set #broken lt 0']
            self.case(key+'_init',c)
            for batch in range(4):
                c=[f'execute as {TABLE} at @s run function love_letter_test:play_step']*80+self.score('#broken','lt',0,key+f'_batch{batch}_21_roles')
                if batch==3:
                    c+=self.score(TABLE,'ll_state',4,key+'_match_result')+self.score(TABLE,'ll_winners','1..6',key+'_has_round_winners')
                self.case(key+f'_batch{batch}',c)
        self.finish()


if __name__=='__main__':
    audit_public_visuals()
    suite=Suite();suite.build();raise SystemExit(run(suite,isolated=False,prefix='fimel-loveletter-game-',prepare_target=prepare_target))
