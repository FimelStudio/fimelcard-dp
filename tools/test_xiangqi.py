"""中国象棋原版26.2整包测试，独立临时世界，不修改玩家存档。

marker 模拟对弈者覆盖规则提交、动画、时钟、设置会话与悔棋。
真人右键、Q 投掷、模型与音效仍需在客户端检查。
"""
from pathlib import Path
import argparse
import json
import re
import shutil
import subprocess
import tempfile
import time

PACK = Path(__file__).resolve().parents[1]
A = '@e[type=minecraft:marker,tag=xg.table,scores={ct_id=101},limit=1]'
B = '@e[type=minecraft:marker,tag=xg.table,scores={ct_id=202},limit=1]'


def person(side, table=101):
    return f'@e[type=minecraft:marker,tag=xq.player,scores={{xq_table={table},xq_side={side}}},limit=1]'


def square(sq, table=101):
    return f'@e[type=minecraft:marker,tag=xq.square,scores={{ct_id={table},xq_sq={sq}}},limit=1]'


class Suite:
    def __init__(self):
        self.files, self.cases, self.expected = {}, [], []

    def file(self, name, lines):
        self.files[name] = ('\n'.join(lines) if isinstance(lines, list) else lines).strip()+'\n'

    def check(self, condition, name):
        assert name not in self.expected, name
        self.expected.append(name)
        return [f'execute if {condition} run say XIANGQI_GAME_PASS {name}', f'execute unless {condition} run say XIANGQI_GAME_FAIL {name}']

    def score(self, target, objective, value, name):
        return self.check(f'score {target} {objective} matches {value}', name)

    def count(self, selector, value, name):
        return ['scoreboard players set #count xg 0',f'execute as {selector} run scoreboard players add #count xg 1']+self.score('#count','xg',value,name)

    def call(self, name, table=101):
        return [f'execute as {A if table==101 else B} at @s run function xiangqi:{name}']

    def setup(self, cap=4, table=101, reset=True):
        return (['function xiangqi_game_test:reset'] if reset else [])+[f'execute positioned {8 if table==101 else 40} 64 8 summon minecraft:marker run function xiangqi_game_test:table {{table:{table},cap:{cap}}}']

    def actor(self, side, table=101):
        return ['tag @e[tag=xq.actor] remove xq.actor',f'tag {person(side,table)} add xq.actor']

    def click(self, side, target, table=101):
        return self.actor(side,table)+[f'scoreboard players set #target xq_ctx {target}']+self.call('game/click',table)

    def move(self, side, source, target):
        return self.click(side,source)+self.click(side,target)+self.call('game/animation_done')

    def position(self, fen, turn=1, **_):
        result=self.setup()+self.call('system/context')+['scoreboard players set @e[tag=xq.board] xq_piece 0']
        pieces={'p':1,'n':2,'h':2,'b':3,'e':3,'r':4,'c':5,'k':6,'a':7}
        rows=fen.split('/')
        assert len(rows)==10, fen
        for rank,row in enumerate(rows):
            file=0
            for char in row:
                if char.isdigit(): file+=int(char);continue
                sq=(9-rank)*9+file
                result += [f'scoreboard players set {square(sq)} xq_piece {pieces[char.lower()]*(1 if char.isupper() else -1)}']
                file+=1
            assert file==9, row
        result += [f'scoreboard players set {A} xq_turn {turn}',f'data modify entity {A} data.xiangqi.history set value []']
        return result+self.call('engine/cache')+self.call('engine/history/record')+self.call('visual/refresh')

    def case(self, name, lines):
        self.cases.append(name)
        self.file('case/'+name,lines)

    def build(self):
        self.file('reset',['kill @e[tag=xq.visual]','kill @e[tag=xq.square]','kill @e[tag=xg.fixture]','kill @e[tag=ct.menu]','kill @e[tag=ct.vote]'])
        self.file('table','''
tag @s add xg.fixture
tag @s add xg.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_capacity $(cap)
scoreboard players set @s ct_game 13
scoreboard players set @s ct_state 0
scoreboard players set @s ct_joined 2
function xiangqi:game/init_table
scoreboard players set @s xq_state 1
scoreboard players set @s ct_state 1
scoreboard players set @s xq_rtime 12000
scoreboard players set @s xq_btime 12000
scoreboard players set @s xq_red 3
scoreboard players set @s xq_black 1
scoreboard players set @s xq_pulse -1000
$execute summon minecraft:marker run function xiangqi_game_test:person {table:$(table),side:1,seat:3}
$execute summon minecraft:marker run function xiangqi_game_test:person {table:$(table),side:-1,seat:1}
function xiangqi:system/context
function xiangqi:clock/create
''')
        self.file('person','''
tag @s add xg.fixture
tag @s add xq.player
tag @s add ct.player
$scoreboard players set @s xq_side $(side)
$scoreboard players set @s xq_seat $(seat)
$scoreboard players set @s ct_seat $(seat)
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s xq_table $(table)
''')
        for cap in (4,8):
            c=self.setup(cap)
            c+=self.count('@e[tag=xq.tile,scores={ct_id=101}]',90,f'preview_{cap}_cells')
            c+=self.count('@e[tag=xq.man,scores={ct_id=101}]',32,f'preview_{cap}_men')
            c+=self.count('@e[tag=xq.square,scores={ct_id=101}]',90,f'preview_{cap}_markers')
            c+=self.count('@e[tag=xq.clock,scores={ct_id=101}]',1,f'preview_{cap}_clock')
            c+=self.score(square(4),'xq_piece',6,f'preview_{cap}_red_general')+self.score(square(85),'xq_piece',-6,f'preview_{cap}_black_general')
            self.case('preview_'+str(cap),c)
        c=self.setup()+self.click(1,27)+self.score(A,'xq_sel',27,'select_soldier')+self.click(1,1)+self.score(A,'xq_sel',1,'reselect_horse')
        c+=self.click(-1,82)+self.score(A,'xq_sel',1,'wrong_turn_keeps_selection')+self.click(1,17)
        c+=self.score(A,'xq_sel',-1,'illegal_clears_selection')+self.score(square(1),'xq_piece',2,'illegal_keeps_horse')
        self.case('selection',c)
        c=self.setup()+self.click(1,27)+self.click(1,36)
        c+=self.score(A,'xq_state',2,'move_animation_locks')+self.score(A,'xq_timer',8,'animation_eight_ticks')+self.score(A,'xq_turn',-1,'turn_black')
        c+=self.score(square(27),'xq_piece',0,'source_empty')+self.score(square(36),'xq_piece',1,'destination_soldier')
        c+=self.check(f'data entity {A} data.xiangqi.last{{from:27,to:36,piece:1}}','move_metadata')
        for _ in range(8): c+=self.call('system/tick')
        c+=self.score(A,'xq_state',1,'animation_unlocks')+self.score(A,'xq_rtime',12000,'animation_pauses_red_clock')+self.score(A,'xq_btime',12000,'animation_pauses_black_clock')
        c+=self.call('system/tick')+self.score(A,'xq_btime',11999,'black_clock_ticks')
        self.case('move_and_clock',c)
        c=self.setup()+[f'scoreboard players set {A} xq_time 0']+self.call('clock/tick')+self.score(A,'xq_rtime',12000,'unlimited_no_tick')
        self.case('unlimited_clock',c)
        c=self.setup()+self.move(1,27,36)+self.actor(1)+self.call('game/offer_undo')
        c+=self.score(A,'xq_undo',1,'undo_requested')+self.call('game/accept_undo')+self.score(square(36),'xq_piece',1,'cannot_accept_own_undo')
        c+=self.actor(-1)+self.call('game/accept_undo')+self.score(square(27),'xq_piece',1,'undo_restores_source')+self.score(square(36),'xq_piece',0,'undo_clears_destination')
        c+=self.score(A,'xq_turn',1,'undo_restores_turn')+self.score(A,'xq_rtime',12000,'undo_restores_clock')+self.score(A,'xq_undo',0,'undo_clears_offer')
        c+=self.check(f'data entity {A} data.xiangqi.history[{{meta:1}}]','undo_keeps_judge_history')+self.count('@e[tag=xq.man,scores={ct_id=101}]',32,'undo_restores_men')
        self.case('undo_agreement',c)
        c=self.position('4k4/9/r8/9/4P4/9/9/9/9/R3K4')+self.move(1,0,63)
        c+=self.score(square(0),'xq_piece',0,'capture_source_empty')+self.score(square(63),'xq_piece',4,'capture_rook_arrives')
        c+=self.score(A,'xq_rcapt',1,'capture_red_tray_count')+self.check(f'data entity {A} data.xiangqi.last{{captured:-4,capture_sq:63}}','capture_metadata')
        c+=self.actor(1)+self.call('game/offer_undo')+self.actor(-1)+self.call('game/accept_undo')
        c+=self.score(square(0),'xq_piece',4,'capture_undo_red_rook')+self.score(square(63),'xq_piece',-4,'capture_undo_black_rook')+self.score(A,'xq_rcapt',0,'capture_undo_tray_count')
        self.case('capture_undo',c)
        c=self.setup()+self.actor(1)+self.call('game/offer_draw')+self.call('game/accept_draw')+self.score(A,'xq_state',1,'cannot_accept_own_draw')
        c+=self.actor(-1)+self.call('game/accept_draw')+self.score(A,'xq_result',3,'agreed_draw_result')+self.score(A,'xq_reason',8,'agreed_draw_reason')+self.score(A,'xq_state',4,'agreed_draw_finishes')
        self.case('draw',c)
        c=self.setup()+self.move(1,27,36)+self.actor(1)+self.call('game/resign')+self.score(A,'xq_result',2,'red_resign_black_wins')+self.score(A,'xq_reason',7,'resign_reason')
        c+=self.call('game/cleanup')+self.score(A,'ct_state',0,'cleanup_lobby')+self.check(f'data entity {A} data.xiangqi{{review:1b}}','cleanup_review_flag')
        c+=self.count('@e[tag=xq.man,scores={ct_id=101}]',32,'cleanup_keeps_final_board')+self.count('@e[tag=xq.clock,scores={ct_id=101}]',0,'cleanup_removes_clock')
        c+=self.call('game/preview')+self.count('@e[tag=xq.man,scores={ct_id=101}]',32,'preview_preserves_review')
        c+=self.score(square(27),'xq_piece',0,'review_keeps_final_source')+self.score(square(36),'xq_piece',1,'review_keeps_final_destination')
        self.case('resign_review',c)
        c=self.setup()+[f'scoreboard players set {A} xq_rtime 1']+self.call('clock/tick')
        c+=self.score(A,'xq_result',2,'red_timeout_black_wins')+self.score(A,'xq_reason',6,'timeout_reason')
        self.case('timeout',c)
        c=self.setup()+self.setup(table=202,reset=False)+self.move(1,27,36)
        c+=self.score(square(27,202),'xq_piece',1,'other_table_source_unchanged')+self.score(B,'xq_turn',1,'other_table_turn_unchanged')
        c+=self.call('game/remove')+self.count('@e[tag=xq.visual,scores={ct_id=101}]',0,'remove_clears_visuals')+self.count('@e[tag=xq.square,scores={ct_id=101}]',0,'remove_clears_markers')
        c+=self.count('@e[tag=xq.man,scores={ct_id=202}]',32,'remove_keeps_other_table')
        self.case('isolation',c)
        # Full settings/save path with session validation; no UI actor is necessary to test the persisted field.
        for field,value,obj,want in [(5,0,'time',0),(5,5,'time',5),(5,30,'time',30),(5,7,'time',10),(4,8,'first',0),(6,3,'level',3),(6,4,'level',2),(7,0,'hints',0),(7,2,'hints',1)]:
            key=f'setting_{field}_{value}'
            c=self.setup()+[f'scoreboard players set {A} ct_state 0',f'scoreboard players operation {person(1)} xq_nonce = #ui_load xq_ctx',f'scoreboard players set {person(1)} xq_setnonce 100000',f'scoreboard players set {person(1)} xq_set_table 101',f'scoreboard players operation {person(1)} xq_setepoch = {A} xq_epoch',f'scoreboard players set {person(1)} xq_settings {100000000+field*100+value}',f'execute as {person(1)} at @s run function xiangqi:settings/save']
            self.case(key,c+self.score(A,'xq_'+obj,want,key))
        def settings_session():
            return self.setup()+[f'scoreboard players set {A} ct_state 0',f'scoreboard players operation {person(1)} xq_nonce = #ui_load xq_ctx',f'scoreboard players set {person(1)} xq_setnonce 100000',f'scoreboard players set {person(1)} xq_set_table 101',f'scoreboard players operation {person(1)} xq_setepoch = {A} xq_epoch']
        def settings_submit(value):
            return [f'scoreboard players set {person(1)} xq_settings {100000600+value}',f'execute as {person(1)} at @s run function xiangqi:settings/save']
        c=settings_session()+settings_submit(3)+self.score(A,'xq_level',3,'valid_nonce_applies')
        c+=settings_submit(1)+self.score(A,'xq_level',3,'replayed_nonce_rejected')
        self.case('settings_replay',c)
        for name,change in [('wrong_table',[f'scoreboard players set {person(1)} ct_id 202']),('epoch_changed',[f'scoreboard players add {A} xq_epoch 1']),('game_changed',[f'scoreboard players set {A} ct_game 12']),('reload',['function xiangqi:load'])]:
            c=settings_session()+change+settings_submit(1)+self.score(A,'xq_level',2,'stale_settings_'+name)
            self.case('stale_settings_'+name,c)
        c=settings_session()+[f'execute as {person(1)} at @s run function cardtable:seat/leave',f'tag {person(1)} add ct.player',f'scoreboard players set {person(1)} ct_id 101']
        c+=settings_submit(1)+self.score(A,'xq_level',2,'leave_rejoin_invalidates_settings')
        self.case('settings_leave_rejoin',c)
        self.case('dialogs',['function xiangqi_game_test:dialogs','say XIANGQI_GAME_DIALOGS_DONE'])
        self.file('dialogs',(PACK/'tools/test_xiangqi_dialogs.mcfunction').read_text(encoding='utf-8'))
        self.file('finish',['function xiangqi_game_test:reset','say XIANGQI_GAME_FINISHED'])
        self.file('bootstrap',['forceload add -16 -16 63 31','scoreboard objectives add xg dummy','function xiangqi:load','schedule function xiangqi_game_test:case/'+self.cases[0]+' 40t'])
        for i,name in enumerate(self.cases):
            self.files['case/'+name]+='schedule function xiangqi_game_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 3t\n'


