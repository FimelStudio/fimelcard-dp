"""独立原版26.2验证五子棋SK胜利烟花、电脑座位、幂等结算及两桌清理。"""
from test_gomoku import Suite as BaseSuite, A, B, PACK, person, run


def rocket(table=101):
    return f'@e[type=minecraft:firework_rocket,tag=gm.firework,scores={{ct_id={table}}},limit=1]'


SEATS={4:[(0,-2),(2,0),(0,2),(-2,0)],8:[(-1,-2.5),(1,-2.5),(2.5,-1),(2.5,1),(1,2.5),(-1,2.5),(-2.5,1),(-2.5,-1)]}
SIDES={(4,0):(3,1),(4,1):(4,2),(8,0):(6,2),(8,1):(8,4)}


class Suite(BaseSuite):
    def setup(self,cap=4,size=15,table=101,reset=True):
        # execute positioned整数X/Z会自动补0.5；显式小数才是本测试的精确桌心。
        origin=8 if table==101 else 40
        return [line.replace(f'execute positioned {origin} 64 8',f'execute positioned {origin}.0 64.0 8.0') for line in super().setup(cap,size,table,reset)]

    def firework_count(self,number,name,table=101):
        return self.count(f'@e[type=minecraft:firework_rocket,tag=gm.firework,scores={{ct_id={table}}}]',number,name)

    def position(self,table,xyz,name):
        # 实体位置经引擎NBT读取后存在浮点舍入；容差一微格，不比较double位模式。
        c=[f'execute store result score #rocket_{axis} gg run data get entity {rocket(table)} Pos[{index}] 1000000' for index,axis in enumerate('xyz')]
        bounds=[round(value*1000000) for value in xyz]
        condition=' if '.join(f'score #rocket_{axis} gg matches {value-1}..{value+1}' for axis,value in zip('xyz',bounds))
        c+=['scoreboard players set #position_ok gg 0',f'execute if {condition} run scoreboard players set #position_ok gg 1']
        return c+self.score('#position_ok','gg',1,name)

    def finish(self,result=1,table=101):
        return [f'scoreboard players set {A if table==101 else B} gm_result {result}']+self.call('game/finish',table)

    def bot(self,cap,orient,side,chairs=True,table=101,reset=True):
        target=A if table==101 else B;black,white=SIDES[cap,orient]
        c=self.setup(cap=cap,table=table,reset=reset)+[
            f'scoreboard players set {target} gm_orient {orient}',f'scoreboard players set {target} gm_bot {side}',
            f'scoreboard players set {target} gm_black {black}',f'scoreboard players set {target} gm_white {white}',
            f'tag {person(side,table)} remove gm.player']
        if chairs:c += [f'execute as {target} at @s run function cardtable:table/ensure_seats']
        return c

    def build(self):
        super().build()
        self.files={name:body for name,body in self.files.items() if name in ('table','person','reset','dialogs','bootstrap','finish')}
        self.files['reset']+='kill @e[type=minecraft:firework_rocket,tag=gm.firework]\nkill @e[tag=ct.seat]\n'
        self.cases=[];self.expected=[]
        for cap in (4,8):
            for side,result,xyz in [(1,1,(11.25,66.0,10.5)),(-1,2,(5.75,65.25,4.5))]:
                name=f'human_{cap}_{side+1}'
                c=self.setup(cap=cap)+[f'tp {person(side)} '+ ' '.join(str(v) for v in xyz)]+self.finish(result)
                c+=self.firework_count(1,name+'_one_rocket')+self.position(101,(xyz[0],xyz[1]+1,xyz[2]),name+'_winner_position')
                c+=self.score(A,'gm_state',4,name+'_locks_result')+self.score(A,'gm_timer',100,name+'_starts_five_seconds')
                c+=self.count('@e[type=minecraft:firework_rocket,tag=gm.firework.new]',0,name+'_temporary_tags_removed')
                c+=self.check(f'data entity {rocket()} {{LifeTime:20}}',name+'_sk_lifetime')
                c+=[f'scoreboard players set {A} gm_timer 37',f'scoreboard players operation #finish_epoch gg = {A} gm_epoch']+self.call('game/finish')
                c+=self.firework_count(1,name+'_repeat_no_rocket')+self.score(A,'gm_timer',37,name+'_repeat_keeps_timer')
                c+=self.check(f'score {A} gm_epoch = #finish_epoch gg',name+'_repeat_keeps_epoch')
                c+=self.call('game/result_tick')+self.call('game/finish')+self.score(A,'gm_timer',36,name+'_countdown_continues')
                self.case(name,c)
        for (cap,orient),(black,white) in SIDES.items():
            for side in (1,-1):
                for chairs in (True,False):
                    name=f'bot_{cap}_{orient}_{side+1}_{int(chairs)}'
                    seat=black if side==1 else white;x,z=SEATS[cap][seat-1]
                    c=self.bot(cap,orient,side,chairs)+self.finish(1 if side==1 else 2)
                    c+=self.firework_count(1,name+'_one_rocket')+self.position(101,(8+x,65.32,8+z),name+'_correct_seat')
                    c+=self.count('@e[type=minecraft:firework_rocket,tag=gm.firework.new]',0,name+'_no_temporary_tag')
                    self.case(name,c)
        c=self.setup()+self.finish(3)+self.firework_count(0,'draw_no_rocket')+self.score(A,'gm_state',4,'draw_locks_result')
        c+=[f'scoreboard players set {A} gm_timer 23']+self.call('game/finish')+self.score(A,'gm_timer',23,'draw_repeat_keeps_timer')
        self.case('draw',c)
        c=self.setup()+self.finish(0)+self.firework_count(0,'invalid_result_no_rocket')+self.score(A,'gm_state',1,'invalid_result_keeps_playing')
        c+=[f'scoreboard players set {A} gm_state 0']+self.finish(1)+self.firework_count(0,'lobby_no_rocket')+self.score(A,'gm_state',0,'lobby_keeps_state')
        self.case('invalid',c)
        c=self.bot(4,0,1)+self.bot(8,1,-1,table=202,reset=False)+self.finish(1)+self.finish(2,202)
        c+=self.firework_count(1,'isolation_a_rocket')+self.firework_count(1,'isolation_b_rocket',202)
        c+=self.position(101,(8,65.32,10),'isolation_a_position')+self.position(202,(42.5,65.32,9),'isolation_b_position')
        c+=self.call('game/remove')+self.firework_count(0,'remove_clears_own_rocket')+self.firework_count(1,'remove_keeps_other_rocket',202)
        c+=self.score(B,'gm_state',4,'remove_keeps_other_result')+self.score(B,'gm_timer',100,'remove_keeps_other_timer')
        c+=self.call('game/cleanup',202)+self.firework_count(0,'cleanup_clears_own_rocket',202)
        self.case('isolation',c)
        self.case('dialogs',['function gomoku_game_test:dialogs'])
        self.file('bootstrap',['forceload add -16 -16 63 31','scoreboard objectives add gg dummy','function gomoku:load','schedule function gomoku_game_test:case/'+self.cases[0]+' 40t'])
        for index,name in enumerate(self.cases):
            self.files['case/'+name]+='schedule function gomoku_game_test:'+('case/'+self.cases[index+1] if index+1<len(self.cases) else 'finish')+' 2t\n'


if __name__=='__main__':
    suite=Suite();suite.build()
    raise SystemExit(run(suite,prefix='fimel-gomoku-finish-',setup_ticks=300,manual_tick=True))
