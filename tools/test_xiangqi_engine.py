"""独立原版 26.2 中国象棋规则 GameTest；只复制 engine/，绝不改写玩家世界。"""
from pathlib import Path
import argparse
import json
import random
import re
import shutil
import subprocess
import sys
import tempfile
import time

PACK=Path(__file__).resolve().parents[1]
C='@e[type=minecraft:marker,tag=xe.controller,scores={ct_id=101},limit=1]'


def cell(i, table=101):
    return f'@e[type=minecraft:marker,tag=xq.square,scores={{ct_id={table},xq_sq={i}}},limit=1]'


class Suite:
    def __init__(self): self.files,self.cases,self.expected={},[],[]
    def file(self,name,body): self.files[name]=('\n'.join(body) if isinstance(body,list) else body).strip()+'\n'
    def case(self,name,body): self.cases.append(name);self.file('case/'+name,body)
    def check(self,condition,name):
        assert name not in self.expected,name
        self.expected.append(name)
        return [f'execute if {condition} run say XIANGQI_ENGINE_PASS {name}',f'execute unless {condition} run say XIANGQI_ENGINE_FAIL {name}']
    def score(self,who,obj,val,name): return self.check(f'score {who} {obj} matches {val}',name)
    def piece(self,i,val,name): return self.score(cell(i),'xq_piece',val,name)
    def call(self,path): return [f'execute as {C} at @s run function xiangqi:{path}']
    def setup(self,pieces=None,turn=1,half=0,raw=False):
        lines=['function xiangqi_engine_test:reset','execute positioned 0 70 0 summon minecraft:marker run function xiangqi_engine_test:controller']
        lines += [f'execute positioned 0 70 0 summon minecraft:marker run function xiangqi_engine_test:square {{sq:{i}}}' for i in range(90)]
        if pieces is None:return lines+self.call('engine/init_board')
        pieces={**({} if raw else {4:6,85:-6,40:1}),**pieces}
        lines += [f'scoreboard players set {cell(i)} xq_piece {p}' for i,p in pieces.items()]
        lines += [f'scoreboard players set {C} xq_turn {turn}',f'scoreboard players set {C} xq_half {half}',f'scoreboard players set {C} xq_full 1',f'scoreboard players set {C} xq_repetition 0']
        return lines+self.call('system/context')+self.call('engine/cache')+self.call('engine/history/record')
    def move(self,a,b):return [f'scoreboard players set #from xq_ctx {a}',f'scoreboard players set #to xq_ctx {b}']+self.call('engine/try_move')
    def probe(self,a,b):return [f'scoreboard players set #from xq_ctx {a}',f'scoreboard players set #to xq_ctx {b}']+self.call('engine/check_move')

    def build(self,oracle=None):
        objectives='xq_ctx xq_piece xq_sq ct_id xq_state xq_turn xq_half xq_full xq_result xq_reason xq_check xq_repetition xq_variant xq_hidden xq_covered xe'.split()
        self.file('load',[f'scoreboard objectives add {o} dummy' for o in objectives]+['scoreboard players set #minus xq_ctx -1'])
        self.file('reset','kill @e[tag=xe.fixture]')
        self.file('controller','tag @s add xe.fixture\ntag @s add xe.controller\ntag @s add xq.controller\nscoreboard players set @s ct_id 101\nscoreboard players set @s xq_state 1\nscoreboard players set @s xe 0\ndata modify entity @s data.xiangqi.history set value []')
        self.file('square','tag @s add xe.fixture\ntag @s add xq.square\nscoreboard players set @s ct_id 101\n$scoreboard players set @s xq_sq $(sq)\nscoreboard players set @s xq_piece 0')
        c=self.setup()+self.piece(0,4,'initial_red_rook')+self.piece(4,6,'initial_red_general')+self.piece(85,-6,'initial_black_general')+self.piece(19,5,'initial_red_cannon')+self.piece(70,-5,'initial_black_cannon')
        c+=self.score(C,'xq_repetition',1,'initial_history')+self.move(27,36)+self.score('#legal','xq_ctx',1,'initial_pawn_advance')+self.score(C,'xq_turn',-1,'turn_toggles')+self.piece(27,0,'source_cleared')+self.piece(36,1,'destination_applied')
        c+=self.move(54,45)+self.score('#legal','xq_ctx',1,'black_pawn_advance')+self.score(C,'xq_full',2,'fullmove_after_black')
        c+=self.check(f'data entity {C} data.xiangqi.last{{from:54,to:45,piece:-1,captured:0,capture_sq:-1,rook_from:-1,rook_to:-1,promotion:0}}','last_metadata')
        self.case('opening',c)
        cases=[
            ('red_pawn_before_river_forward',{27:1},1,27,36,1),
            ('red_pawn_before_river_sideways',{27:1},1,27,28,0),
            ('red_pawn_never_backwards',{45:1},1,45,36,0),
            ('red_pawn_crossed_sideways',{45:1},1,45,46,1),
            ('black_pawn_before_river_forward',{54:-1},-1,54,45,1),
            ('black_pawn_before_river_sideways',{54:-1},-1,54,55,0),
            ('black_pawn_crossed_sideways',{36:-1},-1,36,37,1),
            ('black_pawn_never_backwards',{36:-1},-1,36,45,0),
            ('horse_long_rank',{10:2},1,10,29,1),
            ('horse_rank_leg_blocked',{10:2,19:1},1,10,29,0),
            ('horse_long_file',{10:2},1,10,21,1),
            ('horse_file_leg_blocked',{10:2,11:1},1,10,21,0),
            ('horse_wrong_shape',{10:2},1,10,30,0),
            ('elephant_two_diagonal',{2:3},1,2,22,1),
            ('elephant_eye_blocked',{2:3,12:1},1,2,22,0),
            ('red_elephant_cannot_cross',{38:3},1,38,58,0),
            ('black_elephant_cannot_cross',{51:-3},-1,51,31,0),
            ('red_advisor_diagonal',{3:7},1,3,13,1),
            ('red_advisor_leaves_palace',{21:7},1,21,29,0),
            ('black_advisor_diagonal',{84:-7},-1,84,76,1),
            ('general_one_step',{},1,4,13,1),
            ('general_leaves_palace',{4:0,22:6},1,22,31,0),
            ('general_cannot_diagonal',{},1,4,14,0),
            ('rook_free_file',{0:4},1,0,72,1),
            ('rook_blocked',{0:4,18:1},1,0,72,0),
            ('rook_captures_first',{0:4,18:-1},1,0,18,1),
            ('rook_not_diagonal',{0:4},1,0,20,0),
            ('cannon_quiet_without_screen',{18:5},1,18,72,1),
            ('cannon_quiet_cannot_jump',{18:5,45:1},1,18,72,0),
            ('cannon_capture_exactly_one_screen',{18:5,45:1,72:-4},1,18,72,1),
            ('cannon_capture_no_screen',{18:5,72:-4},1,18,72,0),
            ('cannon_capture_two_screens',{18:5,45:1,54:-1,72:-4},1,18,72,0),
            ('self_capture_forbidden',{0:4,9:1},1,0,9,0),
            ('capture_general_forbidden',{76:4},1,76,85,0),
            ('facing_generals_forbids_unpin',{40:4},1,40,41,0),
            ('facing_generals_can_keep_file',{40:4},1,40,49,1),
            ('selfcheck_rook_pin',{40:4,76:-4},1,40,41,0),
            ('wrong_side_piece',{0:-4},1,0,9,0),
            ('empty_source',{},1,0,9,0),
        ]
        for name,pieces,side,a,b,legal in cases:
            c=self.setup(pieces,side)+self.probe(a,b)+self.score('#legal','xq_ctx',legal,name)
            c+=self.piece(a,({4:6,85:-6,40:1,**pieces}).get(a,0),name+'_probe_nonmutating')+self.score(C,'xq_turn',side,name+'_turn_preserved')
            self.case(name,c)
        # 守方被将军时不能走无关子；将帅照面的局面可移将横向脱离。
        c=self.setup({40:0,76:-4,0:4})+self.probe(0,9)+self.score('#legal','xq_ctx',0,'cannot_ignore_check')+self.probe(4,3)+self.score('#legal','xq_ctx',1,'general_can_evade_check')
        self.case('check_escape',c)
        c=self.setup({40:0})+self.call('engine/evaluate')+self.score(C,'xq_check',1,'facing_generals_is_check')+self.probe(4,3)+self.score('#legal','xq_ctx',1,'facing_general_side_escape')
        self.case('facing_check',c)
        c=self.setup({40:0,49:4})+['scoreboard players set #attack_sq xq_ctx 49','scoreboard players set #attacker xq_ctx -1']+self.call('engine/attack')+self.score('#attacked','xq_ctx',0,'flying_general_cannot_capture_distant_ordinary_piece')
        c+=self.setup({40:0,49:-4})+['scoreboard players set #attack_sq xq_ctx 49','scoreboard players set #attacker xq_ctx 1']+self.call('engine/attack')+self.score('#attacked','xq_ctx',0,'red_flying_general_ordinary_piece_not_attacked')
        c+=self.setup({40:0})+['scoreboard players set #attack_sq xq_ctx 4','scoreboard players set #attacker xq_ctx -1']+self.call('engine/attack')+self.score('#attacked','xq_ctx',1,'black_flying_general_attacks_red_general')
        c+=['scoreboard players set #attack_sq xq_ctx 85','scoreboard players set #attacker xq_ctx 1']+self.call('engine/attack')+self.score('#attacked','xq_ctx',1,'red_flying_general_attacks_black_general')
        c+=self.setup({40:0,76:4})+['scoreboard players set #attack_sq xq_ctx 76','scoreboard players set #attacker xq_ctx -1']+self.call('engine/attack')+self.score('#attacked','xq_ctx',1,'general_normal_adjacent_piece_attack_preserved')
        self.case('flying_attack_target',c)
        # 黑将在e10，红车占d9/f9并控制d/e/f九宫三条出口；区分将死与困毙。
        c=self.setup({40:1,75:4,77:4},turn=-1)+self.call('engine/evaluate')+self.score(C,'xq_result',1,'stalemate_is_red_win')+self.score(C,'xq_reason',2,'stalemate_reason')+self.score(C,'xq_check',0,'stalemate_not_check')
        self.case('stalemate',c)
        c=self.setup({40:1,75:4,77:4,67:4},turn=-1)+self.call('engine/evaluate')+self.score(C,'xq_result',1,'checkmate_red_win')+self.score(C,'xq_reason',1,'checkmate_reason')+self.score(C,'xq_check',1,'checkmate_is_check')
        self.case('mate',c)
        c=self.setup({4:0,3:6,40:0,85:-6,2:3,5:7,83:-3,86:-7})+self.call('engine/evaluate')+self.score(C,'xq_result',3,'defensive_pieces_only_draw')+self.score(C,'xq_reason',3,'defensive_draw_reason')
        self.case('material',c)
        c=self.setup({0:4},half=119)+self.move(0,9)+self.call('engine/evaluate')+self.score(C,'xq_half',120,'natural_count_120')+self.score(C,'xq_result',3,'natural_count_draw')+self.score(C,'xq_reason',5,'natural_count_reason')
        self.case('natural_count',c)
        c=self.setup({0:4,9:-1},half=119)+self.move(0,9)+self.score(C,'xq_half',0,'capture_resets_natural_count')+self.check(f'data entity {C} data.xiangqi.last{{captured:-1,capture_sq:9}}','capture_metadata')
        self.case('capture',c)
        c=self.setup()
        for _ in range(2):
            for a,b in [(1,20),(82,65),(20,1),(65,82)]:c+=self.move(a,b)
        c+=self.score(C,'xq_repetition',3,'threefold_count')+self.call('engine/evaluate')+self.score(C,'xq_result',3,'threefold_draw')+self.score(C,'xq_reason',4,'threefold_reason')
        self.case('threefold',c)
        # 红车d9-e9持续将军，黑将d10-e10往返；红方为唯一连续将军方，应判负。
        c=self.setup({40:1,85:0,84:-6,75:4},turn=-1)
        for _ in range(2):
            for a,b in [(84,85),(75,76),(85,84),(76,75)]:c+=self.move(a,b)
        c+=self.score(C,'xq_repetition',3,'perpetual_count')+self.call('engine/evaluate')+self.score(C,'xq_result',2,'red_perpetual_check_loses')+self.score(C,'xq_reason',4,'perpetual_reason')
        self.case('perpetual_check',c)
        # 悔棋会复制整个 history，本测试单独验证复制后继续走得到正确的重复计数。
        c=self.setup()+['data modify storage xiangqi_engine_test:undo history set from entity '+C+' data.xiangqi.history']+self.move(1,20)+['data modify entity '+C+' data.xiangqi.history set from storage xiangqi_engine_test:undo history']
        c+=self.check('data entity '+C+' data.xiangqi.history[{meta:1,rquiet:0,bquiet:0,loser:0}]','history_snapshot_has_all_adjudication_state')
        self.case('history_snapshot',c)
        for name,changes in [
            ('missing',[f'kill {cell(36)}']),
            ('duplicate',['execute positioned 0 70 0 summon minecraft:marker run function xiangqi_engine_test:square {sq:36}']),
            ('invalid_piece',[f'scoreboard players set {cell(36)} xq_piece 8']),
            ('missing_general',[f'scoreboard players set {cell(85)} xq_piece 0']),
        ]:
            c=self.setup()+changes+self.move(27,36)+self.score('#cache_ok','xq_ctx',0,name+'_cache_rejected')+self.score('#legal','xq_ctx',0,name+'_move_rejected')+self.call('engine/evaluate')+self.score(C,'xq_reason',11,name+'_safe_error')
            self.case('invalid_'+name,c)
        c=self.setup({0:4})+['scoreboard players set #side xq_ctx -1']+self.call('engine/can_mate')+self.score('#can_mate','xq_ctx',0,'bare_general_cannot_win_on_time')+['scoreboard players set #side xq_ctx 1']+self.call('engine/can_mate')+self.score('#can_mate','xq_ctx',1,'rook_can_win_on_time')
        self.case('timeout_material',c)
        # 第二张桌子的重复格不会污染本桌缓存。
        c=self.setup()+['execute positioned 2 70 0 summon minecraft:marker run function xiangqi_engine_test:other_square']+self.move(27,36)+self.score('#legal','xq_ctx',1,'other_table_isolation')+self.score(cell(36,202),'xq_piece',-4,'other_table_not_changed')
        self.case('table_isolation',c)
        self.file('other_square','tag @s add xe.fixture\ntag @s add xq.square\nscoreboard players set @s ct_id 202\nscoreboard players set @s xq_sq 36\nscoreboard players set @s xq_piece -4')
        # 标准象棋初始局面独立全格枚举：perft(1)=44，不调用生产候选生成器。
        # 单个源格分三刻探测，保持默认命令链上限。
        sources=[i for i,p in enumerate([4,2,3,7,6,7,3,2,4]+[0]*81) if p]+[19,25,27,29,31,33,35]
        for ix,source in enumerate(sources):
            for part in range(3):
                c=self.setup() if ix==0 and part==0 else []
                if ix==0 and part==0:c+=['scoreboard players set #perft xe 0']
                c+=self.call('system/context')+self.call('engine/cache')
                for target in range(part*30,(part+1)*30):
                    c+=self.probe(source,target)+['execute if score #legal xq_ctx matches 1 run scoreboard players add #perft xe 1']
                if ix==len(sources)-1 and part==2:c+=self.score('#perft','xe',44,'initial_perft_one_44')
                self.case(f'perft1_{source}_{part}',c)
        if oracle:
            # 独立官方 Fairy-Stockfish 的 UCI perft；程序只用于临时验收，不随包发布。
            # https://github.com/fairy-stockfish/Fairy-Stockfish/releases/tag/fairy_sf_14
            def reference(moves):
                commands='setoption name UCI_Variant value xiangqi\nposition startpos'+(' moves '+' '.join(moves) if moves else '')+'\nd\ngo perft 1\nquit\n'
                result=subprocess.run([str(oracle)],input=commands,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,timeout=20)
                assert result.returncode==0,result.stdout
                fen=re.search(r'^Fen: (.+)$',result.stdout,re.M).group(1)
                legal=re.findall(r'^([a-i](?:10|[1-9])[a-i](?:10|[1-9])): 1$',result.stdout,re.M)
                assert legal,fen
                return fen,legal
            rng=random.Random(261031)
            moves=[]
            positions=[reference(moves)]
            for ply in range(1,65):
                _,legal=reference(moves)
                moves.append(rng.choice(legal))
                if ply in (15,32,64):positions.append(reference(moves))
            for index,(fen,legal) in enumerate(positions):
                board={}
                for rank,row in enumerate(fen.split()[0].split('/')[::-1]):
                    file=0
                    for ch in row:
                        if ch.isdigit():file+=int(ch);continue
                        board[rank*9+file]={'p':1,'n':2,'b':3,'r':4,'c':5,'k':6,'a':7}[ch.lower()]*(1 if ch.isupper() else -1)
                        file+=1
                turn=1 if fen.split()[1]=='w' else -1
                pairs=set()
                for move in legal:
                    match=re.fullmatch(r'([a-i])(10|[1-9])([a-i])(10|[1-9])',move)
                    a=(ord(match[1])-97)+(int(match[2])-1)*9
                    b=(ord(match[3])-97)+(int(match[4])-1)*9
                    pairs.add((a,b))
                sources=sorted(i for i,p in board.items() if p*turn>0)
                for source in sources:
                    for part in range(3):
                        c=self.setup(board,turn,raw=True)
                        for target in range(part*30,(part+1)*30):
                            c+=self.probe(source,target)+self.score('#legal','xq_ctx',int((source,target) in pairs),f'oracle_{index}_{source}_{target}')
                        self.case(f'oracle_{index}_{source}_{part}',c)
        self.file('finish',['say XIANGQI_ENGINE_FINISHED','function xiangqi_engine_test:reset'])
        self.file('bootstrap',['forceload add 0 0 15 15','schedule function xiangqi_engine_test:case/'+self.cases[0]+' 5t'])
        for i,name in enumerate(self.cases):self.files['case/'+name]+=('schedule function xiangqi_engine_test:case/'+self.cases[i+1]+' 1t\n') if i+1<len(self.cases) else 'function xiangqi_engine_test:finish\n'


