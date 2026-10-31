"""在隔离原版 26.2 GameTest 中验收五子棋，不改玩家存档。"""
from pathlib import Path
import argparse
import json
import random
import re
import shutil
import subprocess
import tempfile
import time

PACK=Path(__file__).resolve().parents[1]
C='@e[type=minecraft:marker,tag=ge.controller,scores={ct_id=101},limit=1]'
D='@e[type=minecraft:marker,tag=ge.controller,scores={ct_id=202},limit=1]'


def cell(sq,table=101):
    return f'@e[type=minecraft:marker,tag=gm.square,scores={{ct_id={table},gm_sq={sq}}},limit=1]'


def win_line(board,sq,side,size):
    f,r=sq%19,sq//19
    result=set()
    for df,dr in ((1,0),(0,1),(1,1),(1,-1)):
        line={sq}
        for sign in (-1,1):
            ff,rr=f+df*sign,r+dr*sign
            while 0<=ff<size and 0<=rr<size and board.get(rr*19+ff,0)==side:
                line.add(rr*19+ff);ff+=df*sign;rr+=dr*sign
        if len(line)>=5: result.update(line)
    return result


class Suite:
    namespace='gomoku_engine_test'
    token='GOMOKU_ENGINE'
    setup_ticks=400
    def __init__(self):self.files,self.cases,self.expected={},[],[]
    def file(self,name,body):self.files[name]=('\n'.join(body) if isinstance(body,list) else body).strip()+'\n'
    def case(self,name,body):self.cases.append(name);self.file('case/'+name,body)
    def check(self,condition,name):
        assert name not in self.expected,name
        self.expected.append(name)
        return [f'execute if {condition} run say {self.token}_PASS {name}',f'execute unless {condition} run say {self.token}_FAIL {name}']
    def score(self,who,obj,value,name):return self.check(f'score {who} {obj} matches {value}',name)
    def call(self,path,table=101):return [f'execute as {C if table==101 else D} at @s run function gomoku:{path}']
    def setup(self,size=15,pieces=None,turn=1,table=101,reset=True):
        target=C if table==101 else D
        lines=[f'function {self.namespace}:reset'] if reset else []
        lines += [f'execute positioned 0 70 0 summon minecraft:marker run function {self.namespace}:controller {{table:{table},size:{size},turn:{turn}}}']
        lines += [f'execute positioned 0 70 0 summon minecraft:marker run function {self.namespace}:square {{table:{table},sq:{r*19+f}}}' for r in range(size) for f in range(size)]
        lines += self.call('engine/init_board',table)
        if pieces:
            lines += [f'scoreboard players set {cell(sq,table)} gm_piece {p}' for sq,p in pieces.items()]
            lines += [f'scoreboard players set {target} gm_moves {sum(bool(x) for x in pieces.values())}']
        lines += [f'scoreboard players set {target} gm_turn {turn}']
        return lines+self.call('system/context',table)
    def probe(self,to):return [f'scoreboard players set #to gm_ctx {to}']+self.call('engine/check_move')
    def move(self,to,table=101):return [f'scoreboard players set #to gm_ctx {to}']+self.call('engine/try_move',table)
    def last(self,sq,side):return [f'data modify entity {C} data.gomoku.last set value {{sq:{sq},side:{side}}}']
    def fixtures(self):
        self.file('reset','kill @e[tag=ge.fixture]')
        self.file('controller','''
tag @s add ge.fixture
tag @s add ge.controller
tag @s add gm.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s gm_size $(size)
$scoreboard players set @s gm_turn $(turn)
scoreboard players set @s ct_state 1
scoreboard players set @s gm_state 1
scoreboard players set @s gm_epoch 1
scoreboard players set @s gm_bot 0
scoreboard players set @s gm_level 2
scoreboard players set @s gm_aistate 0
scoreboard players set @s gm_aiwait 0
scoreboard players set @s ge 0
''')
        self.file('square','''
tag @s add ge.fixture
tag @s add gm.square
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s gm_sq $(sq)
scoreboard players set @s gm_piece 0
''')
        self.file('load',[f'scoreboard objectives add {obj} dummy' for obj in 'gm_ctx gm_piece gm_sq gm_size gm_turn gm_moves gm_result gm_reason gm_state gm_bot gm_level gm_epoch gm_aistate gm_aiwait gm_aiepoch ct_id ct_state ge'.split()])
    def finish(self):
        self.file('finish',[f'say {self.token}_FINISHED',f'function {self.namespace}:reset'])
        self.file('bootstrap',['forceload add 0 0 15 15',f'function {self.namespace}:load',f'schedule function {self.namespace}:case/{self.cases[0]} 10t'])
        for i,name in enumerate(self.cases):
            self.files['case/'+name]+=(f'schedule function {self.namespace}:case/{self.cases[i+1]} 1t\n') if i+1<len(self.cases) else f'function {self.namespace}:finish\n'
    def build(self):
        self.fixtures()
        for size in (13,15,19):
            c=self.setup(size)+self.call('engine/cache')+self.score('#cache_ok','gm_ctx',1,f'size_{size}_valid_cache')
            c+=self.score(C,'gm_turn',1,f'size_{size}_black_first')+self.score(C,'gm_moves',0,f'size_{size}_empty')
            for sq in range(361):
                legal=int(sq%19<size and sq//19<size)
                c+=self.probe(sq)+self.score('#legal','gm_ctx',legal,f'legal_{size}_{sq}')
            c+=self.probe(-1)+self.score('#legal','gm_ctx',0,f'negative_{size}')+self.probe(361)+self.score('#legal','gm_ctx',0,f'outside_{size}')
            self.case(f'bounds_{size}',c)
        c=self.setup()+self.move(140)+self.score(cell(140),'gm_piece',1,'black_placed')+self.score(C,'gm_turn',-1,'turn_white')
        c+=self.check(f'data entity {C} data.gomoku.last{{sq:140,side:1}}','last_black')+self.check(f'data entity {C} data.gomoku.history[{{sq:140,side:1}}]','history_black')
        c+=self.move(140)+self.score('#legal','gm_ctx',0,'occupied_rejected')+self.score(C,'gm_moves',1,'illegal_no_move_count')+self.move(141)+self.score(cell(141),'gm_piece',-1,'white_placed')
        c+=self.score(C,'gm_turn',1,'turn_black')+self.score(C,'gm_moves',2,'two_moves')+self.score(C,'ge',2,'two_callbacks')
        self.case('move',c)
        for size in (13,15,19):
            for side in (-1,1):
                for d,(df,dr) in enumerate(((1,0),(0,1),(1,1),(1,-1))):
                    for length in (4,5,6):
                        f,r=2,8 if dr<0 else 2
                        line=[(r+dr*i)*19+f+df*i for i in range(length)]
                        board={sq:side for sq in line}
                        last=line[length//2]
                        name=f'line_{size}_{side+1}_{d}_{length}'
                        c=self.setup(size,board)+self.last(last,side)+self.call('engine/evaluate')
                        c+=self.score(C,'gm_result',int(1 if side==1 else 2) if length>=5 else 0,name+'_result')
                        if length>=5:
                            c+=self.score(C,'gm_reason',1,name+'_reason')
                            for sq in line:c+=self.check(f'data entity {C} data.gomoku{{win:[{sq}]}}',name+f'_win_{sq}')
                            c += [f'execute store result score #count ge run data get entity {C} data.gomoku.win']+self.score('#count','ge',length,name+'_exact_length')
                        self.case(name,c)
        # Crossing winning lines contain the centre exactly once; no row wrapping.
        centre=8*19+8
        cross={centre+d:1 for d in range(-3,4)}|{centre+19*d:1 for d in range(-3,4)}
        c=self.setup(19,cross)+self.last(centre,1)+self.call('engine/evaluate')
        c += [f'execute store result score #count ge run data get entity {C} data.gomoku.win']+self.score('#count','ge',13,'cross_unique_13')
        self.case('cross',c)
        c=self.setup(19,{17:1,18:1,19:1,20:1,21:1})+self.last(19,1)+self.call('engine/evaluate')+self.score(C,'gm_result',0,'row_does_not_wrap')
        self.case('no_wrap',c)
        for size in (13,15,19):
            board={r*19+f:(1 if (f+2*r)%4<2 else -1) for r in range(size) for f in range(size)}
            last=max(board)
            assert not win_line(board,last,board[last],size)
            c=self.setup(size,board)+self.last(last,board[last])+self.call('engine/evaluate')+self.score(C,'gm_result',3,f'full_{size}_draw')+self.score(C,'gm_reason',2,f'full_{size}_reason')
            self.case(f'full_{size}',c)
        # Deterministic independent Python oracle, mixing edges, long lines and holes.
        rng=random.Random(261031)
        for case in range(48):
            size=rng.choice((13,15,19));board={r*19+f:rng.choice((-1,0,0,1)) for r in range(size) for f in range(size)}
            last=rng.randrange(size)*19+rng.randrange(size);side=rng.choice((-1,1));board[last]=side
            if case%3==0:
                df,dr=rng.choice(((1,0),(0,1),(1,1)));length=rng.randrange(4,9)
                f=rng.randrange(size-length+1);r=rng.randrange(size-length+1)
                for j in range(length):board[(r+dr*j)*19+f+df*j]=side
                last=(r+dr*(length//2))*19+f+df*(length//2)
            expected=win_line(board,last,side,size)
            c=self.setup(size,board)+self.last(last,side)+self.call('engine/evaluate')
            c+=self.score(C,'gm_result',(1 if side==1 else 2) if expected else 0,f'oracle_{case}_result')
            c += [f'execute store result score #count ge run data get entity {C} data.gomoku.win']+self.score('#count','ge',len(expected),f'oracle_{case}_count')
            for sq in sorted(expected):c+=self.check(f'data entity {C} data.gomoku{{win:[{sq}]}}',f'oracle_{case}_point_{sq}')
            self.case(f'oracle_{case}',c)
        for name,changes in [('missing',[f'kill {cell(140)}']),('duplicate',[f'execute summon minecraft:marker run function {self.namespace}:square {{table:101,sq:140}}']),('piece',[f'scoreboard players set {cell(140)} gm_piece 2']),('size',[f'scoreboard players set {C} gm_size 14'])]:
            c=self.setup()+changes+self.call('engine/cache')+self.score('#cache_ok','gm_ctx',0,name+'_invalid')+self.call('engine/evaluate')+self.score(C,'gm_reason',11,name+'_safe_stop')
            self.case('invalid_'+name,c)
        c=self.setup()+self.setup(19,table=202,reset=False)+self.move(140)+self.score(cell(140,202),'gm_piece',0,'other_table_empty')+self.score(D,'gm_moves',0,'other_table_moves')+self.call('engine/cache',202)+self.score('#cache_ok','gm_ctx',1,'other_table_cache')
        self.case('isolation',c)
        self.finish()
        self.setup_ticks=len(self.cases)+40


def run(suite):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--java',type=Path,default=Path('C:/Temp/fimel-uno-java25/jdk-25.0.5+8-jre/bin/java.exe'))
    parser.add_argument('--minecraft-root',type=Path,default=Path('D:/PCL2/MinecraftPcl'))
    parser.add_argument('--version',default='26.2-Fabric_0.19.3')
    args=parser.parse_args()
    output=Path(tempfile.mkdtemp(prefix='fimel-'+suite.namespace.replace('_','-')+'-'));target=output/'packs/gomoku'
    for part in ('engine','ai'):
        shutil.copytree(PACK/'data/gomoku/function'/part,target/'data/gomoku/function'/part)
    shutil.copy2(PACK/'pack.mcmeta',target/'pack.mcmeta')
    for name,body in suite.files.items():
        path=target/'data'/suite.namespace/'function'/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True);path.write_text(body,encoding='utf-8')
    helpers={
        'gomoku/function/system/context.mcfunction':'scoreboard players operation #table gm_ctx = @s ct_id\ntag @e[tag=gm.board] remove gm.board\nexecute as @e[type=minecraft:marker,tag=gm.square] if score @s ct_id = #table gm_ctx run tag @s add gm.board\n',
        'gomoku/function/game/after_move.mcfunction':'scoreboard players add @s ge 1\n',
        'gomoku/function/game/snapshot.mcfunction':'data modify entity @s data.gomoku.undo set value {saved:1b}\n',
        'gomoku/function/game/finish.mcfunction':'scoreboard players set @s gm_state 4\nscoreboard players set @s gm_aistate 0\n',
        'minecraft/tags/function/load.json':json.dumps({'values':[suite.namespace+':load']}),
        suite.namespace+'/test_environment/default.json':json.dumps({'type':'minecraft:function','setup':suite.namespace+':bootstrap'}),
        suite.namespace+'/test_instance/game.json':json.dumps({'type':'minecraft:function','environment':suite.namespace+':default','function':'minecraft:always_pass','max_ticks':1,'required':True,'setup_ticks':suite.setup_ticks,'structure':'minecraft:empty'}),
    }
    for name,body in helpers.items():
        path=target/'data'/name;path.parent.mkdir(parents=True,exist_ok=True);path.write_text(body,encoding='utf-8')
    launch=args.minecraft_root/'versions'/args.version/(args.version+'.json')
    meta=json.loads(launch.read_text(encoding='utf-8-sig'));classpath=[launch.with_suffix('.jar')]
    for lib in meta['libraries']:
        entry=lib.get('downloads',{}).get('artifact',{})
        if entry.get('path'):
            path=args.minecraft_root/'libraries'/entry['path']
            if path.is_file():classpath.append(path)
    options=['-Xms256M','-Xmx1536M','-Djava.awt.headless=true','-Dfile.encoding=UTF-8','--enable-native-access=ALL-UNNAMED','-cp',';'.join(map(str,classpath)),'net.minecraft.gametest.Main','--packs',str(output/'packs'),'--universe',str(output/'universe'),'--tests',suite.namespace+':*','--report',str(output/'gametest.xml')]
    argfile=output/'java-args.txt';argfile.write_text('\n'.join('"'+v.replace('\\','\\\\').replace('"','\\"')+'"' for v in options),encoding='utf-8')
    print(suite.namespace+' GameTest: '+str(output),flush=True);start=time.monotonic()
    proc=subprocess.run([str(args.java),'@'+str(argfile)],cwd=output,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf-8',errors='replace',timeout=max(180,suite.setup_ticks/20+180))
    (output/'game.log').write_text(proc.stdout,encoding='utf-8')
    passed=set(re.findall(suite.token+r'_PASS ([a-z0-9_]+)',proc.stdout));failed=sorted(set(re.findall(suite.token+r'_FAIL ([a-z0-9_]+)',proc.stdout)));missing=sorted(set(suite.expected)-passed)
    errors=[line for line in proc.stdout.splitlines() if any(s in line for s in ('[ERROR]','/ERROR]','Failed to load','Failed to parse','Unknown function','Unknown or incomplete command',"Couldn't parse",'Command execution stopped'))]
    result={'exit_code':proc.returncode,'seconds':round(time.monotonic()-start,1),'assertions':len(suite.expected),'passed':len(passed),'failed':failed,'missing':missing,'errors':errors,'finished':suite.token+'_FINISHED' in proc.stdout,'output':str(output)}
    (output/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(result,ensure_ascii=False,indent=2),flush=True)
    return int(bool(proc.returncode or failed or missing or errors or not result['finished']))


if __name__=='__main__':
    suite=Suite();suite.build();raise SystemExit(run(suite))
