"""情书：私人手牌、目标/猜牌/大臣选择、公开历史及 Q 操作。"""
from pathlib import Path
import json

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / 'data/love_letter/function'
OBJECTIVES = {name: 'dummy' for name in '''ll_seen ll_pick ll_ui_tmp ll_ui_load'''.split()}
OBJECTIVES.update({'ll_action':'trigger', 'll_drop':'minecraft.dropped:minecraft.purple_dye'})
ROLES = ['间谍','侍卫','牧师','男爵','侍女','王子','大臣','国王','伯爵夫人','公主']
MODELS = ['spy','guard','priest','baron','handmaid','prince','chancellor','king','countess','princess']
EFFECTS = ['本轮唯一仍存活、曾打出或弃过间谍的玩家额外获得1枚好感。','选择另一位未受保护的玩家，猜测其手牌（不能猜侍卫），猜中则淘汰。','秘密查看另一位未受保护玩家的手牌。','与你选的未受保护玩家秘密比较留牌，点数低者淘汰，同值均留下。','保护自己直到下一回合开始，其他玩家不能将你选为角色效果的目标。','选择任何未受保护的玩家（可以自己），公开弃掉手牌再补一张；弃公主则淘汰且不补。','最多再摸两张，秘密留一张，其余自行排序放回牌库底。','与另一位未受保护玩家交换留牌。','与国王或王子同时在手时必须打出；可以主动打出，其他玩家不知道是否被迫。','打出或被弃掉便立即淘汰。']


def js(value):
    return json.dumps(value, ensure_ascii=False, separators=(',', ':'))


def put(name, text):
    path = ROOT / (name + '.mcfunction')
    path.parent.mkdir(parents=True, exist_ok=True)
    if isinstance(text, list):
        text = '\n'.join(text)
    path.write_text(text.strip() + '\n', encoding='utf-8')


