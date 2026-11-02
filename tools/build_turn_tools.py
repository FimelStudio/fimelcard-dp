"""Keep turn-specific tools only while their owner can act; menus stay available."""
from pathlib import Path
P=Path(__file__).resolve().parents[1]
def put(g,n,s):(P/f'data/{g}/function/{n}.mcfunction').write_text(s.strip()+'\n',encoding='utf8')
def build_aeroplane(root=None):
 """飞行棋保留独立资格判定与道具补回；菜单和骰子均幂等。"""
 root=Path(root) if root is not None else P/'data/aeroplane_chess/function'
 def write(name,text):
  target=root/(name+'.mcfunction');target.parent.mkdir(parents=True,exist_ok=True)
  target.write_text(text.strip()+'\n',encoding='utf8')
 write('input/tool_eligibility','''
scoreboard players set #item_allowed ac_ctx 0
scoreboard players operation #item_table ac_ctx = @s ac_table
scoreboard players operation #item_seat ac_ctx = @s ac_color
execute unless entity @s[tag=ac.player,tag=ct.player] run return 0
execute unless score @s ct_id = @s ac_table run return 0
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ac.controller,scores={ct_game=15,ct_state=1}] if score @s ct_id = #item_table ac_ctx run function aeroplane_chess:input/tool_table
''')
 write('input/tool_table','''
# 投骰、选机、飞行和撞机动画都属于当前方的同一个回合。
execute if score @s ac_state matches 1..4 if score @s ac_turn = #item_seat ac_ctx run scoreboard players set #item_allowed ac_ctx 1
execute if score @s ac_state matches 6 if score @s ac_turn = #item_seat ac_ctx run scoreboard players set #item_allowed ac_ctx 1
''')
 write('input/sync_turn_tool','''
# 同步只移除非行动方的骰子，不重发已有骰子或菜单。
function aeroplane_chess:input/tool_eligibility
execute unless score #item_allowed ac_ctx matches 1 run clear @s *[minecraft:custom_data~{aeroplane_chess:{tool:1b,action:1}}]
execute unless score #item_allowed ac_ctx matches 1 run return 0
execute store result storage aeroplane_chess:input table int 1 run scoreboard players get @s ac_table
function aeroplane_chess:input/ensure_turn_tool with storage aeroplane_chess:input
''')
 write('input/ensure_turn_tool','''
$execute store result score #item_count ac_ctx run clear @s *[minecraft:custom_data~{aeroplane_chess:{tool:1b,action:1,table:$(table)}}] 0
$execute if score #item_count ac_ctx matches 0 run function aeroplane_chess:input/place {table:$(table),slot:0,action:1,name:"飞行棋 · 投骰",model:"card:aeroplane_chess/dice"}
''')
 write('input/give','''
# Q 归位、开局、重载和界面推进都复用同一资格判定，不清掉常驻菜单。
execute unless entity @s[tag=ac.player,tag=ct.player] run return 0
execute unless score @s ac_table = @s ct_id run return 0
function aeroplane_chess:input/sync_turn_tool
execute store result storage aeroplane_chess:input table int 1 run scoreboard players get @s ac_table
function aeroplane_chess:input/tools with storage aeroplane_chess:input
''')
 write('input/tools','''
$execute store result score #tools_have ac_ctx run clear @s minecraft:paper[minecraft:custom_data~{aeroplane_chess:{tool:1b,action:0,table:$(table)}}] 0
$execute if score #tools_have ac_ctx matches 0 run function aeroplane_chess:input/place {table:$(table),slot:8,action:0,name:"飞行棋 · 对局菜单",model:"minecraft:book"}
''')
 # 保留远端逐刻丢失恢复。正常持有时只计数，不 clear/give 刷新物品名称。
 path=root/'input/tick.mcfunction'
 if path.exists():
  text=path.read_text(encoding='utf8');line='execute as @a[tag=ac.player] run function aeroplane_chess:input/sync_turn_tool'
  path.write_text(text.replace(line+'\n','').rstrip()+'\n'+line+'\n',encoding='utf8')
 path=root/'ui/refresh.mcfunction'
 if path.exists():
  text=path.read_text(encoding='utf8')
  text=text.replace('execute as @a[tag=ac.audience] run function aeroplane_chess:input/sync_turn_tool\n','')
  line='execute as @a[tag=ac.audience] run function aeroplane_chess:input/give'
  text=text.replace(line+'\n','')
  text=text.replace('function aeroplane_chess:system/context\n','function aeroplane_chess:system/context\n'+line+'\n',1)
  path.write_text(text,encoding='utf8')

