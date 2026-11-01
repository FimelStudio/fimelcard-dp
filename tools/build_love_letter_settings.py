"""情书：同页即时生效的桌内设置，校验会话与当前桌状态。"""
from pathlib import Path
import json

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / 'data/love_letter/function'
OBJECTIVES = {name: 'dummy' for name in 'll_setnonce ll_settable ll_setload ll_setinput'.split()}
OBJECTIVES['ll_settings'] = 'trigger'


def build():
    def put(name, text):
        path = ROOT / ('settings/' + name + '.mcfunction')
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text.strip()+'\n', encoding='utf-8')

    def js(value):
        return json.dumps(value, ensure_ascii=False, separators=(',', ':'))

    put('open', '''
function love_letter:game/init_table
execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 17 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #setting_table ll_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,limit=1] ct_id = #setting_table ll_ctx run return 0
scoreboard players add #setting_serial ll_ctx 1
execute if score #setting_serial ll_ctx matches 20001.. run scoreboard players add #ui_load ll_ctx 1
execute if score #setting_serial ll_ctx matches 20001.. run scoreboard players set #setting_serial ll_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ll_setnonce = #setting_serial ll_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ll_setload = #ui_load ll_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ll_settable = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] ll_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] ll_settings
scoreboard players set #setting_factor ll_ctx 100000
scoreboard players operation #setting_base ll_ctx = #setting_serial ll_ctx
scoreboard players operation #setting_base ll_ctx *= #setting_factor ll_ctx
execute store result storage love_letter:settings close int 1 run scoreboard players get #setting_base ll_ctx
execute store result storage love_letter:settings first int 1 run scoreboard players get @s ll_first_setting
execute store result storage love_letter:settings goal int 1 run scoreboard players get @s ll_goal_setting
execute store result storage love_letter:settings discards int 1 run scoreboard players get @s ll_discards_setting
execute store result storage love_letter:settings time int 1 run scoreboard players get @s ll_time_setting
function love_letter:settings/root
''')
    fields = [(1, 'first', '首轮先手', [(0, '随机'), (1, '最小座号')]),
              (2, 'goal', '获胜好感标记', [(0, '自动')] + [(v, str(v)) for v in range(1, 11)]),
              (3, 'discards', '公开弃牌文字提示', [(1, '开启'), (0, '关闭')]),
              (4, 'time', '每步操作时限', [(0, '无限制')] + [(v, str(v)+'秒') for v in (30, 60, 90, 120)])]
    lines = []
    for field, key, label, choices in fields:
        lines.append('data modify storage love_letter:settings '+key+'_row set value '+js({'text':label+'\n','color':'white','extra':[]}))
        for value, name in choices:
            lines.append('function love_letter:settings/choice '+js({'key':key,'value':value,'code':field*1000+value,'label':name}))
    lines.append('function love_letter:settings/show with storage love_letter:settings')
    put('root', '\n'.join(lines))
    put('choice', '''
$execute store result score #setting_current ll_ctx run data get storage love_letter:settings $(key)
$scoreboard players set #setting_code ll_ctx $(code)
scoreboard players operation #setting_code ll_ctx += #setting_base ll_ctx
execute store result storage love_letter:settings code int 1 run scoreboard players get #setting_code ll_ctx
$data modify storage love_letter:settings option set value {text:" [$(label)] ",color:"aqua"}
$execute if score #setting_current ll_ctx matches $(value) run data modify storage love_letter:settings option.color set value "gold"
$execute if score #setting_current ll_ctx matches $(value) run data modify storage love_letter:settings option.bold set value true
$execute unless score #setting_current ll_ctx matches $(value) run function love_letter:settings/command with storage love_letter:settings
$data modify storage love_letter:settings $(key)_row.extra append from storage love_letter:settings option
''')
    put('command', '$data modify storage love_letter:settings option.click_event set value {action:"run_command",command:"trigger ll_settings set $(code)"}')
    dialog = {'type':'minecraft:notice','title':{'text':'情书 · 游戏设置','color':'gold'},'body':[
        {'type':'minecraft:plain_message','width':460,'contents':{'text':'【牌桌皮肤 · 点击选择】','color':'aqua','underlined':True,'click_event':{'action':'run_command','command':'trigger ct_skin_pick set 4'}}}]
        + [{'type':'minecraft:plain_message','width':460,'contents':'__'+key+'_row__'} for _,key,_,_ in fields]
        + [{'type':'minecraft:plain_message','width':460,'contents':{'text':'自动目标：2人6枚、3人5枚、4人4枚、5～6人3枚。下轮由本轮胜者先手，并列则从胜者中随机。','color':'gray'}}],
        'action':{'label':{'text':'完成'},'width':140,'action':{'type':'minecraft:run_command','command':'trigger ll_settings set $(close)'}},
        'pause':False,'can_close_with_escape':True,'after_action':'none'}
    show = js(dialog)
    for _,key,_,_ in fields:
        show = show.replace('"__'+key+'_row__"', '$('+key+'_row)')
    put('show', '$dialog show @a[tag=ct.settings_actor,limit=1] '+show)
    put('save', '''
scoreboard players operation @s ll_setinput = @s ll_settings
scoreboard players reset @s ll_settings
execute unless entity @s[tag=ct.player] run return run function love_letter:settings/invalid
execute unless score @s ll_setload = #ui_load ll_ctx run return run function love_letter:settings/invalid
execute unless score @s ct_id = @s ll_settable run return run function love_letter:settings/invalid
scoreboard players set #setting_factor ll_ctx 100000
scoreboard players operation #setting_nonce ll_ctx = @s ll_setinput
scoreboard players operation #setting_nonce ll_ctx /= #setting_factor ll_ctx
execute unless score #setting_nonce ll_ctx = @s ll_setnonce run return run function love_letter:settings/invalid
scoreboard players set @s ll_setnonce 0
scoreboard players operation #setting_input ll_ctx = @s ll_setinput
scoreboard players operation #setting_input ll_ctx %= #setting_factor ll_ctx
scoreboard players set #setting_factor ll_ctx 1000
scoreboard players operation #setting_field ll_ctx = #setting_input ll_ctx
scoreboard players operation #setting_field ll_ctx /= #setting_factor ll_ctx
scoreboard players operation #setting_value ll_ctx = #setting_input ll_ctx
scoreboard players operation #setting_value ll_ctx %= #setting_factor ll_ctx
execute unless score #setting_field ll_ctx matches 0..4 run return run function love_letter:settings/invalid
execute if score #setting_field ll_ctx matches 0 unless score #setting_value ll_ctx matches 0 run return run function love_letter:settings/invalid
execute if score #setting_field ll_ctx matches 1 unless score #setting_value ll_ctx matches 0..1 run return run function love_letter:settings/invalid
execute if score #setting_field ll_ctx matches 2 unless score #setting_value ll_ctx matches 0..10 run return run function love_letter:settings/invalid
execute if score #setting_field ll_ctx matches 3 unless score #setting_value ll_ctx matches 0..1 run return run function love_letter:settings/invalid
execute if score #setting_field ll_ctx matches 4 unless score #setting_value ll_ctx matches 0 unless score #setting_value ll_ctx matches 30 unless score #setting_value ll_ctx matches 60 unless score #setting_value ll_ctx matches 90 unless score #setting_value ll_ctx matches 120 run return run function love_letter:settings/invalid
tag @e[tag=ll.setting_table] remove ll.setting_table
scoreboard players operation #setting_table ll_ctx = @s ll_settable
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=17,ct_state=0}] if score @s ct_id = #setting_table ll_ctx run tag @s add ll.setting_table
execute unless entity @e[tag=ll.setting_table,limit=1] run return run function love_letter:settings/invalid
execute if score #setting_field ll_ctx matches 0 run return run function love_letter:settings/close
execute if score #setting_field ll_ctx matches 1 run scoreboard players operation @e[tag=ll.setting_table,limit=1] ll_first_setting = #setting_value ll_ctx
execute if score #setting_field ll_ctx matches 2 run scoreboard players operation @e[tag=ll.setting_table,limit=1] ll_goal_setting = #setting_value ll_ctx
execute if score #setting_field ll_ctx matches 3 run scoreboard players operation @e[tag=ll.setting_table,limit=1] ll_discards_setting = #setting_value ll_ctx
execute if score #setting_field ll_ctx matches 4 run scoreboard players operation @e[tag=ll.setting_table,limit=1] ll_time_setting = #setting_value ll_ctx
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
execute as @e[tag=ll.setting_table,limit=1] at @s run function love_letter:settings/open
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @e[tag=ll.setting_table] remove ll.setting_table
''')
    put('invalid', '''
tellraw @s {text:"[情书] 设置窗口已过期或输入无效，请重新打开设置。",color:"yellow"}
tag @e[tag=ll.setting_table] remove ll.setting_table
''')
    put('close', 'dialog clear @s\ntag @e[tag=ll.setting_table] remove ll.setting_table')
    put('clear_session', '\n'.join('scoreboard players reset @s '+name for name in OBJECTIVES))
    put('invalidate_table', '''
scoreboard players operation #setting_table ll_ctx = @s ct_id
execute as @a if score @s ll_settable = #setting_table ll_ctx run function love_letter:settings/clear_session
''')


if __name__ == '__main__':
    build()
