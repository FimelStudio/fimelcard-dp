"""原版 26.2 验证 UNO／飞行棋的回合道具与回合外响应。

临时世界用 marker 代表玩家。仅将背包读写桥接到测试分数，并扩展本桌
真人遍历；归属、回合、状态切换、旧窗口核验和 Dialog 宏使用生产函数。
真实客户端的手持尺寸和 Q 丢物仍需联机目测。
"""
from test_love_letter_engine import Suite as Base, run


def ctrl(game='uno', table=101):
    return f'@e[tag=tt.table,scores={{ct_id={table},ct_game={11 if game=="uno" else 15}}},limit=1]'


def player(seat=1, game='uno', table=101):
    return f'@e[tag=tt.player,scores={{ct_id={table},ct_game={11 if game=="uno" else 15},ct_seat={seat}}},limit=1]'


class Suite(Base):
    def call_game(self, game, function, table=101):
        return [f'execute as {ctrl(game,table)} at @s run function {game}:{function}']

    def actor(self, game, seat, function='input/give', table=101):
        return [f'execute as {player(seat,game,table)} at @s run function {game}:{function}']

    def setup_game(self, game='uno', table=101, reset=True):
        commands=['function love_letter_test:reset'] if reset else []
        commands += [f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:marker run function love_letter_test:table {{table:{table},game:{11 if game=="uno" else 15}}}']
        for seat in (1,3,7):
            commands += [f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:marker run function love_letter_test:player {{table:{table},seat:{seat},game:{11 if game=="uno" else 15},color:{(seat-1)//2}}}']
        return commands + self.call_game(game,'system/context',table)

    def build(self):
        self.file('reset',['kill @e[tag=tt.fixture]','scoreboard players set #responses tt 0',
                           'scoreboard players set #hands tt 0','scoreboard players set #granted tt 0'])
        self.file('table','''
tag @s add tt.fixture
tag @s add tt.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_game $(game)
scoreboard players set @s ct_state 1
scoreboard players set @s ct_capacity 8
scoreboard players set @s un_state 2
scoreboard players set @s un_turn 1
scoreboard players set @s un_epoch 100
scoreboard players set @s un_dir 1
scoreboard players set @s un_color 0
scoreboard players set @s un_top 0
scoreboard players set @s un_drew 0
scoreboard players set @s un_challenger 3
scoreboard players set @s un_pending 1
scoreboard players set @s un_count 7
scoreboard players set @s ac_state 1
scoreboard players set @s ac_turn 0
scoreboard players set @s ac_roll 1
scoreboard players set @s ac_epoch 100
scoreboard players set @s ac_pulse -100000
execute if score @s ct_game matches 11 run tag @s add un.controller
execute if score @s ct_game matches 15 run tag @s add ac.controller
''')
        self.file('player','''
tag @s add tt.fixture
tag @s add tt.player
tag @s add ct.player
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_game $(game)
$scoreboard players set @s ct_seat $(seat)
$scoreboard players set @s un_table $(table)
$scoreboard players set @s un_seat $(seat)
scoreboard players set @s un_pick -1
scoreboard players set @s un_count 7
scoreboard players set @s un_score 0
scoreboard players set @s tt_uno 0
$scoreboard players set @s ac_table $(table)
$scoreboard players set @s ac_seat $(seat)
$scoreboard players set @s ac_color $(color)
scoreboard players set @s tt_dice 0
scoreboard players set @s tt_menu 0
execute if score @s ct_game matches 11 run tag @s add un.player
execute if score @s ct_game matches 15 run tag @s add ac.player
''')
        for game,obj,turns in [('uno','un_turn',(1,3,7)),('aeroplane_chess','ac_turn',(0,1,3))]:
            commands=self.setup_game(game)+self.setup_game(game,202,False)
            for seat in (1,3,7):
                commands += self.actor(game,seat,table=202)
            for index,turn in enumerate(turns):
                commands += [f'scoreboard players set {ctrl(game)} {obj} {turn}']
                commands += self.call_game(game,'ui/refresh')
                for number,seat in enumerate((1,3,7)):
                    field='tt_uno' if game=='uno' else 'tt_dice'
                    commands += self.score(player(seat,game),field,int(number==index),f'{game}_turn{index}_seat{seat}')
                    if game!='uno':
                        commands += self.score(player(seat,game),'tt_menu',1,f'fly_menu_turn{index}_seat{seat}')
                    commands += self.score(player(seat,game,202),field,int(number==0),f'{game}_foreign_turn{index}_seat{seat}')
            commands += self.call_game(game,'ui/refresh')
            commands += self.score('#granted','tt',4,f'{game}_same_turn_does_not_reissue')
            self.case(game+'_rotation',commands)

        for state in (1,2,3,4,6,5,0):
            commands=self.setup_game('aeroplane_chess')
            commands += [f'scoreboard players set {ctrl("aeroplane_chess")} ac_state {state}']
            for seat in (1,3,7):
                commands += self.actor('aeroplane_chess',seat)
                commands += self.score(player(seat,'aeroplane_chess'),'tt_dice',int(seat==1 and state in (1,2,3,4,6)),f'fly_phase{state}_seat{seat}')
            self.case('fly_phase_'+str(state),commands)

        # 远端引入的逐刻恢复继续走真实资格判定，不重发已有骰子或菜单。
        game='aeroplane_chess'
        commands=self.setup_game(game)+self.setup_game(game,202,False)
        for table in (101,202):
            for seat in (1,3,7):commands += self.actor(game,seat,table=table)
        commands += [f'scoreboard players set {ctrl(game)} ac_turn 1',
                     f'scoreboard players set {ctrl(game)} ac_state 3']
        commands += self.call_game(game,'input/tick')
        for seat in (1,3,7):
            commands += self.score(player(seat,game),'tt_dice',int(seat==3),'tick_fly_own_'+str(seat))
            commands += self.score(player(seat,game,202),'tt_dice',int(seat==1),'tick_fly_foreign_'+str(seat))
        commands += self.score('#granted','tt',3,'tick_fly_turn_change_gives_once')
        commands += self.call_game(game,'input/tick')*3
        commands += self.score('#granted','tt',3,'tick_fly_existing_dice_not_reissued')
        commands += [f'scoreboard players set {player(3,game)} tt_dice 0']+self.call_game(game,'input/tick')
        commands += self.score(player(3,game),'tt_dice',1,'tick_fly_lost_dice_restored')
        commands += self.score('#granted','tt',4,'tick_fly_recovery_only_once')
        commands += [f'scoreboard players set {ctrl(game)} ct_state 0']+self.call_game(game,'input/tick')
        commands += self.score(player(3,game),'tt_dice',0,'tick_fly_lobby_removes_dice')
        commands += self.score(player(1,game,202),'tt_dice',1,'tick_fly_lobby_foreign_kept')
        self.case('fly_tick_recovery',commands)

        for state in (1,2,3,4,5):
            commands=self.setup_game()
            commands += [f'scoreboard players set {ctrl()} un_state {state}']
            for seat in (1,3,7):
                commands += [f'scoreboard players set {player(seat)} tt_uno 1']+self.actor('uno',seat)
                commands += self.score(player(seat),'tt_uno',int(seat==1 and state==2),f'uno_phase{state}_seat{seat}')
            self.case('uno_phase_'+str(state),commands)

        for state,expected in ((3,3),(4,1)):
            commands=self.setup_game()+[f'scoreboard players set {ctrl()} un_state {state}']
            commands += self.call_game('uno','ui/refresh')
            commands += self.score('#responses','tt',expected,f'response_phase{state}_recipients')
            for seat in (1,3,7):
                commands += self.score(player(seat),'tt_uno',0,f'response_phase{state}_no_tool{seat}')
            commands += self.check(f'data storage uno:ui controls[0].action',f'response_phase{state}_actions_present')
            self.case('response_'+str(state),commands)

        commands=self.setup_game()+[f'scoreboard players set {ctrl()} un_state 3']+self.call_game('uno','ui/refresh')
        for seat,code in ((1,5),(3,6),(7,6)):
            commands += self.actor('uno',seat,'ui/response_prepare')
            commands += self.check(f'data storage uno:ui controls[{{action:{{command:"trigger un_action set {100000+code}"}}}}]',f'response_correct_action_seat{seat}')
            commands += self.score(player(seat),'un_seen',100,f'response_epoch_seat{seat}')
        commands += [f'scoreboard players set {ctrl()} un_state 4']+self.actor('uno',3,'ui/response_prepare')
        for code in (7,8):
            commands += self.check(f'data storage uno:ui controls[{{action:{{command:"trigger un_action set {100000+code}"}}}}]',f'plus4_response_code{code}')
        self.case('response_buttons',commands)

        # 旧的回合外聊天链接同样经过 epoch 核验，不能抓到下一轮的 UNO。
        commands=self.setup_game()+[f'scoreboard players set {ctrl()} un_state 3']+self.call_game('uno','ui/refresh')
        commands += [f'scoreboard players set {ctrl()} un_epoch 101',f'scoreboard players set {player(3)} un_action 100006']
        commands += self.actor('uno',3,'input/submit')
        commands += self.score(ctrl(),'un_state',3,'old_response_keeps_phase')
        commands += self.score(ctrl(),'un_epoch',101,'old_response_keeps_epoch')
        commands += self.score(player(1),'un_count',7,'old_response_no_penalty')
        self.case('old_response',commands)

        # 重载入口必须只恢复当前行动方道具；第二桌和现有 HUD 不受影响。
        commands=self.setup_game()+self.setup_game('uno',202,False)
        commands += [f'scoreboard players set {ctrl()} un_turn 7']
        for table in (101,202):
            commands += self.call_game('uno','system/context',table)
            for seat in (1,3,7):commands += self.actor('uno',seat,table=table)
        commands += self.call_game('uno','system/reload')
        for seat in (1,3,7):
            commands += self.score(player(seat),'tt_uno',int(seat==7),'reload_uno_seat'+str(seat))
            commands += self.score(player(seat,'uno',202),'tt_uno',int(seat==1),'reload_uno_foreign'+str(seat))
        self.case('reload_uno',commands)

        self.file('finish',['function love_letter_test:reset','say LOVELETTER_FINISHED'])
        self.file('bootstrap',['forceload add -16 -16 63 31','scoreboard objectives add lt dummy','scoreboard objectives add tt dummy',
             'scoreboard objectives add tt_uno dummy','scoreboard objectives add tt_dice dummy','scoreboard objectives add tt_menu dummy',
             'schedule function love_letter_test:case/'+self.cases[0]+' 20t'])
        for index,name in enumerate(self.cases):
            self.files['case/'+name]+='schedule function love_letter_test:'+('case/'+self.cases[index+1] if index+1<len(self.cases) else 'finish')+' 1t\n'


def prepare_target(target):
    # GameTest 没有可持背包的真人；仅桥接物品存取，不替换判断或生命周期。
    for game in ('uno','aeroplane_chess'):
        root=target/f'data/{game}/function'
        for path in root.rglob('*.mcfunction'):
            lines=[]
            for line in path.read_text(encoding='utf-8').splitlines():
                if not any(word in line for word in ('tellraw ','dialog ','title ','playsound ','clear @','give @','item replace')):
                    line=line.replace('@a[','@e[')
                lines.append(line)
            path.write_text('\n'.join(lines)+'\n',encoding='utf-8')
    path=target/'data/uno/function/input/give.mcfunction'
    text=path.read_text(encoding='utf-8').replace('clear @s minecraft:purple_dye[minecraft:custom_data~{uno:{tool:1b}}] 0','scoreboard players get @s tt_uno')
    text=text.replace('clear @s minecraft:purple_dye[minecraft:custom_data~{uno:{tool:1b}}]','scoreboard players set @s tt_uno 0')
    path.write_text(text,encoding='utf-8')
    (path.parent/'give_tool.mcfunction').write_text('scoreboard players set @s tt_uno 1\nscoreboard players add #granted tt 1\n',encoding='utf-8')
    root=target/'data/aeroplane_chess/function/input'
    for name in ('give','tools','sync_turn_tool','ensure_turn_tool'):
        path=root/(name+'.mcfunction')
        text=path.read_text(encoding='utf-8')
        for item in ('minecraft:paper','*'):
            text=text.replace(f'clear @s {item}[minecraft:custom_data~{{aeroplane_chess:{{tool:1b,action:1,table:$(table)}}}}] 0','scoreboard players get @s tt_dice')
            text=text.replace(f'clear @s {item}[minecraft:custom_data~{{aeroplane_chess:{{tool:1b,action:0,table:$(table)}}}}] 0','scoreboard players get @s tt_menu')
            text=text.replace(f'clear @s {item}[minecraft:custom_data~{{aeroplane_chess:{{tool:1b,action:1}}}}]','scoreboard players set @s tt_dice 0')
        # 计数行的唯一宏参数原本在物品谓词内，桥接后转回普通命令。
        text='\n'.join(line[1:] if line.startswith('$') and '$(' not in line else line for line in text.splitlines())+'\n'
        path.write_text(text,encoding='utf-8')
    (root/'place.mcfunction').write_text('''$scoreboard players set #place tt $(action)
execute if score #place tt matches 1 run scoreboard players set @s tt_dice 1
execute if score #place tt matches 1 run scoreboard players add #granted tt 1
execute if score #place tt matches 0 run scoreboard players set @s tt_menu 1
''',encoding='utf-8')
    for name,score in [('ui/response_show','responses'),('ui/show','hands')]:
        path=target/f'data/uno/function/{name}.mcfunction'
        path.write_text(path.read_text(encoding='utf-8')+f'scoreboard players add #{score} tt 1\n',encoding='utf-8')


if __name__=='__main__':
    suite=Suite();suite.build()
    raise SystemExit(run(suite,isolated=False,prefix='fimel-turn-tools-',prepare_target=prepare_target))
