"""璀璨宝石单页即时设置；只接受本桌大厅的一次性窗口。"""
import json
from build_splendor_game import put
from table_chair_settings import SKIN_ROW, CHAIR_ROW

FIELDS = [(1, 'first', '行动顺序', [(0, '按座位'), (1, '随机')]),
          (2, 'music', '背景音乐', [(0, '关闭'), (1, '开启')])]


def main():
    put('settings/load', ['scoreboard players add #settings_load sp_ctx 1', 'execute as @a run function splendor:settings/clear_session'])
    put('settings/defaults', ['execute unless score @s sp_first matches 0..1 run scoreboard players set @s sp_first 0', 'execute unless score @s sp_music matches 0..1 run scoreboard players set @s sp_music 1'])
    put('settings/open', '''
execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 22 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #set_table sp_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,tag=ct.player,limit=1] ct_id = #set_table sp_ctx run return 0
function splendor:settings/defaults
function splendor:settings/begin
function splendor:settings/root
''')
    put('settings/begin', '''
execute if score #settings_serial sp_ctx matches 99999.. run scoreboard players add #settings_load sp_ctx 1
execute unless score #settings_serial sp_ctx matches 9999..99998 run scoreboard players set #settings_serial sp_ctx 9999
scoreboard players add #settings_serial sp_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_setnonce = #settings_serial sp_ctx
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_setload = #settings_load sp_ctx
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_settable = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_setepoch = @s sp_epoch
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_setseat = @a[tag=ct.settings_actor,tag=ct.player,limit=1] ct_seat
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_setlayout = @s ct_ch_epoch
scoreboard players set @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_settings 0
scoreboard players enable @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_settings
scoreboard players operation #set_base sp_ctx = #settings_serial sp_ctx
scoreboard players operation #set_base sp_ctx *= #factor sp_ctx
execute store result storage splendor:settings close int 1 run scoreboard players get #set_base sp_ctx
''' + '\n'.join(f'execute store result storage splendor:settings {key} int 1 run scoreboard players get @s sp_{key}' for _,key,_,_ in FIELDS))
    rows=[]
    for field,key,label,values in FIELDS:
        rows += ['data modify storage splendor:settings '+key+'_row set value '+json.dumps({'text':label+'：','color':'gray','extra':[]},ensure_ascii=False,separators=(',',':'))]
        for value,title in values:
            rows += ['function splendor:settings/choice '+json.dumps({'key':key,'value':value,'code':field*100+value,'label':title},ensure_ascii=False,separators=(',',':'))]
    put('settings/root',rows+['function splendor:settings/root_show with storage splendor:settings'])
    put('settings/choice', '''
$execute store result score #set_current sp_ctx run data get storage splendor:settings $(key)
$data modify storage splendor:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #set_code sp_ctx $(code)
scoreboard players operation #set_code sp_ctx += #set_base sp_ctx
execute store result storage splendor:settings code int 1 run scoreboard players get #set_code sp_ctx
$execute unless score #set_current sp_ctx matches $(value) run function splendor:settings/command with storage splendor:settings
$execute if score #set_current sp_ctx matches $(value) run data modify storage splendor:settings option.color set value "gold"
$execute if score #set_current sp_ctx matches $(value) run data modify storage splendor:settings option.bold set value true
$data modify storage splendor:settings $(key)_row.extra append from storage splendor:settings option
''')
    put('settings/command','$data modify storage splendor:settings option.click_event set value {action:"run_command",command:"trigger sp_settings set $(code)"}')
    dialog = {'type':'minecraft:notice','title':{'text':'璀璨宝石 · 游戏设置','color':'gold'},
        'body':[json.loads(SKIN_ROW),json.loads(CHAIR_ROW)]+[{'type':'minecraft:plain_message','width':440,'contents':'__'+key+'__'} for _,key,_,_ in FIELDS]+
        [{'type':'minecraft:plain_message','width':440,'contents':{'text':'2～4人 · 经典基础版 · 15分触发末轮。金色为当前选项，点击其他值立即生效。','color':'gray'}}],
        'action':{'label':{'text':'完成'},'width':140,'action':{'type':'minecraft:run_command','command':'trigger sp_settings set $(close)'}},
        'pause':False,'can_close_with_escape':True,'after_action':'none'}
    payload=json.dumps(dialog,ensure_ascii=False,separators=(',',':'))
    for _,key,_,_ in FIELDS:payload=payload.replace('"__'+key+'__"','$('+key+'_row)')
    put('settings/root_show','$dialog show @a[tag=ct.settings_actor,tag=ct.player,limit=1] '+payload)
    save='''
scoreboard players operation #set_input sp_ctx = @s sp_settings
scoreboard players reset @s sp_settings
execute unless entity @s[tag=ct.player] run return run function splendor:settings/invalid
execute unless score @s sp_setload = #settings_load sp_ctx run return run function splendor:settings/invalid
execute unless score @s ct_id = @s sp_settable run return run function splendor:settings/invalid
execute unless score @s ct_seat = @s sp_setseat run return run function splendor:settings/invalid
execute unless score #set_input sp_ctx matches 100000000..999990201 run return run function splendor:settings/invalid
scoreboard players operation #set_nonce sp_ctx = #set_input sp_ctx
scoreboard players operation #set_nonce sp_ctx /= #factor sp_ctx
execute unless score #set_nonce sp_ctx = @s sp_setnonce run return run function splendor:settings/invalid
scoreboard players operation #set_field sp_ctx = #set_input sp_ctx
scoreboard players operation #set_field sp_ctx %= #factor sp_ctx
scoreboard players operation #set_field sp_ctx /= #hundred sp_ctx
scoreboard players operation #set_value sp_ctx = #set_input sp_ctx
scoreboard players operation #set_value sp_ctx %= #hundred sp_ctx
scoreboard players operation #set_table sp_ctx = @s sp_settable
scoreboard players operation #set_epoch sp_ctx = @s sp_setepoch
scoreboard players operation #set_layout sp_ctx = @s sp_setlayout
tag @e[tag=sp.setting_table] remove sp.setting_table
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=22,ct_state=0}] if score @s ct_id = #set_table sp_ctx if score @s sp_epoch = #set_epoch sp_ctx if score @s ct_ch_epoch = #set_layout sp_ctx run tag @s add sp.setting_table
execute unless entity @e[tag=sp.setting_table,limit=1] run return run function splendor:settings/invalid
execute unless score #set_field sp_ctx matches 0..2 run return run function splendor:settings/invalid
execute if score #set_field sp_ctx matches 0 unless score #set_value sp_ctx matches 0 run return run function splendor:settings/invalid
execute if score #set_field sp_ctx matches 1..2 unless score #set_value sp_ctx matches 0..1 run return run function splendor:settings/invalid
scoreboard players reset @s sp_setnonce
execute if score #set_field sp_ctx matches 0 run return run function splendor:settings/close
'''.strip().splitlines()
    for field,key,_,_ in FIELDS:save += [f'execute if score #set_field sp_ctx matches {field} run scoreboard players operation @e[tag=sp.setting_table,limit=1] sp_{key} = #set_value sp_ctx']
    save += ['scoreboard players add @e[tag=sp.setting_table,limit=1] sp_epoch 1', 'tag @a[tag=ct.settings_actor] remove ct.settings_actor','tag @s add ct.settings_actor','execute as @e[tag=sp.setting_table,limit=1] at @s run function splendor:settings/open','tag @s remove ct.settings_actor','tag @e[tag=sp.setting_table] remove sp.setting_table']
    put('settings/save',save)
    put('settings/clear_session',[f'scoreboard players reset @s sp_{key}' for key in ['settings','setnonce','setload','settable','setepoch','setseat','setlayout']])
    put('settings/close',['function splendor:settings/clear_session','dialog clear @s','tag @s remove ct.settings_actor','tag @e[tag=sp.setting_table] remove sp.setting_table'])
    put('settings/invalid',['function splendor:settings/clear_session','tellraw @s {text:"[璀璨宝石] 设置窗口已过期，请重新打开。",color:"yellow"}','tag @e[tag=sp.setting_table] remove sp.setting_table'])
    put('settings/invalidate_table',['scoreboard players operation #set_table sp_ctx = @s ct_id','execute as @a if score @s sp_settable = #set_table sp_ctx run function splendor:settings/clear_session'])
    print('璀璨宝石即时设置已生成。')


if __name__ == '__main__':
    main()
