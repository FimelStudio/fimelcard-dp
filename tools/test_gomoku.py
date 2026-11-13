"""在独立原版26.2临时世界验证五子棋对局、计时、悔棋、坐标输入与面板会话。"""
from pathlib import Path
import argparse,json,re,shutil,subprocess,tempfile,time
from collections import Counter

PACK=Path(__file__).resolve().parents[1]
A='@e[type=minecraft:marker,tag=gg.table,scores={ct_id=101},limit=1]'
B='@e[type=minecraft:marker,tag=gg.table,scores={ct_id=202},limit=1]'
def person(side,table=101):return f'@e[type=minecraft:marker,tag=gm.player,scores={{gm_table={table},gm_side={side}}},limit=1]'
def square(sq,table=101):return f'@e[type=minecraft:marker,tag=gm.square,scores={{ct_id={table},gm_sq={sq}}},limit=1]'

class Suite:
    def __init__(self):self.files,self.cases,self.expected={ },[],[]
    def file(self,name,lines):self.files[name]=('\n'.join(lines) if isinstance(lines,list) else lines).strip()+'\n'
    def check(self,condition,name):
        assert name not in self.expected,name
        self.expected.append(name)
        return [f'execute if {condition} run say GOMOKU_GAME_PASS {name}',f'execute unless {condition} run say GOMOKU_GAME_FAIL {name}']
    def score(self,target,obj,value,name):return self.check(f'score {target} {obj} matches {value}',name)
    def count(self,selector,value,name):return ['scoreboard players set #count gg 0',f'execute as {selector} run scoreboard players add #count gg 1']+self.score('#count','gg',value,name)
    def call(self,name,table=101):return [f'execute as {A if table==101 else B} at @s run function gomoku:{name}']
    def setup(self,cap=4,size=15,table=101,reset=True):return (['function gomoku_game_test:reset'] if reset else [])+[f'execute positioned {8 if table==101 else 40} 64 8 summon minecraft:marker run function gomoku_game_test:table {{table:{table},cap:{cap},size:{size}}}']
    def actor(self,side,table=101):return ['tag @e[tag=gm.actor] remove gm.actor',f'tag {person(side,table)} add gm.actor']
    def click(self,side,sq,table=101):return self.actor(side,table)+[f'scoreboard players set #target gm_ctx {sq}']+self.call('game/click',table)
    def move(self,side,sq):return self.click(side,sq)+self.call('game/animation_done')
    def case(self,name,lines):self.cases.append(name);self.file('case/'+name,lines)
    def settings_session(self):return self.setup()+[f'scoreboard players set {A} ct_state 0',f'scoreboard players operation {person(1)} gm_nonce = #ui_load gm_ctx',f'scoreboard players set {person(1)} gm_setnonce 10000',f'scoreboard players set {person(1)} gm_set_table 101',f'scoreboard players operation {person(1)} gm_setepoch = {A} gm_epoch']
    def settings_submit(self,field,value):return [f'scoreboard players set {person(1)} gm_settings {100000000+field*100+value}',f'execute as {person(1)} at @s run function gomoku:settings/save']
    def coordinate(self,row,col,nonce=1000):return [f'scoreboard players operation {person(1)} gm_coordload = #ui_load gm_ctx',f'scoreboard players operation {person(1)} gm_coordepoch = {A} gm_epoch',f'scoreboard players set {person(1)} gm_coordnonce {nonce}',f'scoreboard players set {person(1)} gm_coordtable 101',f'scoreboard players set {person(1)} gm_coord {nonce}{row}0{col}',f'execute as {person(1)} at @s run function gomoku:input/coordinate_submit']
    def build(self):
        self.file('reset',['kill @e[tag=gm.visual]','kill @e[tag=gm.square]','kill @e[tag=gg.fixture]','kill @e[tag=ct.menu]','kill @e[tag=ct.vote]'])
        self.file('table','''
tag @s add gg.fixture
tag @s add gg.table
tag @s add ct.controller
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ct_capacity $(cap)
$scoreboard players set @s gm_size $(size)
scoreboard players set @s ct_game 14
scoreboard players set @s ct_state 0
scoreboard players set @s ct_joined 2
function gomoku:game/init_table
scoreboard players set @s gm_state 1
scoreboard players set @s ct_state 1
scoreboard players set @s gm_btime 12000
scoreboard players set @s gm_wtime 12000
scoreboard players set @s gm_black 3
scoreboard players set @s gm_white 1
scoreboard players set @s gm_pulse -1000
$execute summon minecraft:marker run function gomoku_game_test:person {table:$(table),side:1,seat:3}
$execute summon minecraft:marker run function gomoku_game_test:person {table:$(table),side:-1,seat:1}
function gomoku:system/context
function gomoku:clock/create
''')
        self.file('person','''
tag @s add gg.fixture
tag @s add gm.player
tag @s add ct.player
$scoreboard players set @s gm_side $(side)
$scoreboard players set @s gm_seat $(seat)
$scoreboard players set @s ct_seat $(seat)
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s gm_table $(table)
''')
        for cap in (4,8):
            for size in (13,15,19):
                key=f'preview_{cap}_{size}'
                c=self.setup(cap,size)+self.count('@e[tag=gm.square,scores={ct_id=101}]',size*size,key+'_markers')
                c+=self.score(square((size-1)*19+size-1),'gm_piece',0,key+'_edge')+self.score(A,'gm_turn',1,key+'_black_first')
                self.case(key,c)
        c=self.setup()+self.click(-1,0)+self.score(square(0),'gm_piece',0,'wrong_turn_ignored')+self.click(1,0)
        c+=self.score(square(0),'gm_piece',1,'black_stone_placed')+self.score(A,'gm_moves',1,'one_move_recorded')+self.score(A,'gm_turn',-1,'turn_white')
        c+=self.score(A,'gm_state',2,'move_animation_locks')+self.score(A,'gm_timer',6,'move_animation_six_ticks')
        c+=self.click(-1,1)+self.score(square(1),'gm_piece',0,'animation_blocks_input')
        for _ in range(6):c+=self.call('game/animate_tick')
        c+=self.score(A,'gm_state',1,'animation_unlocks')+self.call('system/tick')+self.score(A,'gm_btime',12000,'black_clock_paused')+self.score(A,'gm_wtime',11999,'white_clock_ticks')
        c+=self.click(-1,0)+self.score(A,'gm_moves',1,'occupied_cell_rejected')
        self.case('move_clock',c)
        c=self.setup()+[f'scoreboard players set {A} gm_confirm 1']+self.click(1,0)+self.score(A,'gm_sel',0,'confirm_preselect')+self.score(A,'gm_moves',0,'confirm_no_first_stone')
        c+=self.click(1,1)+self.score(A,'gm_sel',1,'confirm_transfers')+self.click(1,1)+self.score(square(1),'gm_piece',1,'confirm_second_click_places')
        self.case('confirm',c)
        c=self.setup()+self.move(1,0)+self.actor(1)+self.call('game/offer_undo')+self.call('game/accept_undo')+self.score(square(0),'gm_piece',1,'own_undo_not_accepted')
        c+=self.actor(-1)+self.call('game/accept_undo')+self.score(square(0),'gm_piece',0,'undo_restores_empty')+self.score(A,'gm_turn',1,'undo_restores_turn')+self.score(A,'gm_moves',0,'undo_restores_move_count')
        c+=self.score(A,'gm_state',2,'undo_animates')
        for _ in range(6):c+=self.call('game/animate_tick')
        c+=self.score(A,'gm_state',1,'undo_unlocks')+self.score(A,'gm_btime',12000,'undo_restores_clock')
        self.case('undo',c)
        c=self.setup()+[f'scoreboard players set {A} gm_bot -1']+self.move(1,0)+self.move(-1,1)+self.actor(1)+self.call('game/offer_undo')
        c+=self.score(square(0),'gm_piece',0,'ai_undo_human_stone')+self.score(square(1),'gm_piece',0,'ai_undo_reply')+self.score(A,'gm_turn',1,'ai_undo_human_turn')
        self.case('ai_undo',c)
        c=self.setup()+self.actor(1)+self.call('game/offer_draw')+self.call('game/accept_draw')+self.score(A,'gm_state',1,'own_draw_not_accepted')
        c+=self.actor(-1)+self.call('game/accept_draw')+self.score(A,'gm_result',3,'draw_result')+self.score(A,'gm_reason',8,'draw_reason')+self.score(A,'gm_state',4,'draw_finishes')
        self.case('draw',c)
        c=self.setup()+self.move(1,0)+self.actor(1)+self.call('game/resign')+self.score(A,'gm_result',2,'black_resigns')+self.call('game/cleanup')
        c+=self.score(A,'ct_state',0,'cleanup_lobby')+self.score(square(0),'gm_piece',1,'cleanup_keeps_board')+self.check(f'data entity {A} data.gomoku{{review:1b}}','cleanup_review')
        c+=self.call('game/preview')+self.score(square(0),'gm_piece',1,'review_preserves_board')
        self.case('review',c)
        c=self.setup()+[f'scoreboard players set {A} gm_btime 1']+self.call('clock/tick')+self.score(A,'gm_result',2,'black_timeout_white_wins')+self.score(A,'gm_reason',6,'timeout_reason')
        self.case('timeout',c)
        c=self.setup()+[f'scoreboard players set {A} gm_time 0']+self.call('clock/tick')+self.score(A,'gm_btime',12000,'unlimited_clock')
        self.case('unlimited',c)
        c=self.setup()+self.setup(table=202,reset=False)+self.move(1,0)+self.score(square(0,202),'gm_piece',0,'other_board_untouched')+self.score(B,'gm_turn',1,'other_turn_untouched')
        c+=self.call('game/remove')+self.count('@e[tag=gm.square,scores={ct_id=101}]',0,'remove_own_markers')+self.count('@e[tag=gm.square,scores={ct_id=202}]',225,'remove_keeps_other_markers')
        self.case('isolation',c)
        for field,value,obj,want in [(1,13,'size',13),(1,19,'size',19),(1,14,'size',15),(2,1,'board',1),(2,2,'board',0),(3,1,'palette',0),(6,0,'time',0),(6,30,'time',30),(6,7,'time',10),(7,3,'level',3),(7,4,'level',2),(8,0,'mark',0),(9,0,'coords',0),(10,1,'confirm',1),(10,2,'confirm',0)]:
            key=f'setting_{field}_{value}';self.case(key,self.settings_session()+self.settings_submit(field,value)+self.score(A,'gm_'+obj,want,key))
        self.case('settings_replay',self.settings_session()+self.settings_submit(7,3)+self.settings_submit(7,1)+self.score(A,'gm_level',3,'settings_nonce_one_use'))
        for name,change in [('table',[f'scoreboard players set {person(1)} ct_id 202']),('epoch',[f'scoreboard players add {A} gm_epoch 1']),('game',[f'scoreboard players set {A} ct_game 12']),('reload',['function gomoku:load'])]:
            self.case('settings_stale_'+name,self.settings_session()+change+self.settings_submit(7,1)+self.score(A,'gm_level',2,'settings_stale_'+name))
        for size,row,col in [(13,1,1),(13,13,13),(15,1,10),(15,10,1),(19,19,19)]:
            key=f'coordinate_{size}_{row}_{col}'
            self.case(key,self.setup(size=size)+self.coordinate(row,col)+self.score(square((row-1)*19+col-1),'gm_piece',1,key)+self.score(person(1),'gm_coordnonce',0,key+'_consumed'))
        self.case('coordinate_outside',self.setup(size=13)+self.coordinate(19,19)+self.score(A,'gm_moves',0,'coordinate_outside_rejected'))
        c=self.setup()+self.move(1,0)+self.call('system/reload')+self.score(square(0),'gm_piece',1,'reload_keeps_board')+self.score(A,'gm_turn',-1,'reload_keeps_turn')+self.score(A,'gm_wtime',12000,'reload_keeps_clock')
        self.case('reload',c)
        self.file('dialogs',(PACK/'tools/test_gomoku_dialogs.mcfunction').read_text(encoding='utf-8'))
        self.case('dialogs',['function gomoku_game_test:dialogs','say GOMOKU_GAME_DIALOGS_DONE'])
        self.file('finish',['function gomoku_game_test:reset','say GOMOKU_GAME_FINISHED'])
        self.file('bootstrap',['forceload add -16 -16 63 31','scoreboard objectives add gg dummy','function gomoku:load','schedule function gomoku_game_test:case/'+self.cases[0]+' 40t'])
        for i,name in enumerate(self.cases):self.files['case/'+name]+='schedule function gomoku_game_test:'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 3t\n'