def build():
 for g,pre,tool,action,seat in [('guandan','gd','place_tool',0,'gd_seat'),('aeroplane_chess','ac','place',1,'ac_color')]:
  if g=='aeroplane_chess':
   build_aeroplane()
   continue
  root=P/f'data/{g}/function'
  put(g,'input/tool_eligibility',f"""scoreboard players set #item_allowed {pre}_ctx 0
scoreboard players operation #item_table {pre}_ctx = @s {pre}_table
scoreboard players operation #item_seat {pre}_ctx = @s {seat}
execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_id = @s {pre}_table run return 0
execute as @e[type=minecraft:marker,tag={pre}.controller,scores={{ct_state=1}}] if score @s ct_id = #item_table {pre}_ctx run function {g}:input/tool_table""")
  if g=='guandan':
   conditions="""execute if score @s gd_state matches 3 if score @s gd_turn = #item_seat gd_ctx run scoreboard players set #item_allowed gd_ctx 1
execute if score @s gd_state matches 2 if score @s gd_phase matches 1 as @e[type=minecraft:marker,tag=gd.part,scores={gd_tribute=1}] if score @s ct_id = #item_table gd_ctx if score @s gd_seat = #item_seat gd_ctx run scoreboard players set #item_allowed gd_ctx 1
execute if score @s gd_state matches 2 if score @s gd_phase matches 2 as @e[type=minecraft:marker,tag=gd.part,scores={gd_return=1}] if score @s ct_id = #item_table gd_ctx if score @s gd_seat = #item_seat gd_ctx run scoreboard players set #item_allowed gd_ctx 1"""
   spec='slot:0,action:0,name:"掼蛋 · 手牌",model:"card:poker/back"'
  else:
   conditions='execute if score @s ac_state matches 1 if score @s ac_turn = #item_seat ac_ctx run scoreboard players set #item_allowed ac_ctx 1'
   spec='slot:0,action:1,name:"飞行棋 · 投骰",model:"card:aeroplane_chess/dice"'
  put(g,'input/tool_table',conditions)
  put(g,'input/sync_turn_tool',f"""function {g}:input/tool_eligibility
execute if score #item_allowed {pre}_ctx matches 0 run clear @s *[minecraft:custom_data~{{{g}:{{tool:1b,action:{action}}}}}]
execute unless score #item_allowed {pre}_ctx matches 1 run return 0
execute store result storage {g}:input table int 1 run scoreboard players get @s {pre}_table
function {g}:input/ensure_turn_tool with storage {g}:input""")
  put(g,'input/ensure_turn_tool',f"""$execute store result score #item_count {pre}_ctx run clear @s *[minecraft:custom_data~{{{g}:{{tool:1b,action:{action},table:$(table)}}}}] 0
$execute if score #item_count {pre}_ctx matches 0 run function {g}:input/{tool} {{table:$(table),{spec}}}""")
  f=root/'input/give.mcfunction';s=f.read_text(encoding='utf8');line=f'function {g}:input/tool_eligibility';s=s.replace(line+'\n','');s=line+'\n'+s;f.write_text(s,encoding='utf8')
  f=root/('input/give_tools.mcfunction' if g=='guandan' else 'input/tools.mcfunction');s=f.read_text(encoding='utf8');original=f'$function {g}:input/{tool} {{table:$(table),{spec}}}';replacement=f'$execute if score #item_allowed {pre}_ctx matches 1 run function {g}:input/{tool} {{table:$(table),{spec}}}';s=s.replace(original,replacement);f.write_text(s,encoding='utf8')
  for name in ['input/tick','ui/refresh']:
   f=root/(name+'.mcfunction');s=f.read_text(encoding='utf8');tag=f'{pre}.player' if name=='input/tick' else f'{pre}.audience';line=f'execute as @a[tag={tag}] run function {g}:input/sync_turn_tool';s=s.replace(line+'\n','').rstrip()+'\n'+line+'\n';f.write_text(s,encoding='utf8')
if __name__=='__main__':build()
