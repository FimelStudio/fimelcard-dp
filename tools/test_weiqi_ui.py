# -*- coding: utf-8 -*-
"""原版26.2围棋Dialog、设置、窗口失效和对局归属测试；只操作隔离临时世界。"""
from pathlib import Path
import argparse
import json
import re
import shutil
import subprocess
import tempfile
import time
from build_weiqi_settings import FIELDS
from test_weiqi_engine import Suite as EngineSuite

PACK=Path(__file__).resolve().parents[1]
NS='weiqi_ui_test'
TABLE='@e[type=minecraft:marker,tag=gui.table,scores={ct_id=101},limit=1]'
OTHER='@e[type=minecraft:marker,tag=gui.table,scores={ct_id=202},limit=1]'

def person(side=1,table=101):return f'@e[type=minecraft:marker,tag=gui.person,scores={{ct_id={table},go_side={side}}},limit=1]'

class Suite(EngineSuite):
 def check(self,condition,name):
  assert name not in self.expected,name
  self.expected.append(name)
  return [f'execute if {condition} run say WEIQI_UI_PASS {name}',f'execute unless {condition} run say WEIQI_UI_FAIL {name}']
 def call(self,name,table=101):return [f'execute as {TABLE if table==101 else OTHER} at @s run function weiqi:{name}']
 def setup(self,table=101,reset=True,state=1):
  ctrl=TABLE if table==101 else OTHER
  c=[f'function {NS}:reset'] if reset else []
  c += [f'execute positioned {8.0 if table==101 else 40.0} 64.0 8.0 summon minecraft:marker run function {NS}:table {{table:{table}}}',f'scoreboard players set {ctrl} go_state {state}']
  return c
 def open(self,side=1,table=101):return ['scoreboard players set #ui_compiled gui 0',f'execute as {person(side,table)} at @s run function weiqi:ui/open']
 def submit(self,action,side=1,table=101):
  p=person(side,table)
  return [f'scoreboard players operation {p} go_action = {p} go_ui_serial','scoreboard players set #factor gui 10000',f'scoreboard players operation {p} go_action *= #factor gui',f'scoreboard players add {p} go_action {action}',f'execute as {p} at @s run function weiqi:input/submit']
 def settings(self,field,value,side=1,table=101):
  p=person(side,table)
  return [f'scoreboard players operation {p} go_settings = {p} go_setnonce','scoreboard players set #factor gui 10000',f'scoreboard players operation {p} go_settings *= #factor gui',f'scoreboard players add {p} go_settings {field*100+value}',f'execute as {p} at @s run function weiqi:settings/save']
 def settings_open(self,table=101):return [f'scoreboard players set {TABLE if table==101 else OTHER} ct_state 0','tag @e[tag=ct.settings_actor] remove ct.settings_actor',f'tag {person(table=table)} add ct.settings_actor']+self.call('settings/open',table)
 def build(self):
  self.file('reset',['kill @e[tag=gui.fixture]','kill @e[tag=go.visual]','kill @e[tag=go.square]','kill @e[tag=ct.menu]','kill @e[tag=ct.vote]','scoreboard players set #settings_compiled gui 0','scoreboard players set #coord_compiled gui 0','scoreboard players set #rules_compiled gui 0'])
  self.file('table','''
tag @s add gui.fixture
tag @s add gui.table
tag @s add ct.controller
tag @s add go.controller
$scoreboard players set @s ct_id $(table)
scoreboard players set @s ct_game 20
scoreboard players set @s ct_state 1
scoreboard players set @s ct_capacity 4
scoreboard players set @s ct_joined 2
scoreboard players set @s go_state 1
scoreboard players set @s go_epoch 1
scoreboard players set @s go_turn 1
scoreboard players set @s go_moves 0
scoreboard players set @s go_passes 0
scoreboard players set @s go_bcap 2
scoreboard players set @s go_wcap 3
scoreboard players set @s go_size 19
scoreboard players set @s go_board 0
scoreboard players set @s go_orient 0
scoreboard players set @s go_first 1
scoreboard players set @s go_time 10
scoreboard players set @s go_komi 15
scoreboard players set @s go_level 2
scoreboard players set @s go_coords 1
scoreboard players set @s go_mark 1
scoreboard players set @s go_confirm 0
scoreboard players set @s go_estimate 1
scoreboard players set @s go_undo 0
scoreboard players set @s go_bot 0
scoreboard players set @s go_bconfirm 0
scoreboard players set @s go_wconfirm 0
scoreboard players set @s go_autoplay 0
data modify entity @s data.weiqi set value {black_name:{text:"测试黑方"},white_name:{text:"测试白方"},history:[]}
$execute summon minecraft:marker run function weiqi_ui_test:person {table:$(table),side:1,seat:3}
$execute summon minecraft:marker run function weiqi_ui_test:person {table:$(table),side:-1,seat:1}
''')
  self.file('person','''
tag @s add gui.fixture
tag @s add gui.person
tag @s add ct.player
tag @s add go.player
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s go_table $(table)
$scoreboard players set @s go_side $(side)
$scoreboard players set @s ct_seat $(seat)
$scoreboard players set @s go_seat $(seat)
scoreboard players set @s go_view 0
scoreboard players set @s go_revelig 0
''')
  c=self.setup()+self.open()+self.score('#ui_compiled','gui',1,'playing_dialog_compiles')+self.check('data storage weiqi:ui black_name{text:"测试黑方"}','black_name_static')+self.check('data storage weiqi:ui white_name{text:"测试白方"}','white_name_static')+self.check('data storage weiqi:ui {komi_label:"7½"}','komi_readable_half')+self.check('data storage weiqi:ui buttons[{label:{text:"停一手"}}]','own_turn_pass_button')+self.check('data storage weiqi:ui buttons[{label:{text:"查看占地"}}]','estimate_button')
  c+=self.open(-1)+self.score('#ui_compiled','gui',1,'waiting_dialog_compiles')+self.check('data storage weiqi:ui {phase:"等待对手行棋。"}','opponent_waits')
  c+=self.submit(10,-1)+self.score(TABLE,'go_passes',0,'wrong_turn_forged_pass_rejected')
  self.case('playing',c)
  c=self.setup()
  for value,label in [(-40,'-20'),(-15,'-7½'),(-2,'-1'),(-1,'-½'),(0,'0'),(1,'½'),(15,'7½'),(40,'20')]:
   c += [f'data modify storage weiqi:ui komi set value {value}','function weiqi:ui/half {key:"komi"}']+self.check('data storage weiqi:ui {komi_label:'+json.dumps(label,ensure_ascii=False)+'}',f'half_label_{value+40}')
  self.case('half_labels',c)
  for state in (2,3,4):
   c=self.setup(state=state)+self.open()+self.score('#ui_compiled','gui',1,f'state_{state}_codec')
   if state==3:c+=self.check('data storage weiqi:ui buttons[{label:{text:"确认点目"}}]','scoring_confirm_button')+self.check('data storage weiqi:ui buttons[{label:{text:"继续下棋"}}]','scoring_resume_button')
   self.case('state_'+str(state),c)
  c=self.setup()+self.open()+self.submit(30)+self.score('#ui_compiled','gui',1,'resign_confirmation_codec')+self.check('data storage weiqi:ui {phase:"确认认输？"}','resign_requires_confirmation')+self.score(TABLE,'go_state',1,'opening_resign_keeps_game')
  self.case('resign_confirm',c)
  for size in (13,15,19):
   c=self.setup()+[f'scoreboard players set {TABLE} go_size {size}']+self.open()+self.submit(50)+self.score('#coord_compiled','gui',size,'coordinates_'+str(size)+'_codec')
   self.case('coordinates_'+str(size),c)
  for size in (13,15,19):
   # 使用真实规则棋盘和动态坐标nonce提交右上角，覆盖1/2位行列的变长编码。
   c=self.setup()+[f'scoreboard players set {TABLE} ct_state 0',f'scoreboard players set {TABLE} go_size {size}']+self.call('game/preview')+[f'scoreboard players set {TABLE} ct_state 1',f'scoreboard players set {TABLE} go_state 1']+self.open()+self.submit(50)
   p=person();sq=(size-1)*19+size-1
   c += [f'scoreboard players operation {p} go_coord = {p} go_coordnonce','scoreboard players set #factor gui 100000',f'scoreboard players operation {p} go_coord *= #factor gui',f'scoreboard players add {p} go_coord {size*1000+size}',f'execute as {p} at @s run function weiqi:input/coordinate_submit']
   c += self.score(f'@e[tag=go.square,scores={{ct_id=101,go_sq={sq}}},limit=1]','go_piece',1,f'coordinates_{size}_real_move')+self.score(TABLE,'go_moves',1,f'coordinates_{size}_increments_move')
   self.case('coordinate_move_'+str(size),c)
  for change,mutate in [('epoch',[f'scoreboard players add {TABLE} go_epoch 1']),('reload',['scoreboard players add #ui_load go_ctx 1']),('table',[f'scoreboard players set {person()} go_table 202']),('game',[f'scoreboard players set {TABLE} ct_game 19']),('inactive',[f'scoreboard players set {TABLE} ct_state 0'])]:
   c=self.setup()+self.open()+mutate+self.submit(30)+self.check('data storage weiqi:ui {phase:"轮到你行棋。"}','stale_'+change+'_no_confirmation')+self.score(TABLE,'go_state',1,'stale_'+change+'_no_game_mutation')
   self.case('stale_'+change,c)
  c=self.setup()+self.open()+[f'scoreboard players operation #oldserial gui = {person()} go_ui_serial']+self.open()+[f'scoreboard players operation {person()} go_ui_serial = #oldserial gui']
  # 重开后旧code的nonce仍旧，但服务端只接受最新session。
  c=self.setup()+self.open()+[f'scoreboard players operation #oldcode gui = {person()} go_ui_serial','scoreboard players set #factor gui 10000','scoreboard players operation #oldcode gui *= #factor gui','scoreboard players add #oldcode gui 30']+self.open()+[f'scoreboard players operation {person()} go_action = #oldcode gui',f'execute as {person()} run function weiqi:input/submit']+self.check('data storage weiqi:ui {phase:"轮到你行棋。"}','same_turn_reopened_old_nonce_rejected')
  self.case('stale_serial',c)
  c=self.setup()+[f'scoreboard players set {TABLE} ct_state 0',f'scoreboard players set {TABLE} go_state 5',f'data modify entity {TABLE} data.weiqi.review set value 1b']+self.open()+self.score('#ui_compiled','gui',0,'stranger_cannot_open_review')+[f'scoreboard players set {person()} go_revelig 1',f'scoreboard players set {person()} go_reviewtable 101']+self.open()+self.score('#ui_compiled','gui',1,'eligible_review_dialog_compiles')+self.check('data storage weiqi:ui buttons[{label:{text:"上一手"}}]','review_previous_button')+self.check('data storage weiqi:ui buttons[{label:{text:"自动播放"}}]','review_autoplay_button')
  self.case('review_eligibility',c)
  for _,key,_,choices in FIELDS:
   # root的单页所有选项经真实宏解析；不为同一个页面重复开几百次服务器。
   c=self.setup()+self.settings_open()+self.score('#settings_compiled','gui',1,'setting_'+key+'_codec')
   if key not in ('size','board','orient','coords','mark'):
    value=choices[-1][0];field=next(f for f,k,_,_ in FIELDS if k==key)
    c+=self.settings(field,value)+self.score(TABLE,'go_'+key,value,'setting_'+key+'_instant')
   self.case('setting_'+key,c)
  for change,mutate in [('epoch',[f'scoreboard players add {TABLE} go_epoch 1']),('reload',['scoreboard players add #ui_load go_ctx 1']),('table',[f'scoreboard players set {person()} ct_id 202']),('game',[f'scoreboard players set {TABLE} ct_game 19']),('started',[f'scoreboard players set {TABLE} ct_state 1'])]:
   c=self.setup()+self.settings_open()+mutate+self.settings(5,30)+self.score(TABLE,'go_time',10,'stale_settings_'+change+'_rejected')
   self.case('stale_settings_'+change,c)
  for field,value in [(0,1),(1,14),(5,7),(6,12),(7,0),(11,2),(12,0)]:
   c=self.setup()+self.settings_open()+self.settings(field,value)+self.score(TABLE,'go_time',10,f'invalid_setting_{field}_{value}_keeps_time')+self.score(TABLE,'go_size',19,f'invalid_setting_{field}_{value}_keeps_size')
   self.case(f'invalid_setting_{field}_{value}',c)
  c=self.setup()+self.setup(table=202,reset=False)+self.settings_open()+self.settings_open(202)+self.settings(5,30)+self.score(TABLE,'go_time',30,'settings_own_table')+self.score(OTHER,'go_time',10,'settings_other_table_preserved')
  self.case('settings_two_tables',c)
  c=self.setup()+[f'tag {person()} add ct.rules_actor']+self.call('rules/show')+[f'execute as {person()} run function weiqi:rules/player']+self.score('#rules_compiled','gui',2,'both_rules_entry_codecs')
  self.case('rules',c)
  self.file('bootstrap',['forceload add 0 0 47 15','scoreboard objectives add gui dummy','schedule function '+NS+':case/'+self.cases[0]+' 5t'])
  self.file('finish',['function '+NS+':reset','say WEIQI_UI_FINISHED'])
  for i,name in enumerate(self.cases):self.files['case/'+name]+='schedule function '+NS+':'+('case/'+self.cases[i+1] if i+1<len(self.cases) else 'finish')+' 1t\n'

