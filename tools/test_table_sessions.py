"""原版26.2公共会话测试：盔甲架桥接在线玩家，生产会话/清理/投票/发牌函数不替换。"""
from pathlib import Path
import re
import subprocess
import sys

from test_love_letter_engine import Suite as Base, run
from build_table_sessions import GAMES

C = '@e[tag=ts.table,scores={ct_id=101},limit=1]'
D = '@e[tag=ts.table,scores={ct_id=202},limit=1]'


def player(seat=1, table=101):
    return f'@e[tag=ts.player,scores={{ct_id={table},ct_seat={seat}}},limit=1]'


class Suite(Base):
    def setup(self, game=11, table=101, reset=True):
        lines = ['function love_letter_test:reset'] if reset else []
        lines += [f'execute positioned {8 if table==101 else 40} 64 8 summon minecraft:marker run function love_letter_test:table {{table:{table},game:{game}}}']
        pre = GAMES[game-1][1]
        for seat in (1, 3):
            lines += [f'execute positioned {8 if table==101 else 40} 64 8 summon minecraft:armor_stand run function love_letter_test:player {{table:{table},seat:{seat}}}',
                      f'tag {player(seat,table)} add {pre}.player']
        return lines + [f'execute as {C if table==101 else D} at @s run function cardtable:session/start']

    def call(self, name, table=101):
        return [f'execute as {C if table==101 else D} at @s run function cardtable:{name}']

    def tick(self):
        return ['function cardtable:session/pre_tick']

    def build(self):
        self.file('reset', ['kill @e[tag=ts.fixture]', 'kill @e[tag=ct.part]', 'tag @e[tag=ts.player] remove ct.player'])
        self.file('table', '''
tag @s add ts.fixture
tag @s add ts.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_game $(game)
scoreboard players set @s ct_state 1
scoreboard players set @s ct_capacity 8
scoreboard players set @s ct_joined 2
scoreboard players set @s ct_chairs 8
scoreboard players set @s ct_paused 0
scoreboard players set @s ct_votes 0
''')
        self.file('player', '''
tag @s add ts.fixture
tag @s add ts.player
data merge entity @s {NoGravity:1b,Invisible:1b}
tag @s add ts.online
tag @s add ct.player
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_seat $(seat)
scoreboard players set @s ct_online 1
scoreboard players set @s ct_voted 0
''')
        for game, (namespace, pre) in enumerate(GAMES, 1):
            key = f'g{game}'
            c = self.setup(game) + self.setup(game,202,False)
            c += self.score(C,'ct_expected',2,key+'_humans_only')
            c += self.check(f'score {player()} ct_session = {C} ct_session',key+'_member_session')
            c += self.check(f'data entity {C} data.cardtable.members[1].uuid',key+'_persistent_roster')
            c += self.check(f'score {C} ct_session < {D} ct_session',key+'_unique_sessions')
            c += [f'tag {player(3)} remove ts.online'] + self.tick()
            c += self.score(C,'ct_paused',1,key+'_disconnect_pauses')
            c += self.score(C,'ct_expected',2,key+'_offline_still_expected')
            c += self.score(player(),'ct_paused',1,key+'_input_paused')
            c += self.score(D,'ct_paused',0,key+'_other_table_runs')
            c += self.score(C,'ct_state',1,key+'_still_votable_game')
            c += self.tick()*3 + self.score(C,'ct_paused',1,key+'_wait_indefinitely')
            c += [f'tag {player(3)} add ts.online'] + self.tick()
            c += self.score(C,'ct_paused',0,key+'_returns_resume')
            c += self.score(player(3),'ct_paused',0,key+'_member_resumes')
            c += self.check(f'entity {player(3).replace("tag=ts.player","tag=ts.player,tag="+pre+".player")}',key+'_retains_game_identity')
            c += self.check(f'entity {player(3).replace("tag=ts.player","tag=ts.player,tag=!ct.rejoining")}',key+'_rejoin_completed')
            c += ['scoreboard players set #mounted lt 0',f'execute as {player(3)} on vehicle if score @s ct_id matches 101 if score @s ct_seat matches 3 run scoreboard players set #mounted lt 1']
            c += self.score('#mounted','lt',1,key+'_restored_original_seat')
            self.case(key+'_reconnect',c)

            # 游戏在此人离线期间结束：重连清理原局，绝不结束一局新游戏。
            c = self.setup(game) + [f'tag {player(3)} remove ts.online'] + self.tick()
            c += self.call('session/end') + [f'scoreboard players set {C} ct_state 0']
            c += [f'tag {player(3)} add ts.online'] + self.tick()
            c += self.check('entity @e[tag=ts.player,tag=!ct.player,tag=!'+pre+'.player,limit=1]',key+'_stale_identity_cleared')
            c += ['execute store success score #stale lt run scoreboard players get @e[tag=ts.player,tag=!ct.player,limit=1] ct_session']
            c += self.score('#stale','lt',0,key+'_stale_score_gone')
            c += self.score(C,'ct_state',0,key+'_stays_in_lobby')
            self.case(key+'_ended',c)

        c = self.setup(7)
        c += [f'tag {C} add cp.controller',f'scoreboard players set {C} cp_id 101',
              f'scoreboard players set {player(3)} cp_id 101',f'tag {player(3)} remove ts.online'] + self.tick()
        c += self.call('session/end') + self.call('session/start')
        c += [f'tag {player(3)} add ts.online'] + self.tick()
        c += self.score(C,'ct_state',1,'old_critical_player_does_not_abort_new_game')
        c += self.score(C,'ct_expected',1,'new_session_only_its_members')
        c += self.score(C,'ct_paused',0,'old_player_does_not_join_new_session')
        c += self.count('@e[tag=ts.player,tag=ct.player]',1,'old_player_removed_from_new_table')
        self.case('new_round_isolation',c)

        for game in (2,9):
            namespace,pre=GAMES[game-1]
            c=self.setup(game)
            c += [f'execute as {player(3)} run function {namespace}:player/eliminate'] + self.tick()
            c += self.score(C,'ct_expected',1,f'elimination_g{game}_removes_expected_member')
            c += self.score(C,'ct_paused',0,f'elimination_g{game}_does_not_pause')
            c += self.count('@e[tag=ts.player,tag=ct.player]',1,f'elimination_g{game}_releases_seat')
            self.case(f'elimination_g{game}',c)

        c = self.setup() + [f'tag {player(3)} remove ts.online'] + self.tick()
        c += [f'scoreboard players set {player()} ct_voted 1'] + self.call('vote/count')
        c += self.score('#vote_players','ct_ctx',1,'paused_vote_counts_online')
        c += self.score('#vote_need','ct_ctx',1,'paused_vote_can_end_with_one_online')
        c += self.score(C,'ct_votes',1,'paused_vote_preserves_cast')
        self.case('paused_vote',c)

        c = self.setup() + [f'tag {player()} remove ts.online',f'tag {player(3)} remove ts.online'] + self.tick()
        c += self.score(C,'ct_paused',1,'all_offline_paused')
        c += [f'tag {player()} add ts.online'] + self.tick()
        c += self.score(C,'ct_paused',1,'partial_return_still_paused')
        c += [f'tag {player(3)} add ts.online'] + self.tick()
        c += self.score(C,'ct_paused',0,'all_return_resume')
        self.case('all_offline',c)

        c = self.setup() + [f'tag {player(3)} remove ts.online'] + self.tick()
        c += ['summon minecraft:item 8 65 8 {Tags:["ts.flight"],Item:{id:"minecraft:paper",count:1}}','execute as @e[tag=ts.flight,limit=1] run function love_letter_test:flight']
        c += ['execute as @e[tag=ts.flight] at @s run function cardtable:session/deal_tick']*25
        c += self.score('@e[tag=ts.flight,limit=1]','ct_anim',2,'paused_flight_counter_frozen')
        c += self.check('data entity @e[tag=ts.flight,limit=1] {NoGravity:1b,PickupDelay:32767s,Age:0s}','paused_flight_frozen')
        c += self.count('@e[tag=ts.flight]',1,'paused_flight_not_deleted')
        c += [f'tag {player(3)} add ts.online'] + self.tick()
        c += ['execute as @e[tag=ts.flight] at @s run function cardtable:session/deal_tick']
        c += self.count('@e[tag=ts.flight]',0,'resume_visual_flight_delivered_once')
        self.case('inflight_cards',c)
        self.file('flight', '''
tag @s add ts.fixture
tag @s add ts.flight
tag @s add ct.dealt_card
tag @s add ct.visual_only
scoreboard players set @s ct_id 101
scoreboard players set @s ct_seat 3
scoreboard players set @s ct_anim 2
data merge entity @s {Item:{id:"minecraft:paper",count:1},Motion:[0.1d,0.1d,0.1d],PickupDelay:32767s}
''')
        # 控制器暂未载入时依据持久会话注册表等待，不能按短超时误清。
        c = self.setup() + [f'tag {player(3)} remove ts.online'] + self.tick()
        c += [f'execute as {player()} run function cardtable:seat/remove_player',f'kill {C}',f'tag {player(3)} add ts.online'] + self.tick()
        c += self.count('@e[tag=ts.player,tag=ct.rejoining]',1,'missing_table_load_grace')
        c += self.tick()*40
        c += self.count('@e[tag=ts.player,tag=ct.player]',1,'unloaded_table_still_waiting')
        c += [f'execute as {player(3)} run function cardtable:session/mark_ended'] + self.tick()
        c += self.count('@e[tag=ts.player,tag=ct.player]',0,'ended_unloaded_table_rejoin_cleared')
        self.case('removed_table',c)
        self.file('finish',['function love_letter_test:reset','say LOVELETTER_FINISHED'])
        self.file('bootstrap',['forceload add -16 -16 63 31','scoreboard objectives add lt dummy',
                               'schedule function love_letter_test:case/'+self.cases[0]+' 2t'])
        for index,name in enumerate(self.cases):
            nxt = 'case/'+self.cases[index+1] if index+1<len(self.cases) else 'finish'
            self.files['case/'+name] += f'schedule function love_letter_test:{nxt} 1t\n'