def build():
    """只生成本模块拥有的 UI/input/name/rules 路径。"""
    put('name/resolve', '''
# 解析实际玩家名字为字面组件，防止 Dialog 将 selector 当作文字显示。
data modify storage love_letter:name resolved set value {text:"未知玩家"}
kill @e[type=minecraft:item_display,tag=ll.name_resolver,distance=..1,limit=1]
summon minecraft:item_display ~ ~ ~ {Tags:["ll.name_resolver"],view_range:0f,item:{id:"minecraft:paper"}}
loot replace entity @e[type=minecraft:item_display,tag=ll.name_resolver,distance=..1,sort=nearest,limit=1] contents loot love_letter:player_name
data modify storage love_letter:name resolved set from entity @e[type=minecraft:item_display,tag=ll.name_resolver,distance=..1,sort=nearest,limit=1] item.components."minecraft:custom_name"
data remove storage love_letter:name resolved.click_event
data remove storage love_letter:name resolved.hover_event
data remove storage love_letter:name resolved.insertion
kill @e[type=minecraft:item_display,tag=ll.name_resolver,distance=..1,sort=nearest,limit=1]
''')
    loot = {'pools':[{'rolls':1,'entries':[{'type':'minecraft:item','name':'minecraft:paper','functions':[{'function':'minecraft:set_name','entity':'this','name':{'selector':'@s'}}]}]}]}
    path = PACK/'data/love_letter/loot_table/player_name.json'
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(loot,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    put('input/give', '''
clear @s *[minecraft:custom_data~{love_letter:{tool:1b}}]
execute store result storage love_letter:input table int 1 run scoreboard players get @s ll_table
function love_letter:input/give_tools with storage love_letter:input
''')
    put('input/give_tools', '''
$function love_letter:input/place_tool {table:$(table),slot:0,action:0,name:"情书 · 手牌",model:"card:love_letter/back"}
$function love_letter:input/place_tool {table:$(table),slot:8,action:8,name:"情书 · 对局菜单",model:"minecraft:book"}
''')
    put('input/place_tool', '''
$execute unless items entity @s hotbar.$(slot) * run return run item replace entity @s hotbar.$(slot) with minecraft:purple_dye[minecraft:item_name="$(name)",minecraft:item_model="$(model)",minecraft:custom_data={love_letter:{tool:1b,action:$(action),table:$(table)}},minecraft:max_stack_size=1]
$give @s minecraft:purple_dye[minecraft:item_name="$(name)",minecraft:item_model="$(model)",minecraft:custom_data={love_letter:{tool:1b,action:$(action),table:$(table)}},minecraft:max_stack_size=1]
''')
    put('input/tick', '''
execute as @a[tag=ll.player,scores={ll_drop=1..}] at @s run function love_letter:input/drop
execute as @a[tag=ll.player,scores={ll_action=1..}] at @s run function love_letter:input/submit
execute as @a[scores={ll_settings=1..}] at @s run function love_letter:settings/save
''')
    put('input/drop', '''
scoreboard players set @s ll_drop 0
tag @a[tag=ll.dropper] remove ll.dropper
tag @s add ll.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents *[minecraft:custom_data~{love_letter:{tool:1b}}] run function love_letter:input/check_drop
tag @a[tag=ll.dropper] remove ll.dropper
''')
    put('input/check_drop', '''
scoreboard players set #drop_owner ll_ctx 0
execute on origin if entity @s[tag=ll.dropper,tag=ll.player] run scoreboard players set #drop_owner ll_ctx 1
execute unless score #drop_owner ll_ctx matches 1 run return 0
execute store result score #tool_action ll_ctx run data get entity @s Item.components."minecraft:custom_data".love_letter.action
kill @s
execute as @a[tag=ll.dropper,limit=1] run function love_letter:input/give
execute if score #tool_action ll_ctx matches 8 as @a[tag=ll.dropper,limit=1] at @s run return run function love_letter:ui/menu
execute as @a[tag=ll.dropper,limit=1] at @s run function love_letter:ui/open
''')
    put('input/context', '''
tag @a[tag=ll.actor] remove ll.actor
tag @e[tag=ll.me] remove ll.me
tag @e[tag=ll.current] remove ll.current
execute unless entity @s[tag=ct.player,tag=ll.player] run return 0
execute unless score @s ct_id = @s ll_table run return 0
scoreboard players operation #ui_table ll_ctx = @s ll_table
scoreboard players operation #ui_seat ll_ctx = @s ll_seat
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ll.controller,scores={ct_game=17,ct_state=1,ll_state=1..4}] if score @s ct_id = #ui_table ll_ctx run tag @s add ll.current
execute unless entity @e[tag=ll.current,limit=1] run return 0
execute as @e[tag=ll.current,limit=1] at @s run function love_letter:system/context
execute as @e[tag=ll.board] if score @s ll_seat = #ui_seat ll_ctx run tag @s add ll.me
execute unless entity @e[tag=ll.me,limit=1] run return 0
tag @s add ll.actor
scoreboard players operation #actor ll_ctx = @s ll_seat
''')
    put('input/invalid', 'tellraw @s {text:"[情书] 这个操作已过期或当前不可用，请按Q重新打开。",color:"yellow"}')
    put('input/submit', '''
scoreboard players operation @s ll_ui_tmp = @s ll_action
scoreboard players set @s ll_action 0
scoreboard players enable @s ll_action
function love_letter:input/context
execute unless entity @s[tag=ll.actor] run return run function love_letter:input/invalid
execute unless score @s ll_ui_load = #ui_load ll_ctx run return run function love_letter:input/invalid
scoreboard players set #ui_factor ll_ctx 1000
scoreboard players operation #ui_epoch ll_ctx = @s ll_ui_tmp
scoreboard players operation #ui_epoch ll_ctx /= #ui_factor ll_ctx
execute unless score #ui_epoch ll_ctx = @s ll_seen run return run function love_letter:input/invalid
execute unless score #ui_epoch ll_ctx = @e[tag=ll.current,limit=1] ll_epoch run return run function love_letter:input/invalid
scoreboard players operation #ui_action ll_ctx = @s ll_ui_tmp
scoreboard players operation #ui_action ll_ctx %= #ui_factor ll_ctx
execute if score #ui_action ll_ctx matches 1 run return run function love_letter:ui/open
execute if score #ui_action ll_ctx matches 2 run return run function love_letter:ui/menu
execute if score #ui_action ll_ctx matches 3 run return run function love_letter:ui/public
execute if score #ui_action ll_ctx matches 4 run return run function love_letter:rules/player
execute if score #ui_action ll_ctx matches 5 run return run function love_letter:ui/resign
execute if score #ui_action ll_ctx matches 6 run return run function love_letter:input/resign
execute if score #ui_action ll_ctx matches 10..11 run return run function love_letter:input/select
execute if score #ui_action ll_ctx matches 20 run return run function love_letter:input/play
dialog clear @s
scoreboard players set #ok ll_ctx 0
execute if score #ui_action ll_ctx matches 101..108 run function love_letter:input/target
execute if score #ui_action ll_ctx matches 200..209 unless score #ui_action ll_ctx matches 201 run function love_letter:input/guess
execute if score #ui_action ll_ctx matches 300..302 run function love_letter:input/keep
execute if score #ui_action ll_ctx matches 400..401 run function love_letter:input/bottom
execute unless score #ok ll_ctx matches 1 run function love_letter:input/invalid
''')
    put('input/select', '''
execute unless entity @e[tag=ll.current,scores={ll_state=2,ll_phase=1,ll_anim=0},limit=1] run return run function love_letter:input/invalid
execute unless score @s ll_seat = @e[tag=ll.current,limit=1] ll_turn run return run function love_letter:input/invalid
execute unless entity @e[tag=ll.me,scores={ll_alive=1},limit=1] run return run function love_letter:input/invalid
scoreboard players operation #ui_slot ll_ctx = #ui_action ll_ctx
scoreboard players remove #ui_slot ll_ctx 10
execute if score @s ll_pick = #ui_slot ll_ctx run return run function love_letter:input/deselect
scoreboard players operation @s ll_pick = #ui_slot ll_ctx
function love_letter:ui/open
''')
    put('input/deselect','scoreboard players set @s ll_pick -1\nfunction love_letter:ui/open')
    put('input/play', '''
execute unless score @s ll_pick matches 0..1 run return run function love_letter:input/invalid
scoreboard players operation #slot ll_ctx = @s ll_pick
dialog clear @s
execute as @e[tag=ll.current,limit=1] at @s run function love_letter:engine/play
execute unless score #ok ll_ctx matches 1 run function love_letter:input/invalid
''')
    for name, score, offset in [('target','target',100),('guess','guess',200),('keep','keep',300),('bottom','bottom',400)]:
        put('input/'+name,f'''scoreboard players operation #{score} ll_ctx = #ui_action ll_ctx
scoreboard players remove #{score} ll_ctx {offset}
execute as @e[tag=ll.current,limit=1] at @s run function love_letter:engine/{name}''')
    put('input/resign', '''
execute unless entity @e[tag=ll.current,scores={ll_state=2},limit=1] run return run function love_letter:input/invalid
execute unless entity @e[tag=ll.me,scores={ll_alive=1},limit=1] run return run function love_letter:input/invalid
dialog clear @s
execute as @e[tag=ll.current,limit=1] at @s run function love_letter:game/resign
''')
    put('input/clear', '\n'.join('scoreboard players reset @s '+name for name in OBJECTIVES)+'\nclear @s *[minecraft:custom_data~{love_letter:{tool:1b}}]\ntag @s remove ll.actor')
    put('ui/begin', '''
scoreboard players operation @s ll_seen = @e[tag=ll.current,limit=1] ll_epoch
scoreboard players operation @s ll_ui_load = #ui_load ll_ctx
scoreboard players operation #ui_base ll_ctx = @s ll_seen
scoreboard players set #ui_factor ll_ctx 1000
scoreboard players operation #ui_base ll_ctx *= #ui_factor ll_ctx
scoreboard players set @s ll_action 0
scoreboard players enable @s ll_action
data modify storage love_letter:ui buttons set value []
data modify storage love_letter:ui cards set value {text:"",shadow_color:0,extra:[]}
data modify storage love_letter:ui info set value {text:"",extra:[]}
data modify storage love_letter:ui rows set value {text:"",extra:[]}
data modify storage love_letter:ui phase set value {text:"等待其他玩家。",color:"gray"}
data modify storage love_letter:ui title set value "情书 · 手牌"
''')
    put('ui/refresh', '''
# 只对当前决策玩家展开选择；旁观者与其他玩家不会被强制弹窗。
function love_letter:system/context
scoreboard players set @a[tag=ll.audience] ll_pick -1
scoreboard players set @a[tag=ll.audience] ll_action 0
scoreboard players enable @a[tag=ll.audience] ll_action
execute unless score @s ll_state matches 2 run return 0
execute unless score @s ll_anim matches 0 run return 0
scoreboard players operation #ui_decider ll_ctx = @s ll_actor
execute if score @s ll_phase matches 1 run scoreboard players operation #ui_decider ll_ctx = @s ll_turn
execute as @a[tag=ll.audience] if score @s ll_seat = #ui_decider ll_ctx run function love_letter:ui/open
''')
    put('ui/open', '''
function love_letter:input/context
execute unless entity @s[tag=ll.actor] run return 0
function love_letter:ui/begin
function love_letter:ui/players
data modify storage love_letter:ui cards set value {text:"\\n\\n\\n\\n\\n",shadow_color:0,extra:[]}
scoreboard players operation #ui_card ll_ctx = @e[tag=ll.me,limit=1] ll_hand
function love_letter:ui/card {slot:0,offset:10}
scoreboard players operation #ui_card ll_ctx = @e[tag=ll.me,limit=1] ll_extra
function love_letter:ui/card {slot:1,offset:11}
execute if entity @e[tag=ll.me,scores={ll_alive=0},limit=1] run data modify storage love_letter:ui phase set value {text:"本轮已淘汰，下一轮重新参加。",color:"gray"}
execute if entity @e[tag=ll.current,scores={ll_state=1},limit=1] run data modify storage love_letter:ui phase set value {text:"正在发牌。",color:"gray"}
execute if entity @e[tag=ll.current,scores={ll_state=3..4},limit=1] run data modify storage love_letter:ui phase set value {text:"本轮已结束。",color:"gold"}
scoreboard players set #ui_active ll_ctx 0
execute if entity @e[tag=ll.current,scores={ll_state=2,ll_anim=0},limit=1] if entity @e[tag=ll.me,scores={ll_alive=1},limit=1] run function love_letter:ui/active
execute if score #ui_active ll_ctx matches 1 run function love_letter:ui/choices
function love_letter:ui/button {code:3,label:"公开牌与积分",color:"aqua"}
function love_letter:ui/button {code:2,label:"对局菜单",color:"gray"}
function love_letter:ui/normalize
function love_letter:ui/show with storage love_letter:ui
''')
    put('ui/active', '''
execute if entity @e[tag=ll.current,scores={ll_phase=1},limit=1] if score @s ll_seat = @e[tag=ll.current,limit=1] ll_turn run scoreboard players set #ui_active ll_ctx 1
execute if entity @e[tag=ll.current,scores={ll_phase=2..5},limit=1] if score @s ll_seat = @e[tag=ll.current,limit=1] ll_actor run scoreboard players set #ui_active ll_ctx 1
''')
    put('ui/card', '''
execute unless score #ui_card ll_ctx matches 0..9 run return 0
$scoreboard players set #ui_card_slot ll_ctx $(slot)
$scoreboard players set #ui_code ll_ctx $(offset)
scoreboard players operation #ui_code ll_ctx += #ui_base ll_ctx
execute store result storage love_letter:ui card_code int 1 run scoreboard players get #ui_code ll_ctx
function love_letter:ui/role
data modify storage love_letter:ui card_font set value "card:love_letter/dialog"
execute if score @s ll_pick = #ui_card_slot ll_ctx run data modify storage love_letter:ui card_font set value "card:love_letter/dialog_selected"
function love_letter:ui/card_append with storage love_letter:ui
''')
    put('ui/role', [f'execute if score #ui_card ll_ctx matches {i} run data merge storage love_letter:ui '+js({'role_name':f'{i} · {name}','role':{'text':f'{i} · {name}','color':'yellow'},'effect':effect,'glyph':chr(0xE800+i)}) for i,(name,effect) in enumerate(zip(ROLES,EFFECTS))])
    put('ui/card_append', '''
$data modify storage love_letter:ui cards.extra append value {text:"",click_event:{action:"run_command",command:"trigger ll_action set $(card_code)"},hover_event:{action:"show_text",value:{text:"$(role_name)\\n$(effect)"}},extra:[{text:"$(glyph)",font:"$(card_font)",color:"white"},{text:"   ",font:"minecraft:default"}]}
$data modify storage love_letter:ui info.extra append value {text:"$(role_name)：$(effect)\\n",color:"gray"}
''')
    put('ui/choices', '''
execute if entity @e[tag=ll.current,scores={ll_phase=1},limit=1] run function love_letter:ui/play_choices
execute if entity @e[tag=ll.current,scores={ll_phase=2},limit=1] run function love_letter:ui/targets
execute if entity @e[tag=ll.current,scores={ll_phase=3},limit=1] run function love_letter:ui/guesses
execute if entity @e[tag=ll.current,scores={ll_phase=4..5},limit=1] run function love_letter:ui/chancellor
''')
    put('ui/play_choices', '''
data modify storage love_letter:ui phase set value {text:"选择一张牌，点击出牌。",color:"green"}
execute if score @s ll_pick matches 0..1 run function love_letter:ui/button {code:20,label:"出牌",color:"green"}
execute if entity @e[tag=ll.me,scores={ll_hand=8,ll_extra=5},limit=1] run data modify storage love_letter:ui phase set value {text:"本回合必须打出伯爵夫人。",color:"yellow"}
execute if entity @e[tag=ll.me,scores={ll_hand=8,ll_extra=7},limit=1] run data modify storage love_letter:ui phase set value {text:"本回合必须打出伯爵夫人。",color:"yellow"}
execute if entity @e[tag=ll.me,scores={ll_extra=8,ll_hand=5},limit=1] run data modify storage love_letter:ui phase set value {text:"本回合必须打出伯爵夫人。",color:"yellow"}
execute if entity @e[tag=ll.me,scores={ll_extra=8,ll_hand=7},limit=1] run data modify storage love_letter:ui phase set value {text:"本回合必须打出伯爵夫人。",color:"yellow"}
''')
    put('ui/targets', '''
data modify storage love_letter:ui phase set value {text:"选择目标。",color:"green"}
scoreboard players operation #ui_role ll_ctx = @e[tag=ll.current,limit=1] ll_card
'''+ '\n'.join(f'execute as @e[tag=ll.board,scores={{ll_seat={seat},ll_alive=1,ll_protect=0}}] run function love_letter:ui/target_button' for seat in range(1,9)))
    put('ui/target_button', '''
execute unless score #ui_role ll_ctx matches 5 if score @s ll_seat = #ui_seat ll_ctx run return 0
scoreboard players operation #ui_code ll_ctx = @s ll_seat
scoreboard players add #ui_code ll_ctx 100
scoreboard players operation #ui_code ll_ctx += #ui_base ll_ctx
execute store result storage love_letter:ui code int 1 run scoreboard players get #ui_code ll_ctx
execute store result storage love_letter:ui seat int 1 run scoreboard players get @s ll_seat
data modify storage love_letter:ui label set from entity @s data.ll_name
function love_letter:ui/target_append with storage love_letter:ui
''')
    put('ui/target_append', '$data modify storage love_letter:ui buttons append value {label:{text:"$(seat)号位 · ",extra:[$(label)]},width:200,action:{type:"minecraft:run_command",command:"trigger ll_action set $(code)"}}')
    put('ui/guesses', 'data modify storage love_letter:ui phase set value {text:"猜测目标手牌（不能猜侍卫）。",color:"green"}\n'+'\n'.join('function love_letter:ui/button '+js({'code':200+i,'label':f'{i} · {ROLES[i]}','color':'yellow'}) for i in range(10) if i!=1))
    put('ui/chancellor', '''
data modify storage love_letter:ui cards set value {text:"\\n\\n\\n\\n\\n",shadow_color:0,extra:[]}
data modify storage love_letter:ui info set value {text:"",extra:[]}
data modify storage love_letter:ui phase set value {text:"选择保留的手牌。",color:"green"}
execute if entity @e[tag=ll.current,scores={ll_phase=5},limit=1] run data modify storage love_letter:ui phase set value {text:"选择先放回牌库底的牌。",color:"green"}
function love_letter:ui/buffer_card {index:0}
function love_letter:ui/buffer_card {index:1}
function love_letter:ui/buffer_card {index:2}
''')
    put('ui/buffer_card', '''
$execute unless data entity @e[tag=ll.current,limit=1] data.ll_buffer[$(index)] run return 0
$execute store result score #ui_card ll_ctx run data get entity @e[tag=ll.current,limit=1] data.ll_buffer[$(index)]
function love_letter:ui/role
data modify storage love_letter:ui card_font set value "card:love_letter/dialog"
$scoreboard players set #ui_code ll_ctx $(index)
execute if entity @e[tag=ll.current,scores={ll_phase=4},limit=1] run scoreboard players add #ui_code ll_ctx 300
execute if entity @e[tag=ll.current,scores={ll_phase=5},limit=1] run scoreboard players add #ui_code ll_ctx 400
scoreboard players operation #ui_code ll_ctx += #ui_base ll_ctx
execute store result storage love_letter:ui card_code int 1 run scoreboard players get #ui_code ll_ctx
function love_letter:ui/card_append with storage love_letter:ui
''')
    put('ui/players', '\n'.join(f'execute as @e[tag=ll.board,scores={{ll_seat={seat}}}] run function love_letter:ui/player_line' for seat in range(1,9)))
    put('ui/player_line', '''
data modify storage love_letter:ui line_name set from entity @s data.ll_name
execute store result storage love_letter:ui line_seat int 1 run scoreboard players get @s ll_seat
execute store result storage love_letter:ui line_points int 1 run scoreboard players get @s ll_points
data modify storage love_letter:ui line_status set value ""
execute if score @s ll_alive matches 0 run data modify storage love_letter:ui line_status set value " · 已淘汰"
execute if score @s ll_protect matches 1 run data modify storage love_letter:ui line_status set value " · 保护"
execute if score @s ll_seat = @e[tag=ll.current,limit=1] ll_turn if score @s ll_alive matches 1 run data modify storage love_letter:ui line_status set value " ▶"
function love_letter:ui/player_append with storage love_letter:ui
''')
    put('ui/player_append', '$data modify storage love_letter:ui rows.extra append value {text:"",extra:[{text:"$(line_seat)号位 ",color:"gray"},$(line_name),{text:" · $(line_points)好感$(line_status)\\n",color:"gray"}]}')
    put('ui/button', '''
$scoreboard players set #ui_code ll_ctx $(code)
scoreboard players operation #ui_code ll_ctx += #ui_base ll_ctx
execute store result storage love_letter:ui code int 1 run scoreboard players get #ui_code ll_ctx
$data modify storage love_letter:ui label set value {text:"$(label)",color:"$(color)"}
function love_letter:ui/button_append with storage love_letter:ui
''')
    put('ui/button_append','$data modify storage love_letter:ui buttons append value {label:$(label),width:200,action:{type:"minecraft:run_command",command:"trigger ll_action set $(code)"}}')
    dialog = {'type':'minecraft:multi_action','title':{'text':'$(title)','color':'gold'},'body':[
        {'type':'minecraft:plain_message','width':480,'contents':'__phase__'},
        {'type':'minecraft:plain_message','width':480,'contents':'__rows__'},
        {'type':'minecraft:plain_message','width':480,'contents':'__cards__'},
        {'type':'minecraft:plain_message','width':480,'contents':'__info__'}],
        'actions':'__buttons__','columns':2,'exit_action':{'label':{'text':'返回游戏'}},'pause':False,'can_close_with_escape':True,'after_action':'none'}
    show=js(dialog)
    for key in ['phase','rows','cards','info','buttons']:
        show=show.replace('"__'+key+'__"','$('+key+')')
    put('ui/normalize','\n'.join(f'execute unless data storage love_letter:ui {key}.extra[0] run data remove storage love_letter:ui {key}.extra' for key in ['phase','rows','cards','info']))
    put('ui/show','$dialog show @s '+show)
    put('ui/menu', '''
function love_letter:input/context
execute unless entity @s[tag=ll.actor] run return 0
function love_letter:ui/begin
data modify storage love_letter:ui title set value "情书 · 对局菜单"
data modify storage love_letter:ui phase set value {text:"",color:"gray"}
function love_letter:ui/players
function love_letter:ui/button {code:1,label:"查看手牌",color:"green"}
function love_letter:ui/button {code:3,label:"公开牌与积分",color:"aqua"}
function love_letter:ui/button {code:4,label:"查看规则",color:"yellow"}
execute if entity @e[tag=ll.me,scores={ll_alive=1},limit=1] if entity @e[tag=ll.current,scores={ll_state=2},limit=1] run function love_letter:ui/button {code:5,label:"本轮认输",color:"red"}
function love_letter:ui/normalize
function love_letter:ui/show with storage love_letter:ui
''')
    put('ui/resign', '''
function love_letter:ui/begin
data modify storage love_letter:ui title set value "情书 · 本轮认输"
data modify storage love_letter:ui phase set value {text:"确认退出本轮？下轮仍可继续。",color:"yellow"}
function love_letter:ui/button {code:6,label:"确认认输",color:"red"}
function love_letter:ui/button {code:2,label:"返回",color:"gray"}
function love_letter:ui/normalize
function love_letter:ui/show with storage love_letter:ui
''')
    put('ui/public', '''
function love_letter:input/context
execute unless entity @s[tag=ll.actor] run return 0
function love_letter:ui/begin
data modify storage love_letter:ui title set value "情书 · 公开牌与积分"
data modify storage love_letter:ui phase set value {text:"所有打出、被弃的牌均公开；未展示其他玩家的留牌。",color:"gray"}
data modify storage love_letter:ui rows set value {text:"双人局额外移出的明牌：",color:"gray",extra:[]}
function love_letter:ui/public_initial {index:0}
function love_letter:ui/public_initial {index:1}
function love_letter:ui/public_initial {index:2}
data modify storage love_letter:ui rows.extra append value {text:"\\n"}
'''+ '\n'.join(f'execute as @e[tag=ll.board,scores={{ll_seat={seat}}}] run function love_letter:ui/history_player' for seat in range(1,9))+'''
function love_letter:ui/button {code:1,label:"查看手牌",color:"green"}
function love_letter:ui/button {code:2,label:"对局菜单",color:"gray"}
function love_letter:ui/normalize
function love_letter:ui/show with storage love_letter:ui
''')
    put('ui/public_initial', '''
$execute unless data entity @e[tag=ll.current,limit=1] data.love_letter.public[$(index)] run return 0
$execute store result score #ui_card ll_ctx run data get entity @e[tag=ll.current,limit=1] data.love_letter.public[$(index)]
function love_letter:ui/role
data modify storage love_letter:ui rows.extra append from storage love_letter:ui role
data modify storage love_letter:ui rows.extra append value {text:"  "}
''')
    put('ui/history_player','function love_letter:ui/player_line\n'+ '\n'.join(f'function love_letter:ui/history_card {{index:{i}}}' for i in range(21))+'\ndata modify storage love_letter:ui rows.extra append value {text:"\\n"}')
    put('ui/history_card', '''
$execute unless data entity @s data.discards[$(index)] run return 0
$execute store result score #ui_card ll_ctx run data get entity @s data.discards[$(index)]
function love_letter:ui/role
data modify storage love_letter:ui rows.extra append from storage love_letter:ui role
data modify storage love_letter:ui rows.extra append value {text:"  "}
''')
    put('ui/private', '''
# 私有结果仅发送给合法知情人；从不将秘密牌值写入公共行、桌面或广播。
execute unless data entity @s data.ll_private.kind run return 0
function love_letter:system/context
data modify storage love_letter:private result set from entity @s data.ll_private
execute store result score #private_actor ll_ctx run data get entity @s data.ll_private.seat
execute store result score #private_target ll_ctx run data get entity @s data.ll_private.target
execute store result score #ui_card ll_ctx run data get entity @s data.ll_private.actor_card
function love_letter:ui/role
data modify storage love_letter:private actor_card set from storage love_letter:ui role
execute store result score #ui_card ll_ctx run data get entity @s data.ll_private.target_card
function love_letter:ui/role
data modify storage love_letter:private target_card set from storage love_letter:ui role
tag @a[tag=ll.private_viewer] remove ll.private_viewer
execute as @a[tag=ll.audience] if score @s ll_seat = #private_actor ll_ctx run tag @s add ll.private_viewer
execute unless data entity @s data.ll_private{kind:"priest"} as @a[tag=ll.audience] if score @s ll_seat = #private_target ll_ctx run tag @s add ll.private_viewer
execute if data entity @s data.ll_private{kind:"priest"} run tellraw @a[tag=ll.private_viewer] [{text:"[情书 · 私密] 目标留牌：",color:"light_purple"},{nbt:"target_card",storage:"love_letter:private",interpret:true}]
execute if data entity @s data.ll_private{kind:"baron"} run tellraw @a[tag=ll.private_viewer] [{text:"[情书 · 私密] 男爵比较：行动者 ",color:"light_purple"},{nbt:"actor_card",storage:"love_letter:private",interpret:true},{text:"；目标 "},{nbt:"target_card",storage:"love_letter:private",interpret:true}]
execute if data entity @s data.ll_private{kind:"king"} run tellraw @a[tag=ll.private_viewer] [{text:"[情书 · 私密] 国王交换前：行动者 ",color:"light_purple"},{nbt:"actor_card",storage:"love_letter:private",interpret:true},{text:"；目标 "},{nbt:"target_card",storage:"love_letter:private",interpret:true}]
tag @a[tag=ll.private_viewer] remove ll.private_viewer
data remove entity @s data.ll_private
data remove storage love_letter:private result
data remove storage love_letter:private actor_card
data remove storage love_letter:private target_card
''')
    rules={'type':'minecraft:notice','title':{'text':'情书 · 游戏规则','color':'gold'},'body':[],'pause':False,'can_close_with_escape':True}
    sections=[('人数与目标','2～6人，四人桌最多4人。使用21张新版角色牌；各轮赢取好感，达到目标者共同获胜。默认2人6枚、3人5枚、4人4枚、5～6人3枚。'),('回合与操作','每人起始1张，顺时针轮流摸1张、出1张并结算效果。第1格手牌物品按Q打开，点牌选择、再点取消、换牌转移亮框，再按出牌；目标和角色猜测用按钮。最后一格按Q查看菜单，可确认本轮认输。'),('牌组与保护','角色数量：0间谍2、1侍卫6、2牧师2、3男爵2、4侍女2、5王子2、6大臣2、7国王1、8伯爵夫人1、9公主1。每轮暗置1张备用；双人再公开移出3张。不能选择已淘汰或受保护者；1/2/3/7无合法他人时无效，5王子则必须选择自己。'),('计分与下一轮','仅剩1人则立即轮胜；完整回合结束牌库为空，存活玩家比留牌，最高同值者均获1枚，不以弃牌和破平。唯一存活且曾出/弃过间谍者额外1枚。间谍奖励不算轮胜；本轮胜者先手，并列从胜者中随机。'),('边界与恢复','王子遇空牌库使用暗置备用，弃公主不补牌；大臣最多摸2张，保留1张、余牌自行排序回牌库底，不使用备用牌。伯爵夫人与王子/国王同手必须打出，但大臣临时选牌不受此限制。时限到期自动合法完成当前回合。普通玩家无需管理员，重载保留手牌与阶段，旧窗口按Q重开；离线或离桌中止整场。')]
    sections += [(f'{i} · {name}',effect) for i,(name,effect) in enumerate(zip(ROLES,EFFECTS))]
    for title,text in sections:
        rules['body'].append({'type':'minecraft:plain_message','width':480,'contents':[{'text':title+'\n','color':'aqua','bold':True},{'text':text,'color':'white'}]})
    put('rules/show','dialog show @a[tag=ct.rules_actor,limit=1] '+js(rules))
    put('rules/player','dialog show @s '+js(rules))
    from build_love_letter_settings import build as build_settings
    build_settings()


if __name__ == '__main__':
    build()
