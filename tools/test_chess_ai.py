"""Exercise the real table-local AI in an isolated vanilla 26.2 GameTest world."""
from pathlib import Path
import argparse
import json
import re
import shutil
import subprocess
import tempfile
import time

from test_chess import Suite as BaseSuite, PACK, A, B, square


class Suite(BaseSuite):
    def search(self, name, commands, checks, tables=(101,), limit=220):
        self.cases.append(name)
        starts = commands + ['scoreboard players set #aiticks cg 0']
        for table in tables:
            target = A if table == 101 else B
            starts += [f'scoreboard players set {target} ch_bot 1',f'scoreboard players set {target} ch_turn 1'] + self.call('ai/reset',table)
        starts += [f'schedule function chess_game_test:wait/{name} 1t']
        self.file('case/'+name, starts)
        wait = ['scoreboard players add #aiticks cg 1']
        for table in tables:
            target = A if table == 101 else B
            wait += [f'execute if score {target} ch_state matches 1 run function chess_game_test:probe/{name}_{table}']
            self.file(f'probe/{name}_{table}',self.call('ai/tick',table))
        wait += [f'execute if score #aiticks cg matches {limit}.. run return run function chess_game_test:done/{name}']
        condition = ' '.join(f'if score {A if table == 101 else B} ch_state matches 1' for table in tables)
        # All searches here have the same start state; finish when none remain.
        wait += ['scoreboard players set #ai_running cg 0']
        for table in tables:
            target = A if table == 101 else B
            wait += [f'execute if score {target} ch_state matches 1 run scoreboard players set #ai_running cg 1']
        wait += [f'execute if score #ai_running cg matches 1 run return run schedule function chess_game_test:wait/{name} 1t',
                 f'function chess_game_test:done/{name}']
        self.file('wait/'+name,wait)
        self.file('done/'+name,self.score('#aiticks','cg',f'..{limit-1}',name+'_bounded')+checks)

    def build(self):
        super().build()
        self.cases=[]
        self.expected=[]
        # Stop the real tick dispatcher: test schedules interleave tables using
        # the production ai/tick while retaining real engine/animation callbacks.
        for level in (1,2,3):
            name=f'opening_{level}'
            c=self.setup()+[f'scoreboard players set {A} ch_level {level}']
            checks=self.score(A,'ch_turn',-1,name+'_opponent_turn')+self.score(A,'ch_state',2,name+'_animation')
            checks+=self.check(f'data entity {A} data.chess.undo.board[0]',name+'_undo_recorded')
            checks+=self.call('engine/cache')+self.score('#cache_ok','ch_ctx',1,name+'_valid_board')
            checks+=['scoreboard players operation #attack_sq ch_ctx = #wking ch_ctx','scoreboard players set #attacker ch_ctx -1','function chess:engine/attack']
            checks+=self.score('#attacked','ch_ctx',0,name+'_king_safe')
            checks+=self.score(A,'ch_castle',15,name+'_castle_preserved')+self.score(A,'ch_aistate',0,name+'_search_consumed')
            self.search(name,c,checks)
        # Normal takes an undefended queen; hard notices a forcing mate instead.
        for level in (2,3):
            name=f'tactic_{level}'
            c=self.position('7k/q4Q2/6K1/8/8/8/8/8')+[f'scoreboard players set {A} ch_level {level}']
            if level==2:
                checks=self.score(square(48),'ch_piece',5,'normal_wins_queen')+self.check(f'data entity {A} data.chess.last{{captured:-5}}','normal_capture_event')
            else:
                checks=self.score(A,'ch_result',1,'hard_mate_in_one')+self.score(A,'ch_reason',1,'hard_mate_reason')
            self.search(name,c,checks)
        # Promotion and en passant use the production rules, not AI shortcuts.
        c=self.position('7k/P7/8/8/8/8/8/6K1')+[f'scoreboard players set {A} ch_level 2']
        self.search('promotion',c,self.score(square(56),'ch_piece',5,'ai_promotes_queen')+self.check(f'data entity {A} data.chess.last{{promotion:5}}','ai_promotion_metadata'))
        c=self.position('7k/8/8/3pP3/8/8/8/6K1',ep=43)+[f'scoreboard players set {A} ch_level 2']
        self.search('en_passant',c,self.score(square(43),'ch_piece',1,'ai_en_passant_lands')+self.score(square(35),'ch_piece',0,'ai_en_passant_removes_pawn'))
        # Black AI, including its side multiplier and downward pawn movement.
        name='black'
        c=self.position('r5k1/Q7/8/8/8/8/8/7K',turn=-1)+[f'scoreboard players set {A} ch_level 2',f'scoreboard players set {A} ch_bot -1']+self.call('ai/reset')
        self.cases.append(name)
        self.file('case/'+name,c+['scoreboard players set #aiticks cg 0','schedule function chess_game_test:wait/black 1t'])
        self.file('wait/black',['scoreboard players add #aiticks cg 1']+self.call('ai/tick')+[f'execute if score {A} ch_state matches 1 if score #aiticks cg matches ..219 run return run schedule function chess_game_test:wait/black 1t','function chess_game_test:done/black'])
        self.file('done/black',self.score('#aiticks','cg','..219','black_bounded')+self.score(square(48),'ch_piece',-4,'black_captures_up_board')+self.score(A,'ch_turn',1,'black_turn_flips'))
        # Search probes must never alter markers, real rights, ep or history.
        c=self.position('r3k2r/8/8/3pP3/8/8/8/R3K2R',castle=15,ep=43)+[f'scoreboard players set {A} ch_level 3',f'scoreboard players set {A} ch_bot 1']+self.call('ai/reset')
        c+=self.call('ai/tick')+[f'scoreboard players set {A} ch_aiwait 0']+self.call('ai/tick')
        c+=self.score(square(4),'ch_piece',6,'search_keeps_white_king')+self.score(square(60),'ch_piece',-6,'search_keeps_black_king')
        c+=self.score(square(35),'ch_piece',-1,'search_keeps_ep_pawn')+self.score(square(36),'ch_piece',1,'search_keeps_own_pawn')
        c+=self.score(A,'ch_castle',15,'search_keeps_castle')+self.score(A,'ch_ep',43,'search_keeps_ep')+self.score(A,'ch_turn',1,'search_keeps_turn')
        c+=self.check(f'data entity {A} data.chess.ai.queue[0]','search_queue_persists')+self.check(f'data entity {A} data.chess.history[0]','search_keeps_history')
        # Force a different controller epoch while work is pending.
        c+=[f'scoreboard players add {A} ch_epoch 1']+self.call('ai/tick')+self.score(A,'ch_aistate',0,'epoch_cancels_pending')
        c+=self.check(f'entity {A}', 'epoch_controller_preserved')
        c+=self.check(f'score {A} ch_ep matches 43','epoch_preserves_ep')
        c+=self.call('ai/tick')+[f'scoreboard players set {A} ch_bot 0']+self.call('ai/tick')+self.score(A,'ch_aistate',0,'human_mode_cancels')
        c+=[f'scoreboard players set {A} ch_bot 1']+self.call('ai/tick')+[f'scoreboard players set {A} ct_state 0']+self.call('ai/tick')+self.score(A,'ch_aistate',0,'lobby_cancels')
        self.case('noncommitting_cancel',c)
        c=self.setup()+self.setup(table=202,reset=False)+[f'scoreboard players set {A} ch_level 2',f'scoreboard players set {B} ch_level 3']
        checks=self.score(A,'ch_turn',-1,'table_a_moved')+self.score(B,'ch_turn',-1,'table_b_moved')
        checks+=self.score(A,'ch_aistate',0,'table_a_own_search')+self.score(B,'ch_aistate',0,'table_b_own_search')
        checks+=self.count('@e[tag=ch.square,scores={ct_id=101}]',64,'table_a_64_squares')+self.count('@e[tag=ch.square,scores={ct_id=202}]',64,'table_b_64_squares')
        self.search('isolation',c,checks,tables=(101,202))
        # No legal moves completes the existing stalemate evaluation.
        c=self.position('7k/5Q2/6K1/8/8/8/8/8',turn=-1)+[f'scoreboard players set {A} ch_bot -1',f'scoreboard players set {A} ch_level 1']+self.call('ai/reset')
        self.cases.append('stalemate')
        self.file('case/stalemate',c+['scoreboard players set #aiticks cg 0','schedule function chess_game_test:wait/stalemate 1t'])
        self.file('wait/stalemate',['scoreboard players add #aiticks cg 1']+self.call('ai/tick')+[f'execute if score {A} ch_state matches 1 if score #aiticks cg matches ..219 run return run schedule function chess_game_test:wait/stalemate 1t','function chess_game_test:done/stalemate'])
        self.file('done/stalemate',self.score(A,'ch_result',3,'no_moves_draw')+self.score(A,'ch_reason',2,'no_moves_stalemate'))
        self.file('finish',['function chess_game_test:reset','say CHESS_GAME_FINISHED'])
        self.file('bootstrap',['forceload add -16 -16 63 31','scoreboard objectives add cg dummy','schedule function chess_game_test:case/'+self.cases[0]+' 40t'])
        for i,name in enumerate(self.cases):
            key='done/'+name if 'done/'+name in self.files else 'case/'+name
            self.files[key]+='schedule function chess_game_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 3t\n'


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--java',type=Path,default=Path('C:/Temp/fimel-uno-java25/jdk-25.0.5+8-jre/bin/java.exe'))
    args=parser.parse_args()
    output=Path(tempfile.mkdtemp(prefix='fimel-chess-ai-'))
    target=output/'packs/fimel_cards'
    shutil.copytree(PACK/'data',target/'data');shutil.copy2(PACK/'pack.mcmeta',target/'pack.mcmeta')
    # Tick is explicitly driven so each assertion observes an exact search phase.
    (target/'data/minecraft/tags/function/tick.json').write_text('{"values":[]}',encoding='utf-8')
    suite=Suite();suite.build()
    for name,body in suite.files.items():
        dest=target/'data/chess_game_test/function'/(name+'.mcfunction');dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(body,encoding='utf-8')
    for name,body in {
        'test_environment/default.json':{'type':'minecraft:function','setup':'chess_game_test:bootstrap'},
        'test_instance/ai.json':{'type':'minecraft:function','environment':'chess_game_test:default','function':'minecraft:always_pass','max_ticks':1,'setup_ticks':2000,'required':True,'structure':'minecraft:empty'},
    }.items():
        dest=target/'data/chess_game_test'/name;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(json.dumps(body),encoding='utf-8')
    mc=Path('D:/PCL2/MinecraftPcl');launch=mc/'versions/26.2-Fabric_0.19.3/26.2-Fabric_0.19.3.json'
    meta=json.loads(launch.read_text(encoding='utf-8-sig'));classpath=[launch.with_suffix('.jar')]
    for lib in meta['libraries']:
        entry=lib.get('downloads',{}).get('artifact',{})
        if entry.get('path'):
            path=mc/'libraries'/entry['path']
            if path.is_file():classpath.append(path)
    options=['-Xms256M','-Xmx1536M','-Djava.awt.headless=true','-Dfile.encoding=UTF-8','--enable-native-access=ALL-UNNAMED','-cp',';'.join(map(str,classpath)),'net.minecraft.gametest.Main','--packs',str(output/'packs'),'--universe',str(output/'universe'),'--tests','chess_game_test:*','--report',str(output/'gametest.xml')]
    argfile=output/'java-args.txt';argfile.write_text('\n'.join('"'+v.replace('\\','\\\\').replace('"','\\"')+'"' for v in options),encoding='utf-8')
    print('Chess AI GameTest: '+str(output),flush=True);start=time.monotonic()
    process=subprocess.run([str(args.java),'@'+str(argfile)],cwd=output,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf-8',errors='replace',timeout=240)
    (output/'game.log').write_text(process.stdout,encoding='utf-8')
    passed=set(re.findall(r'CHESS_GAME_PASS ([a-z0-9_]+)',process.stdout));failed=sorted(set(re.findall(r'CHESS_GAME_FAIL ([a-z0-9_]+)',process.stdout)))
    errors=[line for line in process.stdout.splitlines() if any(s in line for s in ['[ERROR]','/ERROR]','Failed to load','Failed to parse','Unknown function','Unknown or incomplete command',"Couldn't parse",'Command execution stopped'])]
    result={'exit_code':process.returncode,'seconds':round(time.monotonic()-start,1),'assertions':len(suite.expected),'passed':len(passed),'failed':failed,'missing':sorted(set(suite.expected)-passed),'errors':errors,'finished':'CHESS_GAME_FINISHED' in process.stdout,'output':str(output)}
    (output/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(result,ensure_ascii=False,indent=2),flush=True)
    return int(bool(process.returncode or failed or result['missing'] or errors or not result['finished']))


if __name__=='__main__':
    raise SystemExit(main())
