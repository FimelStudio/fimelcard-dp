# -*- coding: utf-8 -*-
"""围棋单页即时设置；会话绑定玩家、桌号、游戏、epoch与reload代次。"""
from pathlib import Path
import json

PACK=Path(__file__).resolve().parents[1]
ROOT=PACK/'data/weiqi/function'
FIELDS=[
 (1,'size','棋盘大小',[(13,'13×13'),(15,'15×15'),(19,'19×19')]),
 (2,'board','棋盘配色',[(0,'经典'),(1,'木色')]),
 (3,'orient','棋盘方向',[(0,'黑方南侧'),(1,'黑方西侧')]),
 (4,'first','黑白方分配',[(1,'按座位自行选边'),(0,'随机分配')]),
 (5,'time','每人计时',[(0,'无限制')]+[(n,f'{n}分钟') for n in range(5,31,5)]),
 (6,'komi','白方贴目',[(0,'不贴目'),(11,'5½目'),(13,'6½目'),(15,'7½目'),(17,'8½目')]),
 (7,'level','单人人机难度',[(1,'简单'),(2,'普通'),(3,'困难')]),
 (8,'coords','棋盘坐标',[(0,'隐藏'),(1,'显示')]),
 (9,'mark','最后一手标记',[(0,'关闭'),(1,'开启')]),
 (10,'confirm','右键落子确认',[(0,'一次落子'),(1,'同点两次确认')]),
 (11,'estimate','查看占地',[(0,'关闭'),(1,'允许')]),
]
OBJECTIVES={name:'dummy' for name in ['go_set_table','go_setnonce','go_setepoch','go_nonce']}
OBJECTIVES['go_settings']='trigger'

def js(value):return json.dumps(value,ensure_ascii=False,separators=(',',':'))

