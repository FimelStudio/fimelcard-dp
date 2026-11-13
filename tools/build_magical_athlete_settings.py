# -*- coding: utf-8 -*-
"""胡闹运动会：文本选项即时设置，绑定座位、桌号、布局和一次性窗口。"""
import json
from build_magical_athlete_game import put
from table_chair_settings import SKIN_ROW, CHAIR_ROW

FIELDS = [(1, 'draft', '角色分队', [(0, '轮流选角'), (1, '随机分队')]),
          (2, 'track', '比赛跑道', [(0, '普通／狂野交替'), (1, '全部普通'), (2, '全部狂野')]),
          (3, 'music', '背景音乐', [(0, '关闭'), (1, '开启')]),
          (4, 'speed', '动画速度', [(0, '标准'), (1, '快速')]),
          (5, 'orient', '棋盘方向', [(0, '纵向'), (1, '横向')])]


def main():
    put('settings/load', ['scoreboard players add #settings_load ma_ctx 1', 'execute as @a run function magical_athlete:settings/clear_session'])
    put('settings/defaults', [f'execute unless score @s ma_{key} matches 0..{max(v for v,_ in values)} run scoreboard players set @s ma_{key} {1 if key == "music" else 0}' for _,key,_,values in FIELDS])
    put('settings/open', '''
execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 23 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #set_table ma_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,tag=ct.player,limit=1] ct_id = #set_table ma_ctx run return 0
function magical_athlete:settings/defaults
function magical_athlete:settings/begin
function magical_athlete:settings/root
''')
    put('settings/begin', '''
execute if score #settings_serial ma_ctx matches 99999.. run scoreboard players add #settings_load ma_ctx 1
execute unless score #settings_serial ma_ctx matches 9999..99998 run scoreboard players set #settings_serial ma_ctx 9999
scoreboard players add #settings_serial ma_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_setnonce = #settings_serial ma_ctx
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_setload = #settings_load ma_ctx
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_settable = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_setepoch = @s ma_epoch
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_setseat = @a[tag=ct.settings_actor,tag=ct.player,limit=1] ct_seat
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_setlayout = @s ct_ch_epoch
scoreboard players set @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_settings 0
scoreboard players enable @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_settings
scoreboard players operation #set_base ma_ctx = #settings_serial ma_ctx
scoreboard players operation #set_base ma_ctx *= #factor ma_ctx
execute store result storage magical_athlete:settings close int 1 run scoreboard players get #set_base ma_ctx
''' + '\n'.join(f'execute store result storage magical_athlete:settings {key} int 1 run scoreboard players get @s ma_{key}' for _,key,_,_ in FIELDS))
    rows=[]
    for field,key,label,values in FIELDS:
        rows += ['data modify storage magical_athlete:settings '+key+'_row set value '+json.dumps({'text':label+'：','color':'gray','extra':[]},ensure_ascii=False,separators=(',',':'))]
        for value,title in values:
            rows += ['function magical_athlete:settings/choice '+json.dumps({'key':key,'value':value,'code':field*100+value,'label':title},ensure_ascii=False,separators=(',',':'))]
    put('settings/root',rows+['function magical_athlete:settings/root_show with storage magical_athlete:settings'])
    put('settings/choice', '''
$execute store result score #set_current ma_ctx run data get storage magical_athlete:settings $(key)
$data modify storage magical_athlete:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #set_code ma_ctx $(code)
scoreboard players operation #set_code ma_ctx += #set_base ma_ctx
execute store result storage magical_athlete:settings code int 1 run scoreboard players get #set_code ma_ctx
$execute unless score #set_current ma_ctx matches $(value) run function magical_athlete:settings/command with storage magical_athlete:settings
$execute if score #set_current ma_ctx matches $(value) run data modify storage magical_athlete:settings option.color set value "gold"
$execute if score #set_current ma_ctx matches $(value) run data modify storage magical_athlete:settings option.bold set value true
$data modify storage magical_athlete:settings $(key)_row.extra append from storage magical_athlete:settings option
''')
    put('settings/command','$data modify storage magical_athlete:settings option.click_event set value {action:"run_command",command:"trigger ma_settings set $(code)"}')
    dialog={'type':'minecraft:notice','title':{'text':'胡闹运动会 · 游戏设置','color':'gold'},'body':[json.loads(SKIN_ROW),json.loads(CHAIR_ROW)]+[{'type':'minecraft:plain_message','width':440,'contents':'__'+key+'__'} for _,key,_,_ in FIELDS]+[{'type':'minecraft:plain_message','width':440,'contents':{'text':'2～6人 · 四场积分赛 · 两人时每队每场派出两位选手。','color':'gray'}}],'action':{'label':{'text':'完成'},'width':140,'action':{'type':'minecraft:run_command','command':'trigger ma_settings set $(close)'}},'pause':False,'can_close_with_escape':True,'after_action':'none'}
    payload=json.dumps(dialog,ensure_ascii=False,separators=(',',':'))
    for _,key,_,_ in FIELDS:payload=payload.replace('"__'+key+'__"','$('+key+'_row)')
    put('settings/root_show','$dialog show @a[tag=ct.settings_actor,tag=ct.player,limit=1] '+payload)
    save='''
scoreboard players operation #set_input ma_ctx = @s ma_settings
scoreboard players reset @s ma_settings
execute unless entity @s[tag=ct.player] run return run function magical_athlete:settings/invalid
execute unless score @s ma_setload = #settings_load ma_ctx run return run function magical_athlete:settings/invalid
execute unless score @s ct_id = @s ma_settable run return run function magical_athlete:settings/invalid
execute unless score @s ct_seat = @s ma_setseat run return run function magical_athlete:settings/invalid
execute unless score #set_input ma_ctx matches 100000000..999990501 run return run function magical_athlete:settings/invalid
scoreboard players operation #set_nonce ma_ctx = #set_input ma_ctx
scoreboard players operation #set_nonce ma_ctx /= #factor ma_ctx
execute unless score #set_nonce ma_ctx = @s ma_setnonce run return run function magical_athlete:settings/invalid
scoreboard players operation #set_field ma_ctx = #set_input ma_ctx
scoreboard players operation #set_field ma_ctx %= #factor ma_ctx
scoreboard players operation #set_field ma_ctx /= #hundred ma_ctx
scoreboard players operation #set_value ma_ctx = #set_input ma_ctx
scoreboard players operation #set_value ma_ctx %= #hundred ma_ctx
scoreboard players operation #set_table ma_ctx = @s ma_settable
scoreboard players operation #set_epoch ma_ctx = @s ma_setepoch
scoreboard players operation #set_layout ma_ctx = @s ma_setlayout
tag @e[tag=ma.setting_table] remove ma.setting_table
execute as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_game=23,ct_state=0}] if score @s ct_id = #set_table ma_ctx if score @s ma_epoch = #set_epoch ma_ctx if score @s ct_ch_epoch = #set_layout ma_ctx run tag @s add ma.setting_table
execute unless entity @e[tag=ma.setting_table,limit=1] run return run function magical_athlete:settings/invalid
execute unless score #set_field ma_ctx matches 0..5 run return run function magical_athlete:settings/invalid
execute if score #set_field ma_ctx matches 0 unless score #set_value ma_ctx matches 0 run return run function magical_athlete:settings/invalid
'''.strip().splitlines()
    for field,key,_,values in FIELDS: save += [f'execute if score #set_field ma_ctx matches {field} unless score #set_value ma_ctx matches 0..{max(v for v,_ in values)} run return run function magical_athlete:settings/invalid']
    save += ['scoreboard players reset @s ma_setnonce','execute if score #set_field ma_ctx matches 0 run return run function magical_athlete:settings/close']
    for field,key,_,_ in FIELDS:save += [f'execute if score #set_field ma_ctx matches {field} run scoreboard players operation @e[tag=ma.setting_table,limit=1] ma_{key} = #set_value ma_ctx']
    save += ['scoreboard players add @e[tag=ma.setting_table,limit=1] ma_epoch 1','execute if score #set_field ma_ctx matches 2 as @e[tag=ma.setting_table,limit=1] at @s run function magical_athlete:game/preview','execute if score #set_field ma_ctx matches 5 as @e[tag=ma.setting_table,limit=1] at @s run function magical_athlete:game/preview','tag @a[tag=ct.settings_actor] remove ct.settings_actor','tag @s add ct.settings_actor','execute as @e[tag=ma.setting_table,limit=1] at @s run function magical_athlete:settings/open','tag @s remove ct.settings_actor','tag @e[tag=ma.setting_table] remove ma.setting_table']
    put('settings/save',save)
    put('settings/clear_session',[f'scoreboard players reset @s ma_{key}' for key in ['settings','setnonce','setload','settable','setepoch','setseat','setlayout']])
    put('settings/close',['function magical_athlete:settings/clear_session','dialog clear @s','tag @s remove ct.settings_actor','tag @e[tag=ma.setting_table] remove ma.setting_table'])
    put('settings/invalid',['function magical_athlete:settings/clear_session','tellraw @s {text:"[胡闹运动会] 设置窗口已过期，请重新打开。",color:"yellow"}','tag @e[tag=ma.setting_table] remove ma.setting_table'])
    put('settings/invalidate_table',['scoreboard players operation #set_table ma_ctx = @s ct_id','execute as @a if score @s ma_settable = #set_table ma_ctx run function magical_athlete:settings/clear_session'])


if __name__=='__main__':main()