def run(suite, prefix='fimel-xiangqi-game-', setup_ticks=240, manual_tick=False):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--java',type=Path,default=Path('C:/Temp/fimel-uno-java25/jdk-25.0.5+8-jre/bin/java.exe'))
    parser.add_argument('--minecraft-root',type=Path,default=Path('D:/PCL2/MinecraftPcl'))
    parser.add_argument('--version',default='26.2-Fabric_0.19.3')
    args=parser.parse_args()
    output=Path(tempfile.mkdtemp(prefix=prefix));target=output/'packs/fimel_cards'
    shutil.copytree(PACK/'data',target/'data');shutil.copy2(PACK/'pack.mcmeta',target/'pack.mcmeta')
    if manual_tick:
        (target/'data/minecraft/tags/function/tick.json').write_text('{"values":[]}',encoding='utf-8')
    # Marker participants cannot have inventories or receive dialogs. Gameplay selectors are
    # widened only in the isolated copy; real tellraw/dialog targets remain player selectors.
    for path in (target/'data/xiangqi/function').rglob('*.mcfunction'):
        body=path.read_text(encoding='utf-8')
        lines=[]
        for line in body.splitlines():
            if not any(token in line for token in ['tellraw ', 'dialog ', 'title ', 'input/give', 'input/clear', 'clear @s', 'give @s', 'item replace']):
                line=line.replace('@a[tag=xq.audience','@e[tag=xq.audience')
            lines.append(line)
        path.write_text('\n'.join(lines)+'\n',encoding='utf-8')
    for name,body in suite.files.items():
        dest=target/'data/xiangqi_game_test/function'/(name+'.mcfunction');dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(body,encoding='utf-8')
    for name,body in {'test_environment/default.json':{'type':'minecraft:function','setup':'xiangqi_game_test:bootstrap'},'test_instance/game.json':{'type':'minecraft:function','environment':'xiangqi_game_test:default','function':'minecraft:always_pass','max_ticks':1,'setup_ticks':setup_ticks,'required':True,'structure':'minecraft:empty'}}.items():
        dest=target/'data/xiangqi_game_test'/name;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(json.dumps(body),encoding='utf-8')
    launch=args.minecraft_root/'versions'/args.version/(args.version+'.json')
    meta=json.loads(launch.read_text(encoding='utf-8-sig'));classpath=[launch.with_suffix('.jar')]
    for lib in meta['libraries']:
        entry=lib.get('downloads',{}).get('artifact',{})
        if entry.get('path'):
            path=args.minecraft_root/'libraries'/entry['path']
            if path.is_file(): classpath.append(path)
    options=['-Xms256M','-Xmx1536M','-Djava.awt.headless=true','-Dfile.encoding=UTF-8','--enable-native-access=ALL-UNNAMED','-cp',';'.join(map(str,classpath)),'net.minecraft.gametest.Main','--packs',str(output/'packs'),'--universe',str(output/'universe'),'--tests','xiangqi_game_test:*','--report',str(output/'gametest.xml')]
    argfile=output/'java-args.txt';argfile.write_text('\n'.join('"'+v.replace('\\','\\\\').replace('"','\\"')+'"' for v in options),encoding='utf-8')
    print('Xiangqi integration GameTest: '+str(output),flush=True);start=time.monotonic()
    proc=subprocess.run([str(args.java),'@'+str(argfile)],cwd=output,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf-8',errors='replace',timeout=max(180,setup_ticks/20+180))
    (output/'game.log').write_text(proc.stdout,encoding='utf-8')
    passed=set(re.findall(r'XIANGQI_GAME_PASS ([a-z0-9_]+)',proc.stdout));failed=sorted(set(re.findall(r'XIANGQI_GAME_FAIL ([a-z0-9_]+)',proc.stdout)))
    errors=[line for line in proc.stdout.splitlines() if any(s in line for s in ['[ERROR]','/ERROR]','Failed to load','Failed to parse','Unknown function','Unknown or incomplete command',"Couldn't parse",'Command execution stopped'])]
    result={'exit_code':proc.returncode,'seconds':round(time.monotonic()-start,1),'assertions':len(suite.expected),'passed':len(passed),'failed':failed,'missing':sorted(set(suite.expected)-passed),'errors':errors,'finished':'XIANGQI_GAME_FINISHED' in proc.stdout,'dialogs':'XIANGQI_DIALOGS_END' in proc.stdout,'output':str(output)}
    (output/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(result,ensure_ascii=False,indent=2),flush=True)
    return int(bool(proc.returncode or failed or result['missing'] or errors or not result['finished'] or not result['dialogs']))


if __name__=='__main__':
    suite=Suite();suite.build();raise SystemExit(run(suite))
