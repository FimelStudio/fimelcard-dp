"""原版隔离世界：红线互选、排名、暂停、隔桌、旧会话和模式重载。

只在临时副本将真人选择替换为盔甲架，隐藏HUD/物品派发不进入断言；
红线决策、亮牌、计分、状态转换、清理和题库均调用真正的生产函数。
"""
from pathlib import Path
import re
import shutil
import sys
from test_guandan_cards import Suite as BaseSuite, run, PACK

JAVA='C:/Temp/fimel-java25-validation/jdk-25.0.5+8-jre/bin/java.exe'
C='@e[type=minecraft:marker,tag=ir.table,scores={ct_id=101},limit=1]'
D=C.replace('101','202')


def player(seat,table=101):return f'@e[type=minecraft:armor_stand,tag=ir.player,scores={{ct_id={table},it_seat={seat}}},limit=1]'


def fixture_hook(target):
    dest=target/'data/ito';shutil.copytree(PACK/'data/ito',dest)
    for p in (dest/'function').rglob('*.mcfunction'):
        lines=[]
        for line in p.read_text(encoding='utf-8').splitlines():
            if not any(x in line for x in ('tellraw ','title ','dialog ','playsound ','stopsound ','clear ','item replace ','give ')):
                line=line.replace('@a[','@e[type=minecraft:armor_stand,tag=ir.player,')
            lines.append(line)
        p.write_text('\n'.join(lines)+'\n',encoding='utf-8')
    # 服务端规则数据保持真实；仅排除客户端面板和库存呈现。
    for name in ('hud/activate','hud/deactivate','hud/refresh','visual/refresh','input/give','input/number_cards'):
        (dest/'function'/(name+'.mcfunction')).write_text('return 1\n',encoding='utf-8')
    (dest/'function/name/resolve.mcfunction').write_text('data modify storage ito:name resolved set value {text:"测试玩家"}\n',encoding='utf-8')
    finish=dest/'function/game/finish.mcfunction'
    finish.write_text('execute as @e[tag=ir.player,tag=it.winner] run tag @s add ir.winner\n'+finish.read_text(encoding='utf-8'),encoding='utf-8')


