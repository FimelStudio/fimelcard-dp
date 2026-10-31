"""Register Avalon as game 16 without replacing other games. Safe to rerun."""
from pathlib import Path
import json,re
P=Path(__file__).resolve().parents[1];C=P/'data/cardtable/function'
def read(n):return (C/(n+'.mcfunction')).read_text(encoding='utf-8')
def write(n,s):(C/(n+'.mcfunction')).write_text(s.rstrip()+'\n',encoding='utf-8')
def insert(n,line,before=None):
 s=read(n)
 if line in s:return
 if before:
  assert before in s,(n,before);s=s.replace(before,line+'\n'+before,1)
 else:s=s.rstrip()+'\n'+line
 write(n,s)
for path in C.rglob('*.mcfunction'):
 s=path.read_text(encoding='utf-8');lines=[]
 for line in s.splitlines():
  if 'avalon' in line:line=line.replace('ct_game matches 14','ct_game matches 16')
  lines.append(line)
 new='\n'.join(lines)+'\n'
 if new!=s:path.write_text(new,encoding='utf-8')
for n,endpoint in [('game/init_selected','game/init_table'),('game/start','game/start'),('game/open_rules','rules/show'),('game/open_settings','settings/open'),('vote/finish','game/end_vote')]:
 ret='return run ' if n in ['game/open_rules','game/open_settings','vote/finish'] else ''
 line=f'execute if score @s ct_game matches 16 run {ret}function avalon:{endpoint}'
 before=None
 if n=='game/start':before='execute unless score @s ct_start matches 1 run return fail'
 if n in ['game/open_rules','game/open_settings']:before=next(l for l in read(n).splitlines() if '当前游戏没有提供' in l)
 insert(n,line,before)
insert('table/remove','execute if score @s ct_state matches 1 if score @s ct_game matches 16 run function avalon:game/abort','execute if score @s ct_skin matches 1..6 unless')
insert('game/remove_offline_player','execute if entity @s[tag=av.player] run function avalon:player/clear','function cardtable:seat/remove_player')
insert('menu/render','execute if score @s ct_game matches 16 run function cardtable:menu/game_name_avalon','execute unless score @s ct_capacity matches 4')
s=read('menu/select_game').replace('#pick_choice ct_ctx matches 14 unless score @s ct_capacity matches 8','#pick_choice ct_ctx matches 16 unless score @s ct_capacity matches 8');write('menu/select_game',s)
line='execute if score #pick_choice ct_ctx matches 16 unless score @s ct_capacity matches 8 run return 0'
if line not in read('menu/select_game'):write('menu/select_game',line+'\n'+read('menu/select_game'))
for capacity in [4,8]:
 n=f'menu/picker/show{capacity}';s=read(n);dialog=json.loads(s[s.index('{'):]);dialog['actions']=[a for a in dialog['actions'] if '阿瓦隆' not in a['label'].get('text','')]
 if capacity==8:dialog['actions'].append({'label':{'text':'阿瓦隆（5–8人）'},'width':150,'action':{'type':'minecraft:run_command','command':'trigger ct_game_pick set $(p16)'}})
 write(n,'$dialog show @a[tag=ct.switch_actor,limit=1] '+json.dumps(dialog,ensure_ascii=False,separators=(',',':')))
# Reserve numeric slots 14 and 15 even when these games are not installed locally.
s=read('menu/picker/open');pattern=r'scoreboard players add #pick_button ct_ctx 1\nexecute store result storage cardtable:picker p(\d+) int 1 run scoreboard players get #pick_button ct_ctx\n?'
s=re.sub(pattern,'',s)
anchor='execute if score @s ct_capacity matches 8 run return'
assert anchor in s
block=''.join(f'scoreboard players add #pick_button ct_ctx 1\nexecute store result storage cardtable:picker p{i} int 1 run scoreboard players get #pick_button ct_ctx\n' for i in range(1,17))
s=s.replace(anchor,block+anchor,1);write('menu/picker/open',s)
write('load',re.sub(r'(#game_count ct_ctx )\d+',r'\g<1>16',read('load')))
for n in ['menu/render','menu/picker/handle']:
 write(n,re.sub(r'(ct_game matches 1\.\.|#pick_choice ct_ctx matches 1\.\.)\d+',r'\g<1>16',read(n)))
for kind in ['load','tick']:
 path=P/f'data/minecraft/tags/function/{kind}.json';v=json.loads(path.read_text(encoding='utf-8'))
 if 'avalon:'+kind not in v['values']:v['values'].append('avalon:'+kind)
 path.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
# Only identifiable active Avalon controllers are migrated in a pack with Gomoku.
if (P/'data/gomoku').exists():
 migration='execute as @e[type=minecraft:marker,tag=ct.controller,tag=av.controller,scores={ct_game=14}] run scoreboard players set @s ct_game 16'
else:
 migration='execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=14}] run scoreboard players set @s ct_game 16'
 insert('menu/picker/handle','execute if score #pick_choice ct_ctx matches 14..15 run return run function cardtable:menu/picker/invalid','scoreboard players operation #pick_table ct_ctx = @s ct_pick_table')
 insert('menu/select_game','execute if score #pick_choice ct_ctx matches 14..15 run return 0','scoreboard players operation @s ct_game = #pick_choice ct_ctx')
 if 'ct_game matches 14 run scoreboard players set @s ct_game 16' not in read('menu/render'):
  write('menu/render','execute if score @s ct_game matches 14 run scoreboard players set @s ct_game 16\n'+read('menu/render'))
if migration not in read('load'):write('load',migration+'\n'+read('load'))
print('Avalon registered as 16; other game namespaces preserved.')