def run(args, suite=None):
    output=args.output.resolve() if args.output else Path(tempfile.mkdtemp(prefix='fimel-xiangqi-engine-'))
    if args.output:output.mkdir(parents=True,exist_ok=False)
    target=output/'packs'/'xiangqi_engine'
    shutil.copytree(args.pack/'data/xiangqi/function/engine',target/'data/xiangqi/function/engine')
    shutil.copy2(args.pack/'pack.mcmeta',target/'pack.mcmeta')
    if suite is None:
        suite=Suite();suite.build(args.oracle)
    for name,body in suite.files.items():
        path=target/'data/xiangqi_engine_test/function'/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True);path.write_text(body,encoding='utf-8')
    helpers={
        'xiangqi/function/system/context.mcfunction':'scoreboard players operation #table xq_ctx = @s ct_id\ntag @e[tag=xq.board] remove xq.board\nexecute as @e[type=minecraft:marker,tag=xq.square] if score @s ct_id = #table xq_ctx run tag @s add xq.board\n',
        'xiangqi/function/game/after_move.mcfunction':'scoreboard players add @s xe 1\n',
        'minecraft/tags/function/load.json':json.dumps({'values':['xiangqi_engine_test:load']}),
        'xiangqi_engine_test/test_environment/default.json':json.dumps({'type':'minecraft:function','setup':'xiangqi_engine_test:bootstrap'}),
        'xiangqi_engine_test/test_instance/engine.json':json.dumps({'type':'minecraft:function','environment':'xiangqi_engine_test:default','function':'minecraft:always_pass','max_ticks':1,'required':True,'setup_ticks':len(suite.cases)+30,'structure':'minecraft:empty'}),
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
    options=['-Xms256M','-Xmx1536M','-Djava.awt.headless=true','-Dfile.encoding=UTF-8','--enable-native-access=ALL-UNNAMED','-cp',';'.join(map(str,classpath)),'net.minecraft.gametest.Main','--packs',str(output/'packs'),'--universe',str(output/'universe'),'--tests','xiangqi_engine_test:*','--report',str(output/'gametest.xml')]
    argfile=output/'java-args.txt';argfile.write_text('\n'.join('"'+v.replace('\\','\\\\').replace('"','\\"')+'"' for v in options),encoding='utf-8')
    print('Xiangqi engine GameTest: '+str(output),flush=True);start=time.monotonic()
    proc=subprocess.run([str(args.java),'@'+str(argfile)],cwd=output,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf-8',errors='replace',timeout=240)
    (output/'game.log').write_text(proc.stdout,encoding='utf-8')
    passed=set(re.findall(r'XIANGQI_ENGINE_PASS ([a-z0-9_]+)',proc.stdout));failed=sorted(set(re.findall(r'XIANGQI_ENGINE_FAIL ([a-z0-9_]+)',proc.stdout)));missing=sorted(set(suite.expected)-passed)
    errors=[s for s in proc.stdout.splitlines() if any(p in s for p in ('[ERROR]','/ERROR]','Failed to load','Failed to parse','Unknown function','Unknown or incomplete command',"Couldn't parse",'Command execution stopped'))]
    result={'exit_code':proc.returncode,'seconds':round(time.monotonic()-start,1),'assertions':len(suite.expected),'passed':len(passed),'failed':failed,'missing':missing,'errors':errors,'finished':'XIANGQI_ENGINE_FINISHED' in proc.stdout,'output':str(output)}
    (output/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(result,ensure_ascii=False,indent=2),flush=True)
    return int(bool(proc.returncode or failed or missing or errors or not result['finished']))


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pack',type=Path,default=PACK);parser.add_argument('--minecraft-root',type=Path,default=Path('D:/PCL2/MinecraftPcl'));parser.add_argument('--version',default='26.2-Fabric_0.19.3');parser.add_argument('--java',type=Path,default=Path('C:/Temp/fimel-uno-java25/jdk-25.0.5+8-jre/bin/java.exe'));parser.add_argument('--output',type=Path);parser.add_argument('--oracle',type=Path,help='可选官方 Fairy-Stockfish largeboard 程序，追加随机局面全格差分')
    sys.exit(run(parser.parse_args()))