class Suite(BaseSuite):
    def context(self,table=101):return [f'execute as {C if table==101 else D} at @s run function ito:system/context']
    def setup(self,numbers=(45,54,40,58),table=101,reset=True):
        c=['kill @e[tag=ir.fixture]'] if reset else []
        c+=[f'execute positioned {8 if table==101 else 10} 64 8 summon minecraft:marker run function guandan_test:ir/table {{table:{table},n:{len(numbers)}}}']
        for seat,value in enumerate(numbers,1):
            c+=[f'execute positioned 8 64 8 summon minecraft:armor_stand run function guandan_test:ir/player {{table:{table},seat:{seat}}}',f'execute positioned 8 64 8 summon minecraft:marker run function guandan_test:ir/card {{table:{table},seat:{seat},value:{value}}}']
        return c+self.context(table)
    def choose(self,seat,target=None,table=101):
        choice=40 if target is None else 30+target
        return [f'scoreboard players set #choice it_ctx {choice}',f'execute as {player(seat,table)} at @s run function ito:red/choose']
    def pair(self,a,b,table=101):return self.choose(a,b,table)+self.choose(b,a,table)
    def build(self):
        self.file('ir/table','''
tag @s add ir.fixture
tag @s add ir.table
tag @s add ct.controller
tag @s add it.controller
$scoreboard players set @s ct_id $(table)
scoreboard players set @s ct_game 19
scoreboard players set @s ct_state 1
scoreboard players set @s ct_session 7
scoreboard players set @s ct_paused 0
scoreboard players set @s ct_capacity 8
$scoreboard players set @s ct_joined $(n)
scoreboard players set @s it_mode 1
scoreboard players set @s it_state 2
scoreboard players set @s it_epoch 42
scoreboard players set @s it_round 1
scoreboard players set @s it_life 3
scoreboard players set @s it_input 0
$scoreboard players set @s it_count $(n)
data merge entity @s {data:{ito:{history:[],theme:{question:"测试主题",text:"测试主题"}}}}
''')
        self.file('ir/player','''
tag @s add ir.fixture
tag @s add ir.player
tag @s add ct.player
tag @s add it.player
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s it_table $(table)
$scoreboard players set @s it_seat $(seat)
$scoreboard players set @s ct_seat $(seat)
scoreboard players set @s ct_session 7
scoreboard players set @s ct_paused 0
scoreboard players set @s it_win_epoch 42
scoreboard players set @s it_window 1
scoreboard players set @s it_total 0
scoreboard players set @s it_offer 0
scoreboard players set @s it_done 0
scoreboard players set @s it_sum 0
data merge entity @s {NoGravity:1b,Invisible:1b}
''')
        self.file('ir/card','''
tag @s add ir.fixture
tag @s add it.card
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s it_owner $(seat)
$scoreboard players set @s it_number $(value)
scoreboard players set @s it_slot 1
scoreboard players set @s it_used 0
data merge entity @s {data:{description:"已提交的描述"}}
''')
        c=self.setup()+self.choose(1,2)+self.score(player(1),'it_offer',2,'invite_recorded')+self.score(player(1),'it_done',0,'invite_needs_other_consent')+self.choose(2,1)
        c+=self.score(player(1),'it_sum',99,'pair_sum')+self.score(player(2),'it_sum',99,'partner_sum')+self.count('@e[tag=it.card,scores={ct_id=101,it_used=2}]',2,'only_pair_reveals')
        c+=self.score(C,'it_state',2,'unfinished_players_wait')+self.pair(3,4)
        for seat,score in ((1,2),(2,2),(3,1),(4,1)):c+=self.score(player(seat),'it_total',score,f'ranking_{seat}')
        c+=self.score(C,'it_state',3,'round_waits')+self.score(C,'it_timer',100,'round_delay')+[f'execute as {C} run function ito:red/check']
        c+=self.score(player(1),'it_total',2,'duplicate_check_does_not_award_twice')
        self.case('mutual_ranking',c)
        c=self.setup((40,60,41,58))+self.pair(1,2)
        c+=self.score(C,'it_state',4,'exact_100_finishes_immediately')+self.score(player(3),'it_done',0,'exact_100_does_not_require_other_pair')
        self.case('exact_100',c)
        c=self.setup((70,80,25,50))+self.pair(1,2)+self.pair(3,4)
        c+=self.score(player(1),'it_total',0,'overshoot_zero')+self.score(player(3),'it_total',2,'valid_pair_wins_overshoot')
        self.case('overshoot',c)
        c=self.setup((10,80,20,70,30,40))+self.pair(1,2)+self.pair(3,4)+self.pair(5,6)
        for seat,score in ((1,2),(3,2),(5,0)):c+=self.score(player(seat),'it_total',score,f'tie_competition_rank_{seat}')
        self.case('ties',c)
        c=self.setup()+self.choose(1)+self.choose(2)+self.pair(3,4)
        c+=self.score(player(1),'it_total',0,'solo_zero')+self.score(player(3),'it_total',2,'solo_remaining_pair_scores')+self.score(C,'it_state',3,'solo_round_can_finish')
        self.case('solo',c)
        c=self.setup()+[f'scoreboard players set {player(1)} it_total 4']+self.pair(1,2)+self.pair(3,4)
        c+=self.score(player(1),'it_total',6,'first_boat_points')+self.score(C,'it_state',3,'single_boat_keeps_playing')
        self.case('one_boat',c)
        c=self.setup()+[f'scoreboard players set {player(1)} it_total 4',f'scoreboard players set {player(2)} it_total 4']+self.pair(1,2)+self.pair(3,4)
        c+=self.score(C,'it_state',4,'second_boat_finishes')+self.count('@e[tag=ir.player,tag=ir.winner]',2,'two_boat_winners_only')
        c+=self.count('@e[tag=ir.player,tag=ir.winner,scores={it_seat=1..2}]',2,'highest_two_points_win')
        self.case('two_boats',c)
        c=self.setup()+[f'scoreboard players set {player(1)} it_total 4',f'execute as {player(1)} run function ito:red/open']
        c+=self.check('data storage ito:ui dialog.body[-1].contents{text:"你的累计分：4"}','dialog_score_is_static_text')
        c+=self.check('data storage ito:ui dialog.actions[0].label.extra[{text:"测试玩家"}]','dialog_player_name_is_resolved')
        self.case('dialog_components',c)
        for kind,mutation in (
            ('player_paused',f'scoreboard players set {player(1)} ct_paused 1'),
            ('table_paused',f'scoreboard players set {C} ct_paused 1'),
            ('stale_epoch',f'scoreboard players set {player(1)} it_win_epoch 41'),
            ('stale_session',f'scoreboard players set {player(1)} ct_session 6'),
            ('description_missing','data modify entity @e[tag=it.card,scores={ct_id=101,it_owner=4},limit=1] data.description set value ""'),
        ):
            c=self.setup()+[mutation]+self.choose(1,2)+self.score(player(1),'it_offer',0,kind+'_cannot_invite')+self.count('@e[tag=it.card,scores={ct_id=101,it_used=0}]',4,kind+'_keeps_hidden_cards')
            self.case(kind,c)
        c=self.setup((10,11))+self.setup((20,21),table=202,reset=False)+self.choose(1,2)+self.choose(1,2,202)
        c+=self.score(player(1),'it_offer',2,'table_a_offer')+self.score(player(1,202),'it_offer',2,'table_b_offer')+self.choose(2,1)
        c+=self.score(C,'it_state',3,'table_a_finishes_round')+self.score(D,'it_state',2,'table_b_keeps_waiting')+self.count('@e[tag=it.card,scores={ct_id=202,it_used=0}]',2,'other_table_cards_stay_hidden')
        self.case('cross_table',c)
        c=self.setup()+[f'scoreboard players set {player(1)} it_total 6',f'scoreboard players set {player(1)} it_offer 2',f'scoreboard players set {player(1)} it_done 1',f'scoreboard players set {player(1)} it_sum 99',f'scoreboard players set {player(1)} it_rank 2',f'tag {player(1)} add it.partner',f'tag {player(1)} add it.winner',f'execute as {player(1)} run function ito:player/clear_state']
        for field in ('it_total','it_offer','it_done','it_sum','it_rank'):
            c += [f'execute store success score #exists gt run scoreboard players get {player(1)} {field}']+self.score('#exists','gt',0,'cleanup_'+field)
        c+=self.count('@e[tag=ir.player,tag=it.partner]',0,'cleanup_partner_tag')+self.count('@e[tag=ir.player,tag=it.winner]',0,'cleanup_winner_tag')
        self.case('finished_rejoin_cleanup',c)
        c=self.setup()+[f'scoreboard players set {C} ct_paused 1',f'scoreboard players set {C} it_timer 63',f'scoreboard players set {player(1)} it_total 4',f'scoreboard players set {player(1)} it_offer 2',f'execute as {C} run function ito:system/reload']
        c+=self.score(C,'it_mode',1,'reload_keeps_red_mode')+self.score(C,'it_timer',63,'reload_keeps_pause_timer')+self.score(player(1),'it_total',4,'reload_keeps_points')+self.score(player(1),'it_offer',2,'reload_keeps_public_invite')
        self.case('reload',c)
        c=self.setup()+[f'scoreboard players set {C} it_round 4',f'execute as {C} at @s run function ito:round/begin']
        c+=self.count('@e[tag=it.card,scores={ct_id=101,it_owner=1..8,it_used=0}]',4,'late_red_round_still_one_card_each')+self.score(C,'it_mode',1,'late_round_keeps_mode')
        c+=self.score(C,'it_state',2,'late_round_ready')
        self.case('red_unlimited_rounds',c)
        objectives=re.findall(r'^scoreboard objectives add .+$',(PACK/'data/ito/function/load.mcfunction').read_text(encoding='utf-8'),re.M)
        objectives += [f'scoreboard objectives add {x} dummy' for x in ('ct_id','ct_game','ct_state','ct_session','ct_paused','ct_capacity','ct_joined','ct_seat','ct_start')]
        self.file('bootstrap',['forceload add 0 0 31 15','scoreboard objectives add gt dummy',*objectives,'scoreboard players set #hundred it_ctx 100','scoreboard players set #epoch it_ctx 42','scoreboard players set #four it_ctx 4','function ito:themes/load','schedule function guandan_test:case/'+self.cases[0]+' 2t'])
        self.file('finish',['kill @e[tag=ir.fixture]','say GUANDAN_FINISHED'])
        for i,name in enumerate(self.cases):self.files['case/'+name]+='schedule function guandan_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 2t\n'
        self.setup_ticks=len(self.cases)*2+220


if __name__=='__main__':
    if '--java' not in sys.argv:sys.argv+=['--java',JAVA]
    suite=Suite();suite.build();raise SystemExit(run(suite,isolated=True,prefix='fimel-ito-red-runtime-',prepare_target=fixture_hook))