def prepare_target(target):
 root=target/'data/weiqi/function'
 for path in root.rglob('*.mcfunction'):
  out=[]
  for line in path.read_text(encoding='utf8').splitlines():
   if not any(word in line for word in ('tellraw ','dialog ','title ','playsound ','clear @s','give @s','item replace ')):
    line=line.replace('@a[','@e[')
   out.append(line)
  path.write_text('\n'.join(out)+'\n',encoding='utf8')
 for name,command in [('ui/show','scoreboard players set #ui_compiled gui 1'),('settings/root_show','scoreboard players add #settings_compiled gui 1'),('rules/show','scoreboard players add #rules_compiled gui 1'),('rules/player','scoreboard players add #rules_compiled gui 1')]+[(f'ui/coordinates_{n}',f'scoreboard players set #coord_compiled gui {n}') for n in (13,15,19)]:
  path=root/(name+'.mcfunction');path.write_text(path.read_text(encoding='utf8')+command+'\n',encoding='utf8')

def run(suite):
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--java',type=Path,default=Path('C:/Temp/fimel-uno-java25/jdk-25.0.5+8-jre/bin/java.exe'))
 parser.add_argument('--minecraft-root',type=Path,default=Path('D:/PCL2/MinecraftPcl'))
 parser.add_argument('--version',default='26.2-Fabric_0.19.3')
 parser.add_argument('--case')
 args=parser.parse_args()
 if args.case:
  if args.case not in suite.cases:raise SystemExit('Unknown case: '+args.case)
  suite.cases=[args.case]
  suite.files['bootstrap']=re.sub(r'schedule function '+NS+r':case/[a-z0-9_]+ 5t',f'schedule function {NS}:case/{args.case} 5t',suite.files['bootstrap'])
  suite.files['case/'+args.case]=re.sub(r'schedule function '+NS+r':[a-z0-9_/]+ 1t',f'schedule function {NS}:finish 1t',suite.files['case/'+args.case])
  suite.expected=re.findall(r'WEIQI_UI_PASS ([a-z0-9_]+)',suite.files['case/'+args.case])
 output=Path(tempfile.mkdtemp(prefix='fimel-weiqi-ui-'));target=output/'packs/fimel_cards'
 shutil.copytree(PACK/'data',target/'data');shutil.copy2(PACK/'pack.mcmeta',target/'pack.mcmeta')
 (target/'data/minecraft/tags/function/tick.json').write_text('{"values":[]}',encoding='utf8')
 prepare_target(target)
 for name,body in suite.files.items():
  path=target/'data'/NS/'function'/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True);path.write_text(body,encoding='utf8')
 for name,body in {'test_environment/default.json':{'type':'minecraft:function','setup':NS+':bootstrap'},'test_instance/game.json':{'type':'minecraft:function','environment':NS+':default','function':'minecraft:always_pass','max_ticks':1,'required':True,'setup_ticks':len(suite.cases)+100,'structure':'minecraft:empty'}}.items():
  path=target/'data'/NS/name;path.parent.mkdir(parents=True,exist_ok=True);path.write_text(json.dumps(body),encoding='utf8')
 launch=args.minecraft_root/'versions'/args.version/(args.version+'.json');meta=json.loads(launch.read_text(encoding='utf-8-sig'));cp=[launch.with_suffix('.jar')]
 for lib in meta['libraries']:
  entry=lib.get('downloads',{}).get('artifact',{});path=args.minecraft_root/'libraries'/entry.get('path','')
  if entry.get('path') and path.is_file():cp.append(path)
 options=['-Xms256M','-Xmx1536M','-Djava.awt.headless=true','-Dfile.encoding=UTF-8','--enable-native-access=ALL-UNNAMED','-cp',';'.join(map(str,cp)),'net.minecraft.gametest.Main','--packs',str(output/'packs'),'--universe',str(output/'universe'),'--tests',NS+':*','--report',str(output/'gametest.xml')]
 argfile=output/'java-args.txt';argfile.write_text('\n'.join('"'+v.replace('\\','\\\\').replace('"','\\"')+'"' for v in options),encoding='utf8')
 print('Weiqi UI GameTest: '+str(output),flush=True);start=time.monotonic()
 proc=subprocess.run([str(args.java),'@'+str(argfile)],cwd=output,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,encoding='utf8',errors='replace',timeout=480)
 (output/'game.log').write_text(proc.stdout,encoding='utf8')
 passed=set(re.findall(r'WEIQI_UI_PASS ([a-z0-9_]+)',proc.stdout));failed=sorted(set(re.findall(r'WEIQI_UI_FAIL ([a-z0-9_]+)',proc.stdout)))
 errors=[line for line in proc.stdout.splitlines() if any(s in line for s in ('[ERROR]','/ERROR]','Failed to load','Failed to parse','Unknown function','Unknown or incomplete command',"Couldn't parse",'Command execution stopped'))]
 result={'exit_code':proc.returncode,'seconds':round(time.monotonic()-start,1),'assertions':len(suite.expected),'passed':len(passed),'failed':failed,'missing':sorted(set(suite.expected)-passed),'errors':errors,'finished':'WEIQI_UI_FINISHED' in proc.stdout,'output':str(output)}
 (output/'result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf8');print(json.dumps(result,ensure_ascii=False,indent=2),flush=True)
 return int(bool(proc.returncode or failed or result['missing'] or errors or not result['finished']))

if __name__=='__main__':
 suite=Suite();suite.build();raise SystemExit(run(suite))
