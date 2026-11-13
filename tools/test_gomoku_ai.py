"""隔离原版 26.2 验收五子棋三档人机、169/225/361 点边界和双桌搜索。"""
import test_gomoku_engine as base
from test_gomoku_engine import C,D,cell


class Suite(base.Suite):
    namespace='gomoku_ai_test'
    token='GOMOKU_AI'
    setup_ticks=3000
    def search(self,name,commands,checks,tables=(101,),side=1,limit=180):
        self.cases.append(name)
        commands+=['scoreboard players set #ticks ge 0']
        for table in tables:
            target=C if table==101 else D
            commands += [f'scoreboard players set {target} gm_bot {side}',f'scoreboard players set {target} gm_turn {side}']+self.call('ai/reset',table)
        self.file('case/'+name,commands+[f'schedule function {self.namespace}:wait/{name} 1t'])
        self.wait(name,checks,tables,limit)
    def wait(self,name,checks,tables=(101,),limit=180):
        wait=['scoreboard players add #ticks ge 1']
        for table in tables:
            target=C if table==101 else D
            wait += [f'execute if score {target} gm_moves = #before_{table} ge run function {self.namespace}:probe/{name}_{table}']
            self.file(f'probe/{name}_{table}',self.call('ai/tick',table))
        wait += [f'execute if score #ticks ge matches {limit}.. run return run function {self.namespace}:done/{name}','scoreboard players set #running ge 0']
        for table in tables:
            target=C if table==101 else D
            wait += [f'execute if score {target} gm_moves = #before_{table} ge unless score {target} gm_state matches 4 run scoreboard players set #running ge 1']
        wait += [f'execute if score #running ge matches 1 run return run schedule function {self.namespace}:wait/{name} 1t',f'function {self.namespace}:done/{name}']
        self.file('wait/'+name,wait)
        self.file('done/'+name,self.score('#ticks','ge',f'..{limit-1}',name+'_bounded')+checks)
    def snapshot_count(self,tables=(101,)):
        lines=[]
        for table in tables:
            target=C if table==101 else D
            lines.append(f'scoreboard players operation #before_{table} ge = {target} gm_moves')
        return lines
    def build(self):
        self.fixtures()
        for size in (13,15,19):
            for level in (1,2,3):
                name=f'opening_{size}_{level}';middle=(size//2)*19+size//2
                c=self.setup(size)+[f'scoreboard players set {C} gm_level {level}']+self.snapshot_count()
                checks=self.score(cell(middle),'gm_piece',1,name+'_center')+self.score(C,'gm_turn',-1,name+'_white_turn')+self.score(C,'gm_aistate',0,name+'_consumed')+self.check(f'data entity {C} data.gomoku.undo{{saved:1b}}',name+'_snapshot')
                self.search(name,c,checks)
        line=7*19
        for side in (1,-1):
            for level in (1,2,3):
                for kind in ('win','block','gap'):
                    own=side if kind!='block' else -side
                    columns=(4,5,7,8) if kind=='gap' else (4,5,6,7)
                    pieces={line+f:own for f in columns}
                    pieces[line+3]=-own
                    target=line+6 if kind=='gap' else line+8
                    name=f'{kind}_{side+1}_{level}'
                    c=self.setup(19,pieces,turn=side)+[f'scoreboard players set {C} gm_level {level}']+self.snapshot_count()
                    checks=self.score(cell(target),'gm_piece',side,name+'_target')+self.score(C,'gm_turn',-side,name+'_turn')+self.check(f'data entity {C} data.gomoku.last{{sq:{target},side:{side}}}',name+'_metadata')
                    if kind!='block':checks+=self.call('engine/evaluate')+self.score(C,'gm_result',1 if side==1 else 2,name+'_wins')
                    self.search(name,c,checks,side=side)
        # An immediate win takes priority over an opponent's simultaneous threat.
        pieces={line+f:1 for f in (4,5,6,7)}|{line+3:-1}|{4*19+f:-1 for f in (3,4,5,6)}|{4*19+2:1}
        for level in (1,2,3):
            name=f'win_priority_{level}'
            c=self.setup(19,pieces)+[f'scoreboard players set {C} gm_level {level}']+self.snapshot_count()
            self.search(name,c,self.score(cell(line+8),'gm_piece',1,name+'_wins'))
        # Levels use different scoring; only temporary cache fields change.
        center=7*19+7
        pieces={center-1:1,center-2:1,center-19:1,center-38:1,0:-1}
        c=self.setup(19,pieces)+self.call('engine/cache')+[f'scoreboard players set {C} gm_level 1']+self.call(f'ai/score/{center}')
        c+=self.score('#score','gm_ctx','0..100','easy_random_score')+[f'scoreboard players set {C} gm_level 2']+self.call(f'ai/score/{center}')
        c+=self.score('#score','gm_ctx','48000..','normal_shape_score')+['scoreboard players operation #normal ge = #score gm_ctx',f'scoreboard players set {C} gm_level 3']+self.call(f'ai/score/{center}')
        c+=self.check('score #score gm_ctx > #normal ge','hard_fork_bonus')+self.score(cell(center),'gm_piece',0,'score_does_not_place')+self.score(C,'gm_moves',5,'score_keeps_move_count')
        self.case('difficulty_scores',c)
        # Verify real hard search has entered reply analysis after the first pass,
        # and that the hypothetical root is absent from actual entity scores.
        c=self.setup(19,{center:1,center+19:-1})+[f'scoreboard players set {C} gm_bot 1',f'scoreboard players set {C} gm_level 3']+self.call('ai/reset')
        self.cases.append('reply_and_cancel')
        self.file('case/reply_and_cancel',c+['scoreboard players set #ticks ge 0',f'schedule function {self.namespace}:wait/reply_and_cancel 1t'])
        # Search work must be paced exactly like production: one AI tick per
        # server tick, rather than 40 complete batches in a single command chain.
        self.file('wait/reply_and_cancel',['scoreboard players add #ticks ge 1']+self.call('ai/tick')+[
            f'execute if data entity {C} data.gomoku.ai{{stage:2}} run return run function {self.namespace}:done/reply_and_cancel',
            f'execute if score #ticks ge matches 90.. run return run function {self.namespace}:done/reply_and_cancel',
            f'schedule function {self.namespace}:wait/reply_and_cancel 1t'])
        c=self.score('#ticks','ge','..89','reply_stage_bounded')+self.check(f'data entity {C} data.gomoku.ai{{stage:2}}','hard_enters_reply_search')+self.score(C,'gm_moves',2,'reply_search_nonmutating')+self.score(C,'gm_turn',1,'reply_search_keeps_turn')
        c+=[f'scoreboard players add {C} gm_epoch 1']+self.call('ai/tick')+self.score(C,'gm_aistate',0,'epoch_cancels')+self.score(C,'gm_moves',2,'cancel_no_move')
        c+=self.call('ai/tick')+[f'scoreboard players set {C} gm_bot 0']+self.call('ai/tick')+self.score(C,'gm_aistate',0,'human_mode_cancels')
        c+=[f'scoreboard players set {C} gm_bot 1']+self.call('ai/tick')+[f'scoreboard players set {C} ct_state 0']+self.call('ai/tick')+self.score(C,'gm_aistate',0,'lobby_cancels')
        self.file('done/reply_and_cancel',c)
        # Both controllers run consecutively in each tick, sharing only scratch
        # globals. A 19-board hard search must not consume the default chain limit.
        c=self.setup(19,{center:1,center+19:-1})+self.setup(19,{center-1:1,center-20:-1},table=202,reset=False)
        c += [f'scoreboard players set {C} gm_level 3',f'scoreboard players set {D} gm_level 3']+self.snapshot_count((101,202))
        checks=self.score(C,'gm_moves',3,'isolation_a_moved')+self.score(D,'gm_moves',3,'isolation_b_moved')+self.score(C,'gm_turn',-1,'isolation_a_turn')+self.score(D,'gm_turn',-1,'isolation_b_turn')
        checks+=self.score(cell(center+19),'gm_piece',-1,'isolation_a_original')+self.score(cell(center-20,202),'gm_piece',-1,'isolation_b_original')
        self.search('two_hard_19',c,checks,tables=(101,202))
        # A nearly full board cannot make hard search choose an absent second or
        # third root; a full board must finish safely without inventing a move.
        for size in (13,15,19):
            board={r*19+f:(1 if (f+2*r)%4<2 else -1) for r in range(size) for f in range(size)}
            empty=(size//2)*19+size//2
            for level in (1,2,3):
                name=f'last_empty_{size}_{level}'
                pieces={sq:side for sq,side in board.items() if sq!=empty}
                c=self.setup(size,pieces)+[f'scoreboard players set {C} gm_level {level}']+self.snapshot_count()
                checks=self.score(cell(empty),'gm_piece',1,name+'_placed')+self.score(C,'gm_moves',size*size,name+'_full')+self.score(C,'gm_aistate',0,name+'_consumed')
                self.search(name,c,checks)
            name=f'full_{size}'
            c=self.setup(size,board)+[f'scoreboard players set {C} gm_level 3']+self.snapshot_count()
            checks=self.score(C,'gm_moves',size*size,name+'_unchanged')+self.score(C,'gm_result',3,name+'_draw')+self.score(C,'gm_reason',2,name+'_full_reason')+self.score(C,'gm_state',4,name+'_finished')
            self.search(name,c,checks)
        c=self.setup()+[f'kill {cell(center)}',f'scoreboard players set {C} gm_bot 1']+self.call('ai/reset')
        for _ in range(7):c+=self.call('ai/tick')
        c+=self.score(C,'gm_result',3,'invalid_board_stopped')+self.score(C,'gm_reason',11,'invalid_board_reason')+self.score(C,'gm_aistate',0,'invalid_board_search_cancelled')
        self.case('invalid_board',c)
        self.file('finish',[f'say {self.token}_FINISHED',f'function {self.namespace}:reset'])
        self.file('bootstrap',['forceload add 0 0 15 15',f'function {self.namespace}:load',f'schedule function {self.namespace}:case/{self.cases[0]} 10t'])
        for i,name in enumerate(self.cases):
            key='done/'+name if 'done/'+name in self.files else 'case/'+name
            self.files[key]+=(f'schedule function {self.namespace}:case/{self.cases[i+1]} 1t\n') if i+1<len(self.cases) else f'function {self.namespace}:finish\n'


if __name__=='__main__':
    suite=Suite();suite.build();raise SystemExit(base.run(suite))