def fixture_hook(target):
    # 只桥接在线选择器；骑乘/传送保留实际执行；其他生产逻辑完整载入。
    paths = list((target/'data/cardtable/function').rglob('*.mcfunction'))
    for namespace,_ in GAMES:
        paths += list((target/f'data/{namespace}/function/player').rglob('clear*.mcfunction'))
    for p in paths:
        text = p.read_text(encoding='utf-8')
        text = re.sub(r'@a\[', '@e[tag=ts.player,tag=ts.online,',text)
        text = re.sub(r'@a(?![a-z_\[])','@e[tag=ts.player,tag=ts.online]',text)
        # tellraw/title/dialog等命令只接受玩家目标。用as桥接保留命令编译，
        # 测试替身的客户端显示指令自然返回失败，不替换会话业务逻辑。
        selector_pattern = r'(@e\[(?:[^\[\]]|\[[^\]]*\])*\])'
        text = re.sub(r'\b(tellraw|title|dialog clear|dialog show|stopsound|give|clear) '+selector_pattern,
                      lambda m: 'execute as '+m[2]+' run '+m[1]+' @s',text)
        text = re.sub(r'\b(playsound \S+ \S+) '+selector_pattern,
                      lambda m: 'execute as '+m[2]+' run '+m[1]+' @s',text)
        p.write_text(text,encoding='utf-8')



if __name__=='__main__':
    if '--java' not in sys.argv:
        sys.argv += ['--java','C:/Temp/fimel-java25-validation/jdk-25.0.5+8-jre/bin/java.exe']
    real_run=subprocess.run
    def heap(command,*args,**kwargs):
        if len(command)>1 and str(command[1]).startswith('@'):
            p=Path(str(command[1])[1:])
            p.write_text(p.read_text(encoding='utf-8').replace('-Xmx1536M','-Xmx3072M'),encoding='utf-8')
        return real_run(command,*args,**kwargs)
    subprocess.run=heap
    suite=Suite();suite.build()
    raise SystemExit(run(suite,isolated=False,prefix='fimel-table-sessions-',prepare_target=fixture_hook))
