# -*- coding: utf-8 -*-
"""隔离原版26.2围棋规则验收；独立Python集合洪泛校验，默认65536命令预算。"""
from pathlib import Path
import argparse
import json
import random
import re
import shutil
import subprocess
import tempfile
import time

from build_weiqi_engine import OBJECTIVES

PACK = Path(__file__).resolve().parents[1]
C = '@e[type=minecraft:marker,tag=goe.controller,scores={ct_id=101},limit=1]'
D = '@e[type=minecraft:marker,tag=goe.controller,scores={ct_id=202},limit=1]'
NS = 'weiqi_engine_test'
TOKEN = 'WEIQI_ENGINE'


def cell(sq, table=101):
    return f'@e[type=minecraft:marker,tag=go.square,scores={{ct_id={table},go_sq={sq}}},limit=1]'


def adjacent(sq, size):
    f, r = sq % 19, sq // 19
    return {rr*19+ff for ff, rr in ((f-1,r),(f+1,r),(f,r-1),(f,r+1)) if 0 <= ff < size and 0 <= rr < size}


def group(board, sq, size):
    color = board.get(sq, 0)
    seen, stack, liberties, border = {sq}, [sq], set(), set()
    while stack:
        for near in adjacent(stack.pop(), size):
            p = board.get(near, 0)
            if p == 0: liberties.add(near)
            elif p != color: border.add(p)
            if p == color and near not in seen:
                seen.add(near);stack.append(near)
    return seen, liberties, border


def encoded(board):
    return tuple(sum((0 if board.get(r*19+f,0)==0 else 1 if board.get(r*19+f)==1 else 2)*3**f for f in range(19)) for r in range(19))


def oracle_move(board, to, side, size, history=()):
    if to < 0 or to % 19 >= size or to // 19 >= size:return 0, 1, board, set(), 0
    if board.get(to, 0):return 0, 2, board, set(), 0
    result = dict(board);result[to] = side;captured = set()
    for near in adjacent(to, size):
        if result.get(near) == -side:
            stones, liberties, _ = group(result, near, size)
            if not liberties:
                captured |= stones
                for sq in stones:result[sq] = 0
    own, liberties, _ = group(result, to, size)
    if not liberties:return 0, 3, board, captured, 0
    if encoded(result) in history:return 0, 4, board, captured, len(liberties)
    return 1, 0, result, captured, len(liberties)


def oracle_score(board, dead, size, komi=15):
    effective = {sq:(0 if sq in dead else board.get(sq,0)) for sq in (r*19+f for r in range(size) for f in range(size))}
    owner = dict(effective);visited = set();territ = {1:0,-1:0,0:0}
    for sq, p in effective.items():
        if p or sq in visited:continue
        region, _, border = group(effective, sq, size);visited |= region
        color = next(iter(border)) if len(border)==1 else 0
        territ[color] += len(region)
        for point in region:owner[point] = color
    black, white = sum(v==1 for v in owner.values()), sum(v==-1 for v in owner.values())
    return owner, (black,white,territ[1],territ[-1],territ[0],2*black,2*white+komi)