def build(root=ROOT):
 def put(name,text):
  path=root/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True);path.write_text(text.strip()+'\n',encoding='utf8')
 put('settings/open','''
execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 20 run return 0
execute unless score @s ct_state matches 0 run return 0
execute if score @s go_state matches 5 run tellraw @a[tag=ct.settings_actor,limit=1] {text:"[围棋] 请先退出复盘，再修改游戏设置。",color:"yellow"}
execute if score @s go_state matches 5 run return 0
scoreboard players operation #ui_setting_table go_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,limit=1] ct_id = #ui_setting_table go_ctx run return 0
function weiqi:settings/begin
function weiqi:settings/root
''')
 put('settings/begin','''
# 五位nonce×10000加字段和值，最大999991180，低于有符号整数上限。
execute if score #setting_serial go_ctx matches 99999.. run scoreboard players add #ui_load go_ctx 1
execute unless score #setting_serial go_ctx matches 9999..99998 run scoreboard players set #setting_serial go_ctx 9999
scoreboard players add #setting_serial go_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] go_setnonce = #setting_serial go_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] go_nonce = #ui_load go_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] go_set_table = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,limit=1] go_setepoch = @s go_epoch
scoreboard players set @a[tag=ct.settings_actor,limit=1] go_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] go_settings
function weiqi:settings/prepare
''')
 prepare=['scoreboard players set #ui_10000 go_ctx 10000','scoreboard players operation #ui_setting_base go_ctx = #setting_serial go_ctx','scoreboard players operation #ui_setting_base go_ctx *= #ui_10000 go_ctx','execute store result storage weiqi:settings close int 1 run scoreboard players get #ui_setting_base go_ctx']
 prepare += [f'execute store result storage weiqi:settings {key} int 1 run scoreboard players get @s go_{key}' for _,key,_,_ in FIELDS]
 put('settings/prepare','\n'.join(prepare))
 rows=[]
 for field,key,label,choices in FIELDS:
  rows.append(f'data modify storage weiqi:settings {key}_row set value '+js({'text':label+'\n','color':'white','extra':[]}))
  for value,text in choices:rows.append('function weiqi:settings/choice '+js({'key':key,'row':key+'_row','value':value,'code':field*100+value,'label':text}))
 rows+=['function weiqi:settings/root_show with storage weiqi:settings'];put('settings/root','\n'.join(rows))
 put('settings/choice','''
$execute store result score #ui_setting_current go_ctx run data get storage weiqi:settings $(key)
$data modify storage weiqi:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #ui_setting_code go_ctx $(code)
scoreboard players operation #ui_setting_code go_ctx += #ui_setting_base go_ctx
execute store result storage weiqi:settings code int 1 run scoreboard players get #ui_setting_code go_ctx
$execute unless score #ui_setting_current go_ctx matches $(value) run function weiqi:settings/command with storage weiqi:settings
$execute if score #ui_setting_current go_ctx matches $(value) run data modify storage weiqi:settings option.color set value "gold"
$execute if score #ui_setting_current go_ctx matches $(value) run data modify storage weiqi:settings option.bold set value true
$data modify storage weiqi:settings $(row).extra append from storage weiqi:settings option
''')
 put('settings/command','$data modify storage weiqi:settings option.click_event set value {action:"run_command",command:"trigger go_settings set $(code)"}')
 dialog={'type':'minecraft:notice','title':{'text':'围棋 · 游戏设置','color':'gold'},'body':[{'type':'minecraft:plain_message','width':460,'contents':{'text':'【牌桌皮肤 · 点击选择】','color':'aqua','underlined':True,'click_event':{'action':'run_command','command':'trigger ct_skin_pick set 4'}}}]+[{'type':'minecraft:plain_message','width':460,'contents':'__'+key+'_row__'} for _,key,_,_ in FIELDS],'action':{'label':{'text':'完成'},'width':140,'action':{'type':'minecraft:run_command','command':'trigger go_settings set $(close)'}},'pause':False,'can_close_with_escape':True,'after_action':'none'}
 text=js(dialog)
 for _,key,_,_ in FIELDS:text=text.replace('"__'+key+'_row__"','$('+key+'_row)')
 put('settings/root_show','$dialog show @a[tag=ct.settings_actor,limit=1] '+text)
 put('settings/invalid','''
tellraw @s {text:"[围棋] 设置窗口已过期或输入无效，请重新打开本桌的游戏设置。",color:"yellow"}
tag @e[tag=go.setting_table] remove go.setting_table
''')
 save='''
scoreboard players operation #ui_setting_input go_ctx = @s go_settings
scoreboard players reset @s go_settings
execute unless entity @s[tag=ct.player] run return run function weiqi:settings/invalid
execute unless score @s go_nonce = #ui_load go_ctx run return run function weiqi:settings/invalid
execute unless score @s ct_id = @s go_set_table run return run function weiqi:settings/invalid
execute unless score #ui_setting_input go_ctx matches 100000000..999999999 run return run function weiqi:settings/invalid
scoreboard players set #ui_100 go_ctx 100
scoreboard players set #ui_10000 go_ctx 10000
scoreboard players operation #ui_setting_nonce go_ctx = #ui_setting_input go_ctx
scoreboard players operation #ui_setting_nonce go_ctx /= #ui_10000 go_ctx
execute unless score #ui_setting_nonce go_ctx = @s go_setnonce run return run function weiqi:settings/invalid
scoreboard players operation #ui_setting_field go_ctx = #ui_setting_input go_ctx
scoreboard players operation #ui_setting_field go_ctx /= #ui_100 go_ctx
scoreboard players operation #ui_setting_field go_ctx %= #ui_100 go_ctx
scoreboard players operation #ui_setting_value go_ctx = #ui_setting_input go_ctx
scoreboard players operation #ui_setting_value go_ctx %= #ui_100 go_ctx
tag @e[tag=go.setting_table] remove go.setting_table
scoreboard players operation #ui_setting_table go_ctx = @s go_set_table
scoreboard players operation #ui_setting_epoch go_ctx = @s go_setepoch
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=20,ct_state=0}] if score @s ct_id = #ui_setting_table go_ctx if score @s go_epoch = #ui_setting_epoch go_ctx unless score @s go_state matches 5 run tag @s add go.setting_table
execute unless entity @e[tag=go.setting_table,limit=1] run return run function weiqi:settings/invalid
execute unless score #ui_setting_field go_ctx matches 0..11 run return run function weiqi:settings/invalid
execute if score #ui_setting_field go_ctx matches 0 unless score #ui_setting_value go_ctx matches 0 run return run function weiqi:settings/invalid
'''.strip().splitlines()
 for field,key,label,choices in FIELDS:save.append(f'execute if score #ui_setting_field go_ctx matches {field} '+' '.join(f'unless score #ui_setting_value go_ctx matches {value}' for value,_ in choices)+' run return run function weiqi:settings/invalid')
 save+=['scoreboard players set @s go_setnonce 0','execute if score #ui_setting_field go_ctx matches 0 run return run function weiqi:settings/close']
 for field,key,_,_ in FIELDS:save.append(f'execute if score #ui_setting_field go_ctx matches {field} run scoreboard players operation @e[tag=go.setting_table,limit=1] go_{key} = #ui_setting_value go_ctx')
 save+=['tag @a[tag=ct.settings_actor] remove ct.settings_actor','tag @s add ct.settings_actor','execute if score #ui_setting_field go_ctx matches 1 as @e[tag=go.setting_table,limit=1] run data remove entity @s data.weiqi.review','execute if score #ui_setting_field go_ctx matches 1..3 as @e[tag=go.setting_table,limit=1] at @s run function weiqi:game/preview','execute if score #ui_setting_field go_ctx matches 8..9 as @e[tag=go.setting_table,limit=1] at @s run function weiqi:game/preview','execute as @e[tag=go.setting_table,limit=1] at @s run function weiqi:settings/open','tag @a[tag=ct.settings_actor] remove ct.settings_actor','tag @e[tag=go.setting_table] remove go.setting_table']
 put('settings/save','\n'.join(save))
 put('settings/close','function weiqi:settings/clear_session\ndialog clear @s\ntag @s remove ct.settings_actor\ntag @e[tag=go.setting_table] remove go.setting_table')
 put('settings/clear_session','\n'.join('scoreboard players reset @s '+name for name in OBJECTIVES))
 put('settings/invalidate_table','scoreboard players operation #ui_setting_table go_ctx = @s ct_id\nexecute as @a if score @s go_set_table = #ui_setting_table go_ctx run function weiqi:settings/clear_session')

if __name__=='__main__':build();print('围棋单页即时设置已生成')
