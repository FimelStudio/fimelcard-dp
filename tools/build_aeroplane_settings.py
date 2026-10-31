"""飞行棋单页即时设置，五位会话号+两位字段+两位数值。"""
from pathlib import Path
import json
ROOT=Path(__file__).resolve().parents[1]/'data/aeroplane_chess/function'
FIELDS=[
 (1,'takeoff','起飞点数',[(0,'6点'),(1,'5～6点'),(2,'任意点数')]),
 (2,'extra','六点追加投骰',[(0,'关闭'),(1,'开启')]),
 (3,'triple','连续三个六',[(0,'无处罚'),(1,'第三次失效并结束回合')]),
 (4,'jump','同色跳格',[(0,'关闭'),(1,'开启')]),
 (5,'fly','航线飞跃',[(0,'关闭'),(1,'开启')]),
 (6,'finish','终点超出',[(0,'反弹'),(1,'无法移动')]),
 (7,'palette','棋盘配色',[(0,'经典')]),
 (8,'orient','棋盘方向',[(0,'红方南侧'),(1,'红方西侧')]),
 (9,'first','首位行动',[(0,'随机'),(1,'红'),(2,'蓝'),(3,'绿'),(4,'黄')]),
 (10,'speed','动画速度',[(0,'标准'),(1,'快速')]),
 (11,'hints','可移动飞机提示',[(0,'关闭'),(1,'开启')]),
 (12,'fill','电脑补位',[(2,'关闭'),(0,'单人补一位'),(1,'补满四方')]),
 (13,'ranking','结束方式',[(0,'首名产生即结束'),(1,'继续排名')]),
 (14,'assign','玩家颜色',[(0,'按座位选色'),(1,'随机分配')]),
]