def oracle_estimate(board, size, komi=15):
    """独立逐点最近Manhattan距离；不复用运行时分层扩展。"""
    stones={side:[(sq%19,sq//19) for sq,p in board.items() if p==side] for side in (1,-1)}
    owner={};distances={}
    for r in range(size):
        for f in range(size):
            sq=r*19+f
            bd=min((abs(f-ff)+abs(r-rr) for ff,rr in stones[1]),default=999)
            wd=min((abs(f-ff)+abs(r-rr) for ff,rr in stones[-1]),default=999)
            distances[sq]=(bd if bd<=4 else 999,wd if wd<=4 else 999)
            owner[sq]=board.get(sq,0) or (1 if bd<=3 and wd-bd>=2 else -1 if wd<=3 and bd-wd>=2 else 0)
    black=sum(p==1 for p in owner.values());white=sum(p==-1 for p in owner.values())
    bt=sum(p==1 and not board.get(sq) for sq,p in owner.items());wt=sum(p==-1 and not board.get(sq) for sq,p in owner.items())
    neutral=sum(p==0 for p in owner.values())
    return owner,distances,(black,white,bt,wt,neutral,2*black,2*white+komi)


class Suite:
    def __init__(self):self.files, self.cases, self.expected = {}, [], []
    def file(self, name, body):self.files[name] = ('\n'.join(body) if isinstance(body,list) else body).strip()+'\n'
    def case(self, name, body):self.cases.append(name);self.file('case/'+name,body)
    def check(self, condition, name):
        assert name not in self.expected, name
        self.expected.append(name)
        return [f'execute if {condition} run say {TOKEN}_PASS {name}',f'execute unless {condition} run say {TOKEN}_FAIL {name}']
    def score(self, who, obj, value, name):return self.check(f'score {who} {obj} matches {value}',name)
    def call(self, name, table=101):return [f'execute as {C if table==101 else D} at @s run function weiqi:{name}']
    def count(self, selector, value, name):return [f'execute store result score #count goe if entity {selector}']+self.score('#count','goe',value,name)
    def length(self, path, value, name):return [f'execute store result score #length goe run data get entity {C} {path}']+self.score('#length','goe',value,name)
    def setup(self, size=13, pieces=None, side=1, table=101, reset=True):
        c = [f'function {NS}:reset'] if reset else []
        c += [f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:marker run function {NS}:controller {{table:{table},size:{size}}}']
        c += [f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:marker run function {NS}:square {{table:{table},sq:{r*19+f},file:{f},rank:{r}}}' for r in range(size) for f in range(size)]
        c += self.call('system/context',table)+self.call('engine/init_board',table)
        c += [f'scoreboard players set {cell(sq,table)} go_piece {piece}' for sq,piece in (pieces or {}).items() if piece]
        c += [f'scoreboard players set {C if table==101 else D} go_turn {side}']+self.call('engine/encode',table)
        c += [f'data modify entity {C if table==101 else D} data.weiqi.history set value []',f'data modify entity {C if table==101 else D} data.weiqi.positions set value []']+self.call('engine/snapshot',table)
        return c
    def move(self, to, probe=False, table=101):
        return self.call('system/context',table)+[f'scoreboard players set #to go_ctx {to}']+self.call('engine/check_move' if probe else 'engine/try_move',table)
    def board(self, pieces, size, key, table=101):
        return [command for r in range(size) for f in range(size) for command in self.score(cell(r*19+f,table),'go_piece',pieces.get(r*19+f,0),key+f'_{r}_{f}')]
    def fixtures(self):
        self.file('reset','kill @e[tag=goe.fixture]')
        self.file('controller','''
tag @s add goe.fixture
tag @s add goe.controller
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s go_size $(size)
scoreboard players set @s go_komi 15
scoreboard players set @s go_btime 12000
scoreboard players set @s go_wtime 12000
''')
        self.file('square','''
tag @s add goe.fixture
tag @s add go.square
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s go_sq $(sq)
$scoreboard players set @s go_file $(file)
$scoreboard players set @s go_rank $(rank)
''')
        self.file('load',['scoreboard objectives add ct_id dummy','scoreboard objectives add goe dummy','function weiqi:engine/install'])
    def build(self):
        self.fixtures()
        for size in (13,15,19):
            c=self.setup(size)+self.count('@e[tag=go.square]',size*size,f'size_{size}_markers')+self.length('data.weiqi.history',1,f'size_{size}_history_initial')+self.length('data.weiqi.positions',1,f'size_{size}_positions_initial')+self.score(C,'go_turn',1,f'size_{size}_black_first')
            for index,to in enumerate((-1,361,size if size<19 else 362)):
                c+=self.move(to)+self.score('#legal','go_ctx',0,f'bounds_{size}_{index}')
            c+=self.call('engine/score')+self.score(C,'go_neutral',size*size,f'empty_{size}_neutral')+self.score(C,'go_barea',0,f'empty_{size}_black')+self.score(C,'go_wscore',15,f'empty_{size}_komi')
            self.case('size_'+str(size),c)
        c=self.setup()+self.move(40,True)+self.score('#legal','go_ctx',1,'probe_legal')+self.score('#liberties','go_ctx',4,'probe_four_liberties')+self.score(cell(40),'go_piece',0,'probe_rolls_back')+self.length('data.weiqi.history',1,'probe_no_history')+self.move(40)+self.score('#legal','go_ctx',1,'move_legal')+self.score(C,'go_turn',-1,'turn_flips')+self.score(C,'go_moves',1,'move_counter')+self.check(f'data entity {C} data.weiqi.last{{sq:40,side:1,pass:0b}}','last_move')+self.move(40)+self.score('#error','go_ctx',2,'occupied_error')+self.length('data.weiqi.history',2,'occupied_no_history')
        self.case('basic',c)
        board={21:-1,39:-1,41:-1,59:-1}
        c=self.setup(pieces=board)+self.move(40)+self.score('#legal','go_ctx',0,'suicide_rejected')+self.score('#error','go_ctx',3,'suicide_reason')+self.board(board,13,'suicide_rollback')+self.length('data.weiqi.history',1,'suicide_no_history')
        self.case('suicide',c)
        # 经典劫形：黑40提白21，白21立即回提会恢复相同完整棋形。
        ko={2:1,20:1,22:1,21:-1,39:-1,41:-1,59:-1}
        c=self.setup(pieces=ko)+self.move(40)+self.score('#captured','go_ctx',1,'ko_first_capture')+self.score(C,'go_bcap',1,'black_capture_count')+self.move(21)+self.score('#legal','go_ctx',0,'ko_rejected')+self.score('#error','go_ctx',4,'ko_reason')+self.score(cell(40),'go_piece',1,'ko_rollback_black')+self.score(cell(21),'go_piece',0,'ko_rollback_empty')+self.score(C,'go_wcap',0,'ko_no_white_captures')+self.length('data.weiqi.history',2,'ko_no_history')
        c+=self.call('engine/pass')+self.call('engine/pass')+self.move(21)+self.score('#legal','go_ctx',0,'ko_after_two_passes')+self.score('#error','go_ctx',4,'ko_after_pass_reason')
        self.case('superko',c)
        # 保存精确候选；同hash的不同棋形须放行，相同棋形位于第二候选也须识别。
        c=self.setup()+self.move(40)+[f'data modify storage {NS}:run repeated set from entity {C} data.weiqi.positions[-1]']+self.call('engine/undo')+[f'data modify storage {NS}:run collision set from storage {NS}:run repeated',f'data modify storage {NS}:run collision.board[0] set value 7',f'data modify entity {C} data.weiqi.positions append from storage {NS}:run collision']+self.move(40)+self.score('#legal','go_ctx',1,'hash_collision_allowed')+self.call('engine/undo')+[f'data modify entity {C} data.weiqi.positions append from storage {NS}:run repeated']+self.move(40)+self.score('#legal','go_ctx',0,'second_candidate_detected')+self.score('#error','go_ctx',4,'second_candidate_reason')
        self.case('hash_collision',c)
        c=self.setup()+[f'scoreboard players set {C} go_btime 11000']+self.move(40)+[f'scoreboard players set {C} go_wtime 10500']+self.call('engine/pass')+self.length('data.weiqi.history',3,'pass_has_history')+self.score(C,'go_passes',1,'pass_counter')+self.call('engine/undo')+self.score(C,'go_turn',-1,'undo_pass_turn')+self.score(C,'go_wtime',12000,'undo_pass_clock')+self.score(cell(40),'go_piece',1,'undo_pass_keeps_stone')+self.call('engine/undo')+self.score(cell(40),'go_piece',0,'undo_stone')+self.score(C,'go_btime',12000,'undo_move_clock')+self.length('data.weiqi.positions',1,'undo_drops_future')+self.move(41)+self.score('#legal','go_ctx',1,'undo_branch_allowed')+self.length('data.weiqi.history',2,'branch_history')+['scoreboard players set #frame go_ctx 0']+self.call('engine/review')+self.score(cell(41),'go_piece',0,'review_initial')+['scoreboard players set #frame go_ctx 1']+self.call('engine/review')+self.score(cell(41),'go_piece',1,'review_final')+self.length('data.weiqi.history',2,'review_preserves_history')
        self.case('undo_review_clock',c)
        # 361点真实原版压力：提走360子，完整洪泛仍不得耗尽默认命令预算。
        board={sq:-1 for sq in range(360)}
        c=self.setup(19,board)+self.move(360)+self.score('#legal','go_ctx',1,'large_capture_legal')+self.score('#captured','go_ctx',360,'large_capture_360')+self.score(C,'go_bcap',360,'large_capture_counter')+self.count('@e[tag=go.board,scores={go_piece=-1}]',0,'large_capture_no_whites')+self.length('data.weiqi.last.captured',360,'large_capture_public_list')
        self.case('stress_capture_360',c)
        # 全盘同色且最后一气被填，无提子则禁自杀；必须恢复整盘。
        board={sq:1 for sq in range(360)}
        c=self.setup(19,board)+self.move(360)+self.score('#legal','go_ctx',0,'large_suicide_rejected')+self.score('#error','go_ctx',3,'large_suicide_reason')+self.count('@e[tag=go.board,scores={go_piece=1}]',360,'large_suicide_rollback')
        self.case('stress_own_group_361',c)
        # 同色相连整组标死；数子把死子当作空地而不删除实体棋子。
        board={sq:1 for sq in range(361)};board[40]=board[41]=-1
        c=self.setup(19,board)+['scoreboard players set #to go_ctx 40']+self.call('engine/toggle_dead')+self.score('#changed','go_ctx',2,'mark_dead_connected_two')+self.score(cell(41),'go_dead',1,'mark_dead_other')+self.call('engine/score')+self.score(C,'go_barea',361,'dead_removed_for_area')+self.score(C,'go_warea',0,'dead_white_no_area')+self.score(cell(40),'go_piece',-1,'score_keeps_real_stone')+self.score(cell(40),'go_owner',1,'dead_point_owned_black')+['scoreboard players set #to go_ctx 41']+self.call('engine/toggle_dead')+self.score(cell(40),'go_dead',0,'dead_toggle_group_back')
        self.case('dead_group',c)
        rng=random.Random(26110120)
        for n in range(26):
            size=rng.choice((13,15,19));board={r*19+f:rng.choice((-1,0,0,1)) for r in range(size) for f in range(size)}
            to=rng.randrange(size)*19+rng.randrange(size);board[to]=0;side=rng.choice((-1,1))
            legal,error,after,captured,liberties=oracle_move(board,to,side,size,(encoded(board),))
            c=self.setup(size,board,side)+self.move(to,True)+self.score('#legal','go_ctx',legal,f'oracle_{n}_probe')+self.score('#error','go_ctx',error,f'oracle_{n}_error')+self.length('data.weiqi.history',1,f'oracle_{n}_probe_history')+self.score(cell(to),'go_piece',0,f'oracle_{n}_probe_unchanged')+self.move(to)+self.score('#legal','go_ctx',legal,f'oracle_{n}_move')+self.board(after,size,f'oracle_{n}_board')
            if legal:c+=self.score('#captured','go_ctx',len(captured),f'oracle_{n}_captures')+self.score('#liberties','go_ctx',liberties,f'oracle_{n}_liberties')
            self.case('oracle_move_'+str(n),c)
        for n in range(9):
            size=rng.choice((13,15,19));board={r*19+f:rng.choice((-1,0,0,1)) for r in range(size) for f in range(size)};dead={sq for sq in board if board[sq] and rng.randrange(8)==0}
            owner,counts=oracle_score(board,dead,size)
            c=self.setup(size,board)+[f'scoreboard players set {cell(sq)} go_dead 1' for sq in dead]+self.call('engine/score')
            for obj,val in zip(('barea','warea','bterrit','wterrit','neutral','bscore','wscore'),counts):c+=self.score(C,'go_'+obj,val,f'score_{n}_{obj}')
            for sq,val in owner.items():c+=self.score(cell(sq),'go_owner',val,f'score_{n}_owner_{sq}')
            self.case('oracle_score_'+str(n),c)
        influence_boards=[({},19),({0:1},19),({180:1},19),({177:1,184:-1},19),
                          ({r*19+3:1 for r in range(19)}|{r*19+10:-1 for r in range(19)},19),
                          ({sq:(1 if (sq%19+sq//19)%2 else -1) for sq in range(361)},19)]
        for _ in range(8):
            size=rng.choice((13,15,19));board={sq:rng.choice((-1,1)) for sq in rng.sample([r*19+f for r in range(size) for f in range(size)],rng.randint(1,35))}
            influence_boards.append((board,size))
        for n,(board,size) in enumerate(influence_boards):
            owner,distances,counts=oracle_estimate(board,size)
            c=self.setup(size,board)+self.call('engine/estimate')
            for obj,val in zip(('barea','warea','bterrit','wterrit','neutral','bscore','wscore'),counts):c+=self.score(C,'go_'+obj,val,f'estimate_{n}_{obj}')
            for sq,val in owner.items():
                c+=self.score(cell(sq),'go_owner',val,f'estimate_{n}_owner_{sq}')+self.score(cell(sq),'go_bdist',distances[sq][0],f'estimate_{n}_black_dist_{sq}')+self.score(cell(sq),'go_wdist',distances[sq][1],f'estimate_{n}_white_dist_{sq}')
            c+=self.length('data.weiqi.history',1,f'estimate_{n}_keeps_history')
            if n==1:c+=self.score(C,'go_barea',10,'first_corner_only_ten')+self.score(C,'go_neutral',351,'first_corner_remains_351_undecided')
            if n==2:c+=self.score(C,'go_barea',25,'first_center_only_twentyfive')
            self.case('estimate_'+str(n),c)
        c=self.setup(19)+self.setup(13,table=202,reset=False)+self.move(40)+self.score(cell(40,202),'go_piece',0,'two_table_unchanged')+self.call('system/context',202)+self.call('engine/score',202)+self.score(D,'go_neutral',169,'two_table_area_isolated')+self.score(C,'go_moves',1,'two_table_moves_kept')
        c+=self.call('engine/estimate',202)+self.score(D,'go_neutral',169,'two_table_estimate_isolated')+self.score(cell(40),'go_piece',1,'two_table_estimate_keeps_other_stones')
        self.case('isolation',c)
        self.file('bootstrap',['forceload add 0 0 47 15',f'function {NS}:load',f'schedule function {NS}:case/{self.cases[0]} 5t'])
        self.file('finish',f'say {TOKEN}_FINISHED')
        for i,name in enumerate(self.cases):self.files['case/'+name]+=f'schedule function {NS}:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 1t\n'


def run(suite):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--java',type=Path,default=Path('C:/Temp/fimel-uno-java25/jdk-25.0.5+8-jre/bin/java.exe'))
    parser.add_argument('--minecraft-root',type=Path,default=Path('D:/PCL2/MinecraftPcl'))
    parser.add_argument('--version',default='26.2-Fabric_0.19.3')
    parser.add_argument('--case')
    args=parser.parse_args()
    if args.case:
        if args.case not in suite.cases:raise SystemExit('Unknown case: '+args.case)
        suite.cases=[args.case];suite.files['bootstrap']=re.sub(r'schedule function '+NS+r':case/[a-z0-9_]+ 5t',f'schedule function {NS}:case/{args.case} 5t',suite.files['bootstrap'])
        suite.files['case/'+args.case]=re.sub(r'schedule function '+NS+r':[a-z0-9_/]+ 1t',f'schedule function {NS}:finish 1t',suite.files['case/'+args.case]);suite.expected=re.findall(TOKEN+r'_PASS ([a-z0-9_]+)',suite.files['case/'+args.case])
    output=Path(tempfile.mkdtemp(prefix='fimel-weiqi-engine-'));target=output/'packs/fimel_cards'
    shutil.copytree(PACK/'data/weiqi/function/engine',target/'data/weiqi/function/engine')
    shutil.copy2(PACK/'pack.mcmeta',target/'pack.mcmeta')
    for name,body in suite.files.items():
        path=target/'data'/NS/'function'/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True);path.write_text(body,encoding='utf8')
    helpers={'weiqi/function/system/context.mcfunction':'''scoreboard players operation #table go_ctx = @s ct_id
tag @e[tag=go.board] remove go.board
tag @e[tag=go.current] remove go.current
tag @s add go.current
execute as @e[type=minecraft:marker,tag=go.square] if score @s ct_id = #table go_ctx run tag @s add go.board
''','minecraft/tags/function/load.json':json.dumps({'values':[NS+':load']}),NS+'/test_environment/default.json':json.dumps({'type':'minecraft:function','setup':NS+':bootstrap'}),NS+'/test_instance/game.json':json.dumps({'type':'minecraft:function','environment':NS+':default','function':'minecraft:always_pass','max_ticks':1,'required':True,'setup_ticks':len(suite.cases)+100,'structure':'minecraft:empty'})}
    for name,body in helpers.items():
        path=target/'data'/name;path.parent.mkdir(parents=True,exist_ok=True);path.write_text(body,encoding='utf8')
    launch=args.minecraft_root/'versions'/args.version/(args.version+'.json');meta=json.loads(launch.read_text(encoding='utf-8-sig'));cp=[launch.with_suffix('.jar')]
    for lib in meta['libraries']:
        entry=lib.get('downloads',{}).get('artifact',{});path=args.minecraft_root/'libraries'/entry.get('path','')
        if entry.get('path') and path.is_file():cp.append(path)
    options=['-Xms256M','-Xmx1536M','-Djava.awt.headless=true','-Dfile.encoding=UTF-8','--enable-native-access=ALL-UNNAMED','-cp',';'.join(map(str,cp)),'net.minecraft.gametest.Main','--packs',str(output/'packs'),'--universe',str(output/'universe'),'--tests',NS+':*','--report',str(output/'gametest.xml')]
    argfile=output/'java-args.txt';argfile.write_text('\n'.join('"'+v.replace('\\','\\\\').replace('"','\\"')+'"' for v in options),encoding='utf8')
    print('Weiqi engine GameTest: '+str(output),flush=True);start=time.monotonic()
    proc=subprocess.run([str(args.java),'@'+str(argfile)],cwd=output,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf8',errors='replace',timeout=480)
    (output/'game.log').write_text(proc.stdout,encoding='utf8')
    passed=set(re.findall(TOKEN+r'_PASS ([a-z0-9_]+)',proc.stdout));failed=sorted(set(re.findall(TOKEN+r'_FAIL ([a-z0-9_]+)',proc.stdout)))
    errors=[line for line in proc.stdout.splitlines() if any(s in line for s in ('[ERROR]','/ERROR]','Failed to load','Failed to parse','Unknown function','Unknown or incomplete command',"Couldn't parse",'Command execution stopped'))]
    result={'exit_code':proc.returncode,'seconds':round(time.monotonic()-start,1),'assertions':len(suite.expected),'passed':len(passed),'failed':failed,'missing':sorted(set(suite.expected)-passed),'errors':errors,'finished':TOKEN+'_FINISHED' in proc.stdout,'output':str(output)}
    (output/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf8');print(json.dumps(result,ensure_ascii=False,indent=2),flush=True)
    return int(bool(proc.returncode or failed or result['missing'] or errors or not result['finished']))


if __name__=='__main__':
    suite=Suite();suite.build();raise SystemExit(run(suite))
