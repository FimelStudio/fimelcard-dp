"""掼蛋：一页点击立即生效的本桌设置与失效会话保护。"""
from pathlib import Path
import json

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / 'data/guandan/function/settings'
OBJECTIVES = {n:'dummy' for n in 'gd_setnonce gd_settable gd_setload gd_setinput'.split()}
OBJECTIVES['gd_settings'] = 'trigger'
FIELDS = [
    (1,'pair','搭档分配',[(0,'按座位自选'),(1,'随机分队')]),
    (2,'startlevel','起始级牌',[(v,str(v) if v<11 else {11:'J',12:'Q',13:'K',14:'A'}[v]) for v in range(2,15)]),
    (3,'mode','比赛模式',[(0,'完整升级赛'),(1,'固定副数')]),
    (4,'rounds','固定副数',[(v,str(v)+'副') for v in (1,2,3,5,8,10,16,32)]),
    (5,'show','显示其他玩家余牌数',[(1,'开启'),(0,'关闭')]),
    (6,'limit','每步操作时限',[(0,'无限制')]+[(v,str(v)+'秒') for v in (30,60,90,120)]),
]


def js(value):
    return json.dumps(value,ensure_ascii=False,separators=(',',':'))


def build():
    def put(name,body):
        path=ROOT/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True)
        path.write_text(body.strip()+'\n',encoding='utf-8')
    put('open','''
function guandan:game/init_table
execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 18 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #setting_table gd_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,limit=1] ct_id = #setting_table gd_ctx run return 0
scoreboard players add #setting_serial gd_ctx 1
execute if score #setting_serial gd_ctx matches 20001.. run scoreboard players add #ui_load gd_ctx 1
execute if score #setting_serial gd_ctx matches 20001.. run scoreboard players set #setting_serial gd_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] gd_setnonce = #setting_serial gd_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] gd_setload = #ui_load gd_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] gd_settable = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] gd_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] gd_settings
scoreboard players set #setting_factor gd_ctx 100000
scoreboard players operation #setting_base gd_ctx = #setting_serial gd_ctx
scoreboard players operation #setting_base gd_ctx *= #setting_factor gd_ctx
execute store result storage guandan:settings close int 1 run scoreboard players get #setting_base gd_ctx
'''+ '\n'.join(f'execute store result storage guandan:settings {key} int 1 run scoreboard players get @s gd_{key}' for _,key,_,_ in FIELDS)+ '\nfunction guandan:settings/root')
    lines=[]
    for field,key,label,choices in FIELDS:
        lines.append('data modify storage guandan:settings '+key+'_row set value '+js({'text':label+'\n','color':'white','extra':[]}))
        for value,name in choices:
            lines.append('function guandan:settings/choice '+js({'key':key,'value':value,'code':field*1000+value,'label':name}))
    put('root','\n'.join(lines)+'\nfunction guandan:settings/show with storage guandan:settings')
    put('choice','''
$execute store result score #setting_current gd_ctx run data get storage guandan:settings $(key)
$scoreboard players set #setting_code gd_ctx $(code)
scoreboard players operation #setting_code gd_ctx += #setting_base gd_ctx
execute store result storage guandan:settings code int 1 run scoreboard players get #setting_code gd_ctx
$data modify storage guandan:settings option set value {text:" [$(label)] ",color:"aqua"}
$execute if score #setting_current gd_ctx matches $(value) run data modify storage guandan:settings option.color set value "gold"
$execute if score #setting_current gd_ctx matches $(value) run data modify storage guandan:settings option.bold set value true
$execute unless score #setting_current gd_ctx matches $(value) run function guandan:settings/command with storage guandan:settings
$data modify storage guandan:settings $(key)_row.extra append from storage guandan:settings option
''')
    put('command','$data modify storage guandan:settings option.click_event set value {action:"run_command",command:"trigger gd_settings set $(code)"}')
    dialog={'type':'minecraft:notice','title':{'text':'掼蛋 · 游戏设置','color':'gold'},'body':[
        {'type':'minecraft:plain_message','width':480,'contents':{'text':'【牌桌皮肤 · 点击选择】','color':'aqua','underlined':True,'click_event':{'action':'run_command','command':'trigger ct_skin_pick set 4'}}}
    ]+[{'type':'minecraft:plain_message','width':480,'contents':'__'+key+'_row__'} for _,key,_,_ in FIELDS],
        'action':{'label':{'text':'完成'},'width':140,'action':{'type':'minecraft:run_command','command':'trigger gd_settings set $(close)'}},'pause':False,'can_close_with_escape':True,'after_action':'none'}
    text=js(dialog)
    for _,key,_,_ in FIELDS:text=text.replace('"__'+key+'_row__"','$('+key+'_row)')
    put('show','$dialog show @a[tag=ct.settings_actor,limit=1] '+text)
    validations=[]
    for field,key,_,choices in FIELDS:
        validations.append(f'execute if score #setting_field gd_ctx matches {field} '+' '.join(f'unless score #setting_value gd_ctx matches {v}' for v,_ in choices)+' run return run function guandan:settings/invalid')
    put('save','''
scoreboard players operation @s gd_setinput = @s gd_settings
scoreboard players reset @s gd_settings
execute unless entity @s[tag=ct.player] run return run function guandan:settings/invalid
execute unless score @s gd_setload = #ui_load gd_ctx run return run function guandan:settings/invalid
execute unless score @s ct_id = @s gd_settable run return run function guandan:settings/invalid
scoreboard players set #setting_factor gd_ctx 100000
scoreboard players operation #setting_nonce gd_ctx = @s gd_setinput
scoreboard players operation #setting_nonce gd_ctx /= #setting_factor gd_ctx
execute unless score #setting_nonce gd_ctx = @s gd_setnonce run return run function guandan:settings/invalid
scoreboard players set @s gd_setnonce 0
scoreboard players operation #setting_input gd_ctx = @s gd_setinput
scoreboard players operation #setting_input gd_ctx %= #setting_factor gd_ctx
scoreboard players set #setting_factor gd_ctx 1000
scoreboard players operation #setting_field gd_ctx = #setting_input gd_ctx
scoreboard players operation #setting_field gd_ctx /= #setting_factor gd_ctx
scoreboard players operation #setting_value gd_ctx = #setting_input gd_ctx
scoreboard players operation #setting_value gd_ctx %= #setting_factor gd_ctx
execute unless score #setting_field gd_ctx matches 0..6 run return run function guandan:settings/invalid
execute if score #setting_field gd_ctx matches 0 unless score #setting_value gd_ctx matches 0 run return run function guandan:settings/invalid
'''+ '\n'.join(validations)+'''
tag @e[tag=gd.setting_table] remove gd.setting_table
scoreboard players operation #setting_table gd_ctx = @s gd_settable
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=18,ct_state=0}] if score @s ct_id = #setting_table gd_ctx run tag @s add gd.setting_table
execute unless entity @e[tag=gd.setting_table,limit=1] run return run function guandan:settings/invalid
execute if score #setting_field gd_ctx matches 0 run return run function guandan:settings/close
'''+ '\n'.join(f'execute if score #setting_field gd_ctx matches {field} run scoreboard players operation @e[tag=gd.setting_table,limit=1] gd_{key} = #setting_value gd_ctx' for field,key,_,_ in FIELDS)+'''
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
execute as @e[tag=gd.setting_table,limit=1] at @s run function guandan:settings/open
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @e[tag=gd.setting_table] remove gd.setting_table
''')
    put('invalid','tellraw @s {text:"[掼蛋] 设置窗口已过期或输入无效，请重新打开设置。",color:"yellow"}\ntag @e[tag=gd.setting_table] remove gd.setting_table')
    put('close','dialog clear @s\ntag @e[tag=gd.setting_table] remove gd.setting_table')
    put('clear_session','\n'.join('scoreboard players reset @s '+name for name in OBJECTIVES))
    put('invalidate_table','scoreboard players operation #setting_table gd_ctx = @s ct_id\nexecute as @a if score @s gd_settable = #setting_table gd_ctx run function guandan:settings/clear_session')


if __name__=='__main__':build()