def run(suite, prefix='fimel-gomoku-game-', setup_ticks=240, manual_tick=False, fixture_hook=None):
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
    for path in (target/'data/gomoku/function').rglob('*.mcfunction'):
        body=path.read_text(encoding='utf-8')
        lines=[]
        for line in body.splitlines():
            if not any(token in line for token in ['tellraw ', 'dialog ', 'title ', 'input/give', 'input/clear', 'clear @s', 'give @s', 'item replace']):
                line=line.replace('@a[tag=gm.audience','@e[tag=gm.audience')
            lines.append(line)
        path.write_text('\n'.join(lines)+'\n',encoding='utf-8')
    # 哨兵位于宏体内；任一Dialog codec或替换模板失败时整段宏不会执行。
    macro_requirements={'ui/actions_show':1,'ui/notice_show':1,'ui/coordinates_show':1,'settings/root_show':3}
    for name in macro_requirements:
        path=target/'data/gomoku/function'/(name+'.mcfunction')
        path.write_text(path.read_text(encoding='utf-8')+'say GOMOKU_DIALOG_MACRO '+name.replace('/','_')+'\n',encoding='utf-8')
    if fixture_hook is not None:
        fixture_hook(target)
    for name,body in suite.files.items():
        dest=target/'data/gomoku_game_test/function'/(name+'.mcfunction');dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(body,encoding='utf-8')
    for name,body in {'test_environment/default.json':{'type':'minecraft:function','setup':'gomoku_game_test:bootstrap'},'test_instance/game.json':{'type':'minecraft:function','environment':'gomoku_game_test:default','function':'minecraft:always_pass','max_ticks':1,'setup_ticks':setup_ticks,'required':True,'structure':'minecraft:empty'}}.items():
        dest=target/'data/gomoku_game_test'/name;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_text(json.dumps(body),encoding='utf-8')
    launch=args.minecraft_root/'versions'/args.version/(args.version+'.json')
    meta=json.loads(launch.read_text(encoding='utf-8-sig'));classpath=[launch.with_suffix('.jar')]
    for lib in meta['libraries']:
        entry=lib.get('downloads',{}).get('artifact',{})
        if entry.get('path'):
            path=args.minecraft_root/'libraries'/entry['path']
            if path.is_file(): classpath.append(path)
    options=['-Xms256M','-Xmx1536M','-Djava.awt.headless=true','-Dfile.encoding=UTF-8','--enable-native-access=ALL-UNNAMED','-cp',';'.join(map(str,classpath)),'net.minecraft.gametest.Main','--packs',str(output/'packs'),'--universe',str(output/'universe'),'--tests','gomoku_game_test:*','--report',str(output/'gametest.xml')]
    argfile=output/'java-args.txt';argfile.write_text('\n'.join('"'+v.replace('\\','\\\\').replace('"','\\"')+'"' for v in options),encoding='utf-8')
    print('Gomoku integration GameTest: '+str(output),flush=True);start=time.monotonic()
    proc=subprocess.run([str(args.java),'@'+str(argfile)],cwd=output,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf-8',errors='replace',timeout=max(180,setup_ticks/20+180))
    (output/'game.log').write_text(proc.stdout,encoding='utf-8')
    passed=set(re.findall(r'GOMOKU_GAME_PASS ([a-z0-9_]+)',proc.stdout));failed=sorted(set(re.findall(r'GOMOKU_GAME_FAIL ([a-z0-9_]+)',proc.stdout)))
    errors=[line for line in proc.stdout.splitlines() if any(s in line for s in ['[ERROR]','/ERROR]','Failed to load','Failed to parse','Unknown function','Unknown or incomplete command',"Couldn't parse",'Command execution stopped'])]
    macro_counts=Counter(re.findall(r'GOMOKU_DIALOG_MACRO ([a-z_]+)',proc.stdout))
    macro_missing=[name for name,count in macro_requirements.items() if macro_counts[name.replace('/','_')]<count]
    result={'exit_code':proc.returncode,'seconds':round(time.monotonic()-start,1),'assertions':len(suite.expected),'passed':len(passed),'failed':failed,'missing':sorted(set(suite.expected)-passed),'errors':errors,'finished':'GOMOKU_GAME_FINISHED' in proc.stdout,'dialogs':'GOMOKU_DIALOGS_END' in proc.stdout,'dialog_macros_missing':macro_missing,'output':str(output)}
    (output/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8');print(json.dumps(result,ensure_ascii=False,indent=2),flush=True)
    return int(bool(proc.returncode or failed or result['missing'] or errors or macro_missing or not result['finished'] or not result['dialogs']))


if __name__=='__main__':
    suite=Suite();suite.build();raise SystemExit(run(suite))
