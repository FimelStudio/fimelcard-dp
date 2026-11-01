"""围棋真实座椅回归：四/八人桌、随机互换、单人人机、两桌隔离。"""
from test_weiqi_game import Suite as GameSuite, C, D, person, fixture_hook
from test_guandan_cards import run


SIDES={(4,0):((3,3),(1,1)),(4,1):((4,4),(2,2)),(8,0):((5,6),(1,2)),(8,1):((7,8),(3,4))}


class Suite(GameSuite):
    def mounted(self,p,side,bounds,key):
        target=person(p)
        out=self.score(target,'go_side',side,key+'_side')+self.score(target,'ct_seat',f'{bounds[0]}..{bounds[1]}',key+'_seat')
        out += ['scoreboard players set #mounted gt 0',f'execute as {target} on vehicle if entity @s[type=minecraft:interaction,tag=ct.seat,scores={{ct_id=101,ct_seat={bounds[0]}..{bounds[1]}}}] run scoreboard players set #mounted gt 1']
        return out+self.score('#mounted','gt',1,key+'_actual_vehicle')

    def sides(self,cap,orient,key):
        black,white=SIDES[cap,orient]
        out=self.score(C,'ct_start',1,key+'_started')+self.score(C,'go_turn',1,key+'_black_first')
        for side,bounds,field in ((1,black,'black'),(-1,white,'white')):
            p=f'@e[tag=wg.person,tag=go.player,scores={{go_table=101,go_side={side}}},limit=1]'
            out+=self.count(p,1,key+'_'+field+'_unique')+self.score(p,'ct_seat',f'{bounds[0]}..{bounds[1]}',key+'_'+field+'_seat')
            out+=self.check(f'score {p} ct_seat = {p} go_seat',key+'_'+field+'_synced')
            out+=self.check(f'score {C} go_{field} = {p} go_seat',key+'_'+field+'_ctrl_synced')
            out += ['scoreboard players set #mounted gt 0',f'execute as {p} on vehicle if entity @s[tag=ct.seat,scores={{ct_id=101,ct_seat={bounds[0]}..{bounds[1]}}}] run scoreboard players set #mounted gt 1']
            out+=self.score('#mounted','gt',1,key+'_'+field+'_actual_vehicle')
        out+=['scoreboard players set #same gt 0',f'execute if score {person(1)} ct_seat = {person(2)} ct_seat run scoreboard players set #same gt 1']+self.score('#same','gt',0,key+'_different_seats')
        out+=['scoreboard players set #riders gt 0','execute as @e[tag=ct.seat,scores={ct_id=101}] on passengers if entity @s[tag=wg.person] run scoreboard players add #riders gt 1']+self.score('#riders','gt',2,key+'_two_passengers')
        return out

    def build(self):
        self.prepare()
        for (cap,orient),(black,white) in SIDES.items():
            key=f'self_{cap}_{orient}'
            c=self.start(cap=cap,orient=orient,seats=(black[1],white[1]))
            c+=self.mounted(1,1,(black[1],black[1]),key+'_p1')+self.mounted(2,-1,(white[1],white[1]),key+'_p2')+self.sides(cap,orient,key)
            self.case(key,c)
            pairs=[(1,2),(black[0],white[0])]
            if cap==8:pairs +=[(black[0],black[1]),(white[0],white[1])]
            for i,seats in enumerate(pairs):
                key=f'random_{cap}_{orient}_{i}'
                c=self.start(cap=cap,orient=orient,mode=0,seats=seats)+self.sides(cap,orient,key)
                self.case(key,c)
            key=f'swap_{cap}_{orient}'
            c=self.start(cap=cap,orient=orient,seats=(black[1],white[1]))
            c += [f'scoreboard players set {person(1)} go_side -1',f'scoreboard players set {person(2)} go_side 1']+self.call('game/reseat')
            c+=self.mounted(1,-1,white,key+'_p1')+self.mounted(2,1,black,key+'_p2')+self.sides(cap,orient,key)
            self.case(key,c)
            # 旧坏存档模拟：两人被同一椅子挂载，reseat必须恢复。
            key=f'stacked_{cap}_{orient}'
            c=self.start(cap=cap,orient=orient,seats=(black[1],white[1]))
            c += [f'execute as {person(2)} run ride @s dismount',f'execute as {person(2)} run ride @s mount @e[tag=ct.seat,scores={{ct_id=101,ct_seat={black[1]}}},limit=1]']
            c+=self.call('game/reseat')+self.sides(cap,orient,key)
            self.case(key,c)
            # 重载不能重新抽阵营，也不能把时钟和超级劫历史清掉。
            key=f'reload_{cap}_{orient}'
            c=self.start(cap=cap,orient=orient,seats=(black[1],white[1]))+[f'scoreboard players set {C} go_turn -1',f'scoreboard players set {C} go_wtime 8844']
            c+=self.call('system/reload')+self.mounted(1,1,black,key+'_p1')+self.mounted(2,-1,white,key+'_p2')
            c+=self.score(C,'go_wtime',8844,key+'_clock')+self.score(C,'go_turn',-1,key+'_turn')
            self.case(key,c)
            for side,bounds,opponent in ((1,black,white),(-1,white,black)):
                key=f'solo_{cap}_{orient}_{side+1}'
                c=self.start(cap=cap,orient=orient,seats=(bounds[1],))
                c+=self.score(C,'ct_start',1,key+'_started')+self.score(C,'go_bot',-side,key+'_opposite_bot')+self.mounted(1,side,(bounds[1],bounds[1]),key)
                c+=self.call('system/heartbeat')+self.score(C,'go_state',1,key+'_heartbeat_alive')
                self.case(key,c)
        c=self.start()+self.setup(cap=8,orient=1,seats=(8,4),table=202,reset=False)+self.call('game/start',202)
        c += [f'scoreboard players set {person(1)} go_side -1',f'scoreboard players set {person(2)} go_side 1']+self.call('game/reseat')
        c+=self.score(person(3),'ct_seat',8,'isolation_other_black_seat')+self.score(person(4),'ct_seat',4,'isolation_other_white_seat')
        c+=self.score(D,'go_black',8,'isolation_ctrl_black')+self.score(D,'go_white',4,'isolation_ctrl_white')
        self.case('isolation',c)
        self.finish()


if __name__=='__main__':
    s=Suite();s.build();raise SystemExit(run(s,isolated=False,prefix='fimel-weiqi-seating-',prepare_target=fixture_hook))