def build(root=ROOT):
 def put(name,lines):
  p=root/(name+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True)
  p.write_text(('\n'.join(lines) if isinstance(lines,list) else lines).strip()+'\n',encoding='utf-8')
 def js(v):return json.dumps(v,ensure_ascii=False,separators=(',',':'))
 put('settings/open','''
execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 15 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #setting_table ac_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,limit=1] ct_id = #setting_table ac_ctx run return 0
function aeroplane_chess:settings/begin
function aeroplane_chess:settings/root
''')
 put('settings/begin','''
execute if score #setting_serial ac_ctx matches 99999.. run scoreboard players add #ui_load ac_ctx 1
execute unless score #setting_serial ac_ctx matches 9999..99998 run scoreboard players set #setting_serial ac_ctx 9999
scoreboard players add #setting_serial ac_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ac_setnonce = #setting_serial ac_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ac_nonce = #ui_load ac_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ac_set_table = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ac_setepoch = @s ac_epoch
scoreboard players set @a[tag=ct.settings_actor,limit=1] ac_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] ac_settings
scoreboard players set #setting_scale ac_ctx 10000
scoreboard players operation #setting_base ac_ctx = #setting_serial ac_ctx
scoreboard players operation #setting_base ac_ctx *= #setting_scale ac_ctx
execute store result storage aeroplane_chess:settings close int 1 run scoreboard players get #setting_base ac_ctx
'''+ '\n'.join(f'execute store result storage aeroplane_chess:settings {key} int 1 run scoreboard players get @s ac_{key}' for _,key,_,_ in FIELDS))
 lines=[]
 for field,key,label,choices in FIELDS:
  if key=='palette': continue
  lines.append(f'data modify storage aeroplane_chess:settings {key}_row set value '+js({'text':label+'\n','color':'white','extra':[]}))
  for value,label in choices:lines.append('function aeroplane_chess:settings/choice '+js({'key':key,'value':value,'code':field*100+value,'label':label}))
 lines.append('function aeroplane_chess:settings/root_show with storage aeroplane_chess:settings')
 put('settings/root',lines)
 put('settings/choice','''
$execute store result score #setting_current ac_ctx run data get storage aeroplane_chess:settings $(key)
$data modify storage aeroplane_chess:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #setting_code ac_ctx $(code)
scoreboard players operation #setting_code ac_ctx += #setting_base ac_ctx
execute store result storage aeroplane_chess:settings code int 1 run scoreboard players get #setting_code ac_ctx
$execute unless score #setting_current ac_ctx matches $(value) run function aeroplane_chess:settings/command with storage aeroplane_chess:settings
$execute if score #setting_current ac_ctx matches $(value) run data modify storage aeroplane_chess:settings option.color set value "gold"
$execute if score #setting_current ac_ctx matches $(value) run data modify storage aeroplane_chess:settings option.bold set value true
$data modify storage aeroplane_chess:settings $(key)_row.extra append from storage aeroplane_chess:settings option
''')
 put('settings/command','$data modify storage aeroplane_chess:settings option.click_event set value {action:"run_command",command:"trigger ac_settings set $(code)"}')
 dialog={'type':'minecraft:notice','title':{'text':'飞行棋 · 游戏设置','color':'gold'},'body':[{'type':'minecraft:plain_message','width':460,'contents':{'text':'【牌桌皮肤 · 点击选择】','color':'aqua','underlined':True,'click_event':{'action':'run_command','command':'trigger ct_skin_pick set 4'}}}]+[{'type':'minecraft:plain_message','width':460,'contents':'__'+key+'__'} for _,key,_,_ in FIELDS if key!='palette'],
 'action':{'label':{'text':'完成'},'width':140,'action':{'type':'minecraft:run_command','command':'trigger ac_settings set $(close)'}},'pause':False,'can_close_with_escape':True,'after_action':'none'}
 body=js(dialog)
 for _,key,_,_ in FIELDS:body=body.replace('"__'+key+'__"','$('+key+'_row)')
 put('settings/root_show','$dialog show @a[tag=ct.settings_actor,limit=1] '+body)
 put('settings/invalid','''
tellraw @s {text:"[飞行棋] 设置窗口已过期，请重新打开。",color:"yellow"}
tag @e[tag=ac.setting_table] remove ac.setting_table
''')
 lines='''
scoreboard players operation #setting_input ac_ctx = @s ac_settings
scoreboard players reset @s ac_settings
execute unless entity @s[tag=ct.player] run return run function aeroplane_chess:settings/invalid
execute unless score @s ac_nonce = #ui_load ac_ctx run return run function aeroplane_chess:settings/invalid
execute unless score @s ct_id = @s ac_set_table run return run function aeroplane_chess:settings/invalid
execute unless score #setting_input ac_ctx matches 100000000..999991401 run return run function aeroplane_chess:settings/invalid
scoreboard players set #setting_scale ac_ctx 10000
scoreboard players operation #setting_nonce ac_ctx = #setting_input ac_ctx
scoreboard players operation #setting_nonce ac_ctx /= #setting_scale ac_ctx
execute unless score #setting_nonce ac_ctx = @s ac_setnonce run return run function aeroplane_chess:settings/invalid
scoreboard players operation #setting_field ac_ctx = #setting_input ac_ctx
scoreboard players operation #setting_field ac_ctx %= #setting_scale ac_ctx
scoreboard players operation #setting_field ac_ctx /= #hundred ac_ctx
scoreboard players operation #setting_value ac_ctx = #setting_input ac_ctx
scoreboard players operation #setting_value ac_ctx %= #hundred ac_ctx
scoreboard players operation #setting_table ac_ctx = @s ac_set_table
scoreboard players operation #setting_epoch ac_ctx = @s ac_setepoch
tag @e[tag=ac.setting_table] remove ac.setting_table
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=15,ct_state=0}] if score @s ct_id = #setting_table ac_ctx if score @s ac_epoch = #setting_epoch ac_ctx run tag @s add ac.setting_table
execute unless entity @e[tag=ac.setting_table,limit=1] run return run function aeroplane_chess:settings/invalid
execute unless score #setting_field ac_ctx matches 0..14 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 0 unless score #setting_value ac_ctx matches 0 run return run function aeroplane_chess:settings/invalid
'''.strip().splitlines()
 for field,key,_,choices in FIELDS:lines.append(f'execute if score #setting_field ac_ctx matches {field} unless score #setting_value ac_ctx matches {min(v for v,_ in choices)}..{max(v for v,_ in choices)} run return run function aeroplane_chess:settings/invalid')
 lines+=['scoreboard players set @s ac_setnonce 0','execute if score #setting_field ac_ctx matches 0 run return run function aeroplane_chess:settings/close']
 for field,key,_,_ in FIELDS:lines.append(f'execute if score #setting_field ac_ctx matches {field} run scoreboard players operation @e[tag=ac.setting_table,limit=1] ac_{key} = #setting_value ac_ctx')
 lines+=['tag @a[tag=ct.settings_actor] remove ct.settings_actor','tag @s add ct.settings_actor',
          'execute if score #setting_field ac_ctx matches 7..8 as @e[tag=ac.setting_table,limit=1] at @s run function aeroplane_chess:game/preview',
          'execute as @e[tag=ac.setting_table,limit=1] at @s run function aeroplane_chess:settings/open',
          'tag @a[tag=ct.settings_actor] remove ct.settings_actor','tag @e[tag=ac.setting_table] remove ac.setting_table']
 put('settings/save',lines)
 put('settings/clear_session',['scoreboard players reset @s ac_'+key for key in ['settings','setnonce','nonce','set_table','setepoch']])
 put('settings/close',['function aeroplane_chess:settings/clear_session','dialog clear @s','tag @s remove ct.settings_actor','tag @e[tag=ac.setting_table] remove ac.setting_table'])
 put('settings/invalidate_table','''
scoreboard players operation #setting_table ac_ctx = @s ct_id
execute as @a if score @s ac_set_table = #setting_table ac_ctx run function aeroplane_chess:settings/clear_session
''')

if __name__=='__main__':build()
