# -*- coding: utf-8 -*-
"""掼蛋的私人实卡多选、明确牌型解释、贡还牌及普通玩家 Q 操作。"""
from pathlib import Path
import json

PACK=Path(__file__).resolve().parents[1]
ROOT=PACK/'data/guandan/function'
OBJECTIVES={n:'dummy' for n in 'gd_seen gd_uiepoch gd_ui_load gd_ui_tmp gd_ui_key'.split()}
OBJECTIVES.update({'gd_action':'trigger','gd_drop':'minecraft.dropped:minecraft.purple_dye'})
SUITS='cdhs'
RANKS=[str(n) for n in range(2,11)]+['j','q','k','a']
NAMES=[s+'_'+r for s in SUITS for r in RANKS]+['j_2','j_1']
KINDS=['','单张','对子','三张','三带二','三连对','钢板','顺子','炸弹','同花顺','四王炸']


def js(v):return json.dumps(v,ensure_ascii=False,separators=(',',':'))


def put(name,body):
    path=ROOT/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(('\n'.join(body) if isinstance(body,list) else body).strip()+'\n',encoding='utf8')


def build():
    put('name/resolve','''
data modify storage guandan:name resolved set value {text:"未知玩家"}
kill @e[type=minecraft:item_display,tag=gd.name_resolver,distance=..1,limit=1]
summon minecraft:item_display ~ ~ ~ {Tags:["gd.name_resolver"],view_range:0f,item:{id:"minecraft:paper"}}
loot replace entity @e[type=minecraft:item_display,tag=gd.name_resolver,distance=..1,sort=nearest,limit=1] contents loot guandan:player_name
data modify storage guandan:name resolved set from entity @e[type=minecraft:item_display,tag=gd.name_resolver,distance=..1,sort=nearest,limit=1] item.components."minecraft:custom_name"
data remove storage guandan:name resolved.click_event
data remove storage guandan:name resolved.hover_event
data remove storage guandan:name resolved.insertion
kill @e[type=minecraft:item_display,tag=gd.name_resolver,distance=..1,sort=nearest,limit=1]
''')
    loot={'pools':[{'rolls':1,'entries':[{'type':'minecraft:item','name':'minecraft:paper','functions':[{'function':'minecraft:set_name','entity':'this','name':{'selector':'@s'}}]}]}]}
    path=PACK/'data/guandan/loot_table/player_name.json';path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(json.dumps(loot,ensure_ascii=False,indent=2)+'\n',encoding='utf8')
    put('input/give','clear @s *[minecraft:custom_data~{guandan:{tool:1b}}]\nexecute store result storage guandan:input table int 1 run scoreboard players get @s gd_table\nfunction guandan:input/give_tools with storage guandan:input')
    put('input/give_tools','''
$function guandan:input/place_tool {table:$(table),slot:0,action:0,name:"掼蛋 · 手牌",model:"card:poker/back"}
$function guandan:input/place_tool {table:$(table),slot:8,action:8,name:"掼蛋 · 对局菜单",model:"minecraft:book"}
''')
    put('input/place_tool','''
$execute unless items entity @s hotbar.$(slot) * run return run item replace entity @s hotbar.$(slot) with minecraft:purple_dye[minecraft:item_name="$(name)",minecraft:item_model="$(model)",minecraft:custom_data={guandan:{tool:1b,action:$(action),table:$(table)}},minecraft:max_stack_size=1]
$give @s minecraft:purple_dye[minecraft:item_name="$(name)",minecraft:item_model="$(model)",minecraft:custom_data={guandan:{tool:1b,action:$(action),table:$(table)}},minecraft:max_stack_size=1]
''')
    put('input/tick','''
execute as @a[tag=gd.player,scores={gd_drop=1..}] at @s run function guandan:input/drop
execute as @a[tag=gd.player,scores={gd_action=1..}] at @s run function guandan:input/submit
execute as @a[scores={gd_settings=1..}] at @s run function guandan:settings/save
''')
    put('input/drop','''
scoreboard players set @s gd_drop 0
tag @a[tag=gd.dropper] remove gd.dropper
tag @s add gd.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents *[minecraft:custom_data~{guandan:{tool:1b}}] run function guandan:input/check_drop
tag @a[tag=gd.dropper] remove gd.dropper
''')
    put('input/check_drop','''
scoreboard players set #drop_owner gd_ctx 0
execute on origin if entity @s[tag=gd.dropper,tag=gd.player] run scoreboard players set #drop_owner gd_ctx 1
execute unless score #drop_owner gd_ctx matches 1 run return 0
execute store result score #tool_action gd_ctx run data get entity @s Item.components."minecraft:custom_data".guandan.action
execute store result score #tool_table gd_ctx run data get entity @s Item.components."minecraft:custom_data".guandan.table
kill @s
execute unless score @a[tag=gd.dropper,limit=1] gd_table = #tool_table gd_ctx run return 0
execute as @a[tag=gd.dropper,limit=1] run function guandan:input/give
execute if score #tool_action gd_ctx matches 8 as @a[tag=gd.dropper,limit=1] at @s run return run function guandan:ui/menu
execute as @a[tag=gd.dropper,limit=1] at @s run function guandan:ui/open
''')
    put('input/context','''
tag @a[tag=gd.actor] remove gd.actor
tag @e[tag=gd.me] remove gd.me
tag @e[tag=gd.current] remove gd.current
execute unless entity @s[tag=ct.player,tag=gd.player] run return 0
execute unless score @s ct_id = @s gd_table run return 0
scoreboard players operation #ui_table gd_ctx = @s gd_table
scoreboard players operation #ui_seat gd_ctx = @s gd_seat
execute as @e[type=minecraft:marker,tag=ct.controller,tag=gd.controller,scores={ct_game=18,ct_state=1,gd_state=1..5}] if score @s ct_id = #ui_table gd_ctx run tag @s add gd.current
execute unless entity @e[tag=gd.current,limit=1] run return 0
execute as @e[tag=gd.current,limit=1] at @s run function guandan:system/context
execute as @e[tag=gd.board] if score @s gd_seat = #ui_seat gd_ctx run tag @s add gd.me
execute unless entity @e[tag=gd.me,limit=1] run return 0
tag @s add gd.actor
scoreboard players operation #actor gd_ctx = @s gd_seat
''')
    put('input/invalid','tellraw @s {text:"[掼蛋] 这个操作已过期或当前不可用，请按Q重新打开。",color:"yellow"}')
    put('input/submit','''
scoreboard players operation @s gd_ui_tmp = @s gd_action
scoreboard players set @s gd_action 0
scoreboard players enable @s gd_action
function guandan:input/context
execute unless entity @s[tag=gd.actor] run return run function guandan:input/invalid
execute unless score @s gd_ui_load = #ui_load gd_ctx run return run function guandan:input/invalid
execute unless score @s gd_uiepoch = @e[tag=gd.current,limit=1] gd_epoch run return run function guandan:input/invalid
scoreboard players set #ui_factor gd_ctx 10000
scoreboard players operation #ui_nonce gd_ctx = @s gd_ui_tmp
scoreboard players operation #ui_nonce gd_ctx /= #ui_factor gd_ctx
execute unless score #ui_nonce gd_ctx = @s gd_seen run return run function guandan:input/invalid
scoreboard players operation #ui_action gd_ctx = @s gd_ui_tmp
scoreboard players operation #ui_action gd_ctx %= #ui_factor gd_ctx
execute if score #ui_action gd_ctx matches 1 run return run function guandan:ui/open
execute if score #ui_action gd_ctx matches 2 run return run function guandan:ui/menu
execute if score #ui_action gd_ctx matches 3 run return run function guandan:rules/player
execute if score #ui_action gd_ctx matches 20 run return run function guandan:input/play
execute if score #ui_action gd_ctx matches 21 run return run function guandan:input/pass
execute if score #ui_action gd_ctx matches 22 run return run function guandan:input/deselect
execute if score #ui_action gd_ctx matches 23 run return run function guandan:input/tribute
execute if score #ui_action gd_ctx matches 100..207 run return run function guandan:input/select
execute if score #ui_action gd_ctx matches 1000..8999 run return run function guandan:input/choose
function guandan:input/invalid
''')
    put('input/select','''
execute unless entity @e[tag=gd.current,scores={gd_state=2..3,gd_anim=0},limit=1] run return run function guandan:input/invalid
execute unless entity @e[tag=gd.me,scores={gd_rank=0},limit=1] run return run function guandan:input/invalid
scoreboard players operation #ui_id gd_ctx = #ui_action gd_ctx
scoreboard players remove #ui_id gd_ctx 100
tag @e[tag=gd.clicked] remove gd.clicked
execute as @e[tag=gd.cards] if score @s gd_owner = #ui_seat gd_ctx if score @s gd_id = #ui_id gd_ctx run tag @s add gd.clicked
execute unless entity @e[tag=gd.clicked,limit=1] run return run function guandan:input/invalid
execute if entity @e[tag=gd.clicked,scores={gd_sel=1},limit=1] run return run function guandan:input/unselect_one
execute if entity @e[tag=gd.current,scores={gd_state=2},limit=1] run function guandan:input/clear_selected
scoreboard players set @e[tag=gd.clicked,limit=1] gd_sel 1
tag @e[tag=gd.clicked,limit=1] add gd.selected
tag @e[tag=gd.clicked] remove gd.clicked
function guandan:ui/open
''')
    put('input/unselect_one','scoreboard players set @e[tag=gd.clicked,limit=1] gd_sel 0\ntag @e[tag=gd.clicked] remove gd.selected\ntag @e[tag=gd.clicked] remove gd.clicked\nfunction guandan:ui/open')
    put('input/clear_selected','execute as @e[tag=gd.cards] if score @s gd_owner = #ui_seat gd_ctx run scoreboard players set @s gd_sel 0\nexecute as @e[tag=gd.cards] if score @s gd_owner = #ui_seat gd_ctx run tag @s remove gd.selected')
    put('input/deselect','function guandan:input/clear_selected\nfunction guandan:ui/open')
    put('input/play','''
execute unless entity @e[tag=gd.current,scores={gd_state=3,gd_anim=0},limit=1] run return run function guandan:input/invalid
execute unless score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run return run function guandan:input/invalid
scoreboard players set #ok gd_ctx 0
scoreboard players set #options gd_ctx 0
execute as @e[tag=gd.current,limit=1] at @s run function guandan:game/play
execute if score #options gd_ctx matches 2.. run return run function guandan:ui/interpret
execute if score #ok gd_ctx matches 1 run return run dialog clear @s
function guandan:input/invalid
''')
    put('input/choose','''
execute unless entity @e[tag=gd.current,scores={gd_state=3,gd_anim=0},limit=1] run return run function guandan:input/invalid
execute unless score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run return run function guandan:input/invalid
scoreboard players operation #choice gd_ctx = #ui_action gd_ctx
scoreboard players remove #choice gd_ctx 1000
scoreboard players set #ok gd_ctx 0
execute as @e[tag=gd.current,limit=1] at @s run function guandan:game/submit
execute if score #ok gd_ctx matches 1 run return run dialog clear @s
function guandan:input/invalid
''')
    put('input/play',(ROOT/'input/play.mcfunction').read_text(encoding='utf8').rstrip()+'\nfunction guandan:ui/open')
    put('input/pass','''
scoreboard players set #ok gd_ctx 0
execute as @e[tag=gd.current,limit=1] at @s run function guandan:game/pass
execute if score #ok gd_ctx matches 1 run return run dialog clear @s
function guandan:input/invalid
''')
    put('input/tribute','''
execute unless entity @e[tag=gd.current,scores={gd_state=2,gd_anim=0},limit=1] run return run function guandan:input/invalid
scoreboard players set #ui_selected gd_ctx 0
scoreboard players set #card gd_ctx -1
execute as @e[tag=gd.cards,scores={gd_sel=1}] if score @s gd_owner = #ui_seat gd_ctx run function guandan:input/selected_card
execute unless score #ui_selected gd_ctx matches 1 run return run function guandan:input/invalid
scoreboard players set #ok gd_ctx 0
execute as @e[tag=gd.current,limit=1] at @s run function guandan:tribute/submit
execute if score #ok gd_ctx matches 1 run return run dialog clear @s
function guandan:input/invalid
''')
    put('input/selected_card','scoreboard players add #ui_selected gd_ctx 1\nscoreboard players operation #card gd_ctx = @s gd_id')
    put('input/clear','\n'.join('scoreboard players reset @s '+name for name in OBJECTIVES)+'\nclear @s *[minecraft:custom_data~{guandan:{tool:1b}}]\ntag @s remove gd.actor')
    put('ui/begin','''
# 每次重画更换独立 nonce；旧选择窗即使同一回合也不能重放。
scoreboard players add #ui_serial gd_ctx 1
execute if score #ui_serial gd_ctx matches 200001.. run scoreboard players add #ui_load gd_ctx 1
execute if score #ui_serial gd_ctx matches 200001.. run scoreboard players set #ui_serial gd_ctx 1
scoreboard players operation @s gd_seen = #ui_serial gd_ctx
scoreboard players operation @s gd_uiepoch = @e[tag=gd.current,limit=1] gd_epoch
scoreboard players operation @s gd_ui_load = #ui_load gd_ctx
scoreboard players operation #ui_base gd_ctx = #ui_serial gd_ctx
scoreboard players set #ui_factor gd_ctx 10000
scoreboard players operation #ui_base gd_ctx *= #ui_factor gd_ctx
scoreboard players set @s gd_action 0
scoreboard players enable @s gd_action
data modify storage guandan:ui buttons set value []
data modify storage guandan:ui rows set value {text:"",extra:[]}
data modify storage guandan:ui phase set value {text:"等待出牌。",color:"gray"}
data modify storage guandan:ui info set value {text:"",extra:[]}
data modify storage guandan:ui grid set value {text:"",shadow_color:0,extra:[]}
data modify storage guandan:ui cards0 set value {text:"",shadow_color:0,extra:[]}
data modify storage guandan:ui cards1 set value {text:"",shadow_color:0,extra:[]}
data modify storage guandan:ui cards2 set value {text:"",shadow_color:0,extra:[]}
data modify storage guandan:ui title set value "掼蛋 · 手牌"
''')
    put('ui/refresh','''
# 控制器入口；状态更迭只使旧输入失效，不给其他玩家强制弹窗。
function guandan:system/context
scoreboard players set @a[tag=gd.audience] gd_action 0
scoreboard players enable @a[tag=gd.audience] gd_action
function guandan:hud/refresh
''')
    put('ui/open','''
function guandan:input/context
execute unless entity @s[tag=gd.actor] run return 0
function guandan:ui/begin
function guandan:ui/players
function guandan:ui/hand
function guandan:ui/status
function guandan:ui/last_play
execute if entity @e[tag=gd.current,scores={gd_state=3,gd_anim=0},limit=1] if score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run function guandan:ui/play_buttons
execute if entity @e[tag=gd.current,scores={gd_state=2,gd_anim=0},limit=1] run function guandan:ui/tribute_buttons
function guandan:ui/button {code:22,label:"取消所选",color:"gray"}
function guandan:ui/button {code:2,label:"对局菜单",color:"gray"}
function guandan:hud/update
function guandan:ui/normalize
function guandan:ui/hand_show with storage guandan:ui
''')
    put('ui/last_play','data modify storage guandan:ui last_play set value {text:"还没有出牌，或等待重新领出。",color:"gray"}\nexecute if score @e[tag=gd.current,limit=1] gd_lastkind matches 1.. run data modify storage guandan:ui last_play set value {text:"",extra:[]}\nscoreboard players operation #ui_lastseat gd_ctx = @e[tag=gd.current,limit=1] gd_lastseat\nexecute if score @e[tag=gd.current,limit=1] gd_lastkind matches 1.. as @e[tag=gd.board] if score @s gd_seat = #ui_lastseat gd_ctx run function guandan:ui/last_play_owner\n')
    put('ui/last_play_owner','data modify storage guandan:ui last_play.extra append from entity @s data.gd_name\ndata modify storage guandan:ui last_play.extra append value {text:"："}\ndata modify storage guandan:ui last_play.extra append from entity @s data.last_label\n')
    put('ui/hand_show','$dialog show @s {"type":"minecraft:multi_action","title":{"text":"掼蛋 · 手牌","color":"gold"},"body":[{"type":"minecraft:plain_message","width":440,"contents":$(phase)},{"type":"minecraft:plain_message","width":440,"contents":[{"text":"上一手：","color":"gray"},$(last_play)]},{"type":"minecraft:plain_message","width":440,"contents":$(info)},{"type":"minecraft:plain_message","width":440,"contents":{"text":"从大到小排列，同点数上下堆叠；点击露出的牌面选中／取消，金边表示选中，★表示级牌（红桃级牌为逢人配）。","color":"gray"}},{"type":"minecraft:plain_message","width":690,"contents":$(grid)}],"columns":4,"actions":$(buttons),"exit_action":{"label":{"text":"返回游戏（保留选择）"}},"pause":false,"can_close_with_escape":true,"after_action":"close"}\n')
    put('ui/hand','''
tag @e[tag=gd.uicards] remove gd.uicards
execute as @e[tag=gd.cards] if score @s gd_owner = #ui_seat gd_ctx run tag @s add gd.uicards
execute as @e[tag=gd.uicards] run function guandan:ui/card_key
data modify storage guandan:ui stack_columns set value []
scoreboard players set #ui_previous gd_ctx -1
scoreboard players set #ui_depth gd_ctx 0
scoreboard players set #ui_maxdepth gd_ctx 0
function guandan:ui/next_card
tag @e[tag=gd.uicards] remove gd.uicards
function guandan:ui/grid
''')
    put('ui/card_key','scoreboard players operation @s gd_ui_key = @s gd_strength\nscoreboard players set #ui_key_factor gd_ctx 108\nscoreboard players operation @s gd_ui_key *= #ui_key_factor gd_ctx\nscoreboard players operation @s gd_ui_key += @s gd_id')
    put('ui/next_card','''
execute unless entity @e[tag=gd.uicards] run return 0
scoreboard players set #ui_max gd_ctx -1
execute as @e[tag=gd.uicards] run scoreboard players operation #ui_max gd_ctx > @s gd_ui_key
execute as @e[tag=gd.uicards] if score @s gd_ui_key = #ui_max gd_ctx run function guandan:ui/card
function guandan:ui/next_card
''')
    put('ui/card','''
execute unless score @s gd_strength = #ui_previous gd_ctx run data modify storage guandan:ui stack_columns append value {cards:[]}
execute unless score @s gd_strength = #ui_previous gd_ctx run scoreboard players set #ui_depth gd_ctx 0
scoreboard players operation #ui_type gd_ctx = @s gd_type
function guandan:ui/type
execute if score @s gd_point = @e[tag=gd.current,limit=1] gd_level run data modify storage guandan:ui slices set from storage guandan:ui wild_slices
execute if score @s gd_sel matches 1 run data modify storage guandan:ui slices set from storage guandan:ui selected_slices
execute if score @s gd_sel matches 1 if score @s gd_point = @e[tag=gd.current,limit=1] gd_level run data modify storage guandan:ui slices set from storage guandan:ui selected_wild_slices
scoreboard players operation #ui_code gd_ctx = @s gd_id
scoreboard players add #ui_code gd_ctx 100
scoreboard players operation #ui_code gd_ctx += #ui_base gd_ctx
execute store result storage guandan:ui card_code int 1 run scoreboard players get #ui_code gd_ctx
function guandan:ui/card_append with storage guandan:ui
tag @s remove gd.uicards
scoreboard players add #ui_depth gd_ctx 1
scoreboard players operation #ui_maxdepth gd_ctx > #ui_depth gd_ctx
scoreboard players operation #ui_previous gd_ctx = @s gd_strength
''')
    put('ui/card_append','$data modify storage guandan:ui stack_columns[-1].cards append value {slices:$(slices),command:"trigger gd_action set $(card_code)",name:"$(card_name)"}')
    types=[]
    for i,name in enumerate(NAMES):
        label=(['梅花','方块','红桃','黑桃'][i//13]+(str(i%13+2) if i%13<9 else ['J','Q','K','A'][i%13-9])) if i<52 else ['小王','大王'][i-52]
        item={'card_name':label}
        for variant,key in enumerate(('slices','selected_slices','wild_slices','selected_wild_slices')):
            item[key]=[chr(0xF000+variant*54*6+i*6+n) for n in range(6)]
        types.append(f'execute if score #ui_type gd_ctx matches {i} run data merge storage guandan:ui '+js(item))
    put('ui/type',types)
    # 与斗地主相同：每张54px牌切成六条9px。上层只露牌头，仍独立对应physical id。
    grid=['data modify storage guandan:ui grid set value {text:"",shadow_color:0,extra:[]}']
    for line in range(13):
        if line:grid.append(f'execute if score #ui_maxdepth gd_ctx matches {max(1,line-4)}.. run data modify storage guandan:ui grid.extra append value {{text:"\\n",font:"minecraft:default"}}')
        for col in range(15):
            grid.append(f'execute if score #ui_maxdepth gd_ctx matches {max(1,line-4)}.. run function guandan:ui/stack_cell {{column:{col},line:{line}}}')
    put('ui/grid',grid)
    put('ui/stack_cell','''
$execute unless data storage guandan:ui stack_columns[$(column)] run return 0
$execute store result score #ui_stack_count gd_ctx run data get storage guandan:ui stack_columns[$(column)].cards
$scoreboard players set #ui_stack_index gd_ctx $(line)
scoreboard players remove #ui_stack_count gd_ctx 1
scoreboard players operation #ui_stack_index gd_ctx < #ui_stack_count gd_ctx
$scoreboard players set #ui_stack_slice gd_ctx $(line)
scoreboard players operation #ui_stack_slice gd_ctx -= #ui_stack_index gd_ctx
execute if score #ui_stack_slice gd_ctx matches 6.. run return run function guandan:ui/stack_blank
$data modify storage guandan:ui stack_args set value {column:$(column)}
execute store result storage guandan:ui stack_args.index int 1 run scoreboard players get #ui_stack_index gd_ctx
execute store result storage guandan:ui stack_args.slice int 1 run scoreboard players get #ui_stack_slice gd_ctx
function guandan:ui/stack_fragment with storage guandan:ui stack_args
''')
    put('ui/stack_blank','data modify storage guandan:ui grid.extra append value {text:"'+chr(0xEBF2)+chr(0xEBF1)+'",font:"card:guandan/stack_spacing"}')
    put('ui/stack_fragment','''
data modify storage guandan:ui fragment set value {text:"",font:"card:guandan/stack",color:"white",shadow_color:0,click_event:{action:"run_command",command:""},hover_event:{action:"show_text",value:{text:""}}}
$data modify storage guandan:ui fragment.text set from storage guandan:ui stack_columns[$(column)].cards[$(index)].slices[$(slice)]
$data modify storage guandan:ui fragment.click_event.command set from storage guandan:ui stack_columns[$(column)].cards[$(index)].command
$data modify storage guandan:ui fragment.hover_event.value.text set from storage guandan:ui stack_columns[$(column)].cards[$(index)].name
data modify storage guandan:ui grid.extra append from storage guandan:ui fragment
data modify storage guandan:ui grid.extra append value {text:"'''+chr(0xEBF1)+'''",font:"card:guandan/stack_spacing"}
''')
    put('ui/play_buttons','function guandan:ui/button {code:20,label:"出牌",color:"green"}\nexecute unless score @e[tag=gd.current,limit=1] gd_lastkind matches 0 run function guandan:ui/button {code:21,label:"不出",color:"yellow"}')
    put('ui/tribute_buttons','''
execute if entity @e[tag=gd.current,scores={gd_phase=1},limit=1] if entity @e[tag=gd.me,scores={gd_tribute=1},limit=1] run function guandan:ui/button {code:23,label:"确定贡牌",color:"green"}
execute if entity @e[tag=gd.current,scores={gd_phase=2},limit=1] if entity @e[tag=gd.me,scores={gd_return=1},limit=1] run function guandan:ui/button {code:23,label:"确定还牌",color:"green"}
''')
    put('ui/status','''
data modify storage guandan:ui level set value "2"
'''+ '\n'.join(f'execute if score @e[tag=gd.current,limit=1] gd_level matches {n} run data modify storage guandan:ui level set value "{str(n) if n<11 else {11:"J",12:"Q",13:"K",14:"A"}[n]}"' for n in range(2,15))+'''
function guandan:ui/level_info with storage guandan:ui
execute if entity @e[tag=gd.current,scores={gd_state=1},limit=1] run data modify storage guandan:ui phase set value {text:"正在发牌。",color:"gray"}
execute if entity @e[tag=gd.current,scores={gd_state=2,gd_phase=1},limit=1] run data modify storage guandan:ui phase set value {text:"贡牌：选择除逢人配外最大的牌。",color:"yellow"}
execute if entity @e[tag=gd.current,scores={gd_state=2,gd_phase=2},limit=1] run data modify storage guandan:ui phase set value {text:"还牌：选择不大于10的牌；没有时还最小牌。",color:"yellow"}
execute if entity @e[tag=gd.current,scores={gd_state=3},limit=1] if score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run data modify storage guandan:ui phase set value {text:"轮到你出牌。",color:"green"}
execute if entity @e[tag=gd.me,scores={gd_rank=1..},limit=1] run data modify storage guandan:ui phase set value {text:"你已出完手牌，等待本副结算。",color:"gold"}
execute if entity @e[tag=gd.current,scores={gd_state=4},limit=1] run data modify storage guandan:ui phase set value {text:"本副结算。",color:"gold"}
execute if entity @e[tag=gd.current,scores={gd_state=5},limit=1] run data modify storage guandan:ui phase set value {text:"整场结束。",color:"gold"}
''')
    put('ui/level_info','$data modify storage guandan:ui info set value {text:"本级 $(level) · 红桃$(level)为逢人配",color:"light_purple"}')
    put('ui/players','\n'.join(f'execute as @e[tag=gd.board,scores={{gd_order={n}}}] run function guandan:ui/player_line' for n in range(4)))
    put('ui/player_line','''
data modify storage guandan:ui line_name set value {text:"玩家"}
data modify storage guandan:ui line_name set from entity @s data.gd_name
execute store result storage guandan:ui line_seat int 1 run scoreboard players get @s gd_seat
execute store result storage guandan:ui line_team int 1 run scoreboard players get @s gd_team
data modify storage guandan:ui line_count set value ""
execute if entity @e[tag=gd.current,scores={gd_show=1},limit=1] run function guandan:ui/player_count
data modify storage guandan:ui line_status set value ""
execute if score @s gd_rank matches 1 run data modify storage guandan:ui line_status set value " · 头游"
execute if score @s gd_rank matches 2 run data modify storage guandan:ui line_status set value " · 二游"
execute if score @s gd_rank matches 3 run data modify storage guandan:ui line_status set value " · 三游"
execute if score @s gd_rank matches 4 run data modify storage guandan:ui line_status set value " · 末游"
execute if score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn if score @e[tag=gd.current,limit=1] gd_state matches 3 run data modify storage guandan:ui line_status set value " ▶"
function guandan:ui/player_append with storage guandan:ui
''')
    put('ui/player_count','execute store result storage guandan:ui count int 1 run scoreboard players get @s gd_count\nfunction guandan:ui/player_count_text with storage guandan:ui')
    put('ui/player_count_text','$data modify storage guandan:ui line_count set value " · $(count)张"')
    put('ui/player_append','$data modify storage guandan:ui rows.extra append value {text:"",extra:[{text:"$(line_seat)号位 ",color:"gray"},$(line_name),{text:" · 队$(line_team)$(line_count)$(line_status)\\n",color:"gray"}]}')
    put('ui/button','''
$scoreboard players set #ui_code gd_ctx $(code)
scoreboard players operation #ui_code gd_ctx += #ui_base gd_ctx
execute store result storage guandan:ui code int 1 run scoreboard players get #ui_code gd_ctx
$data modify storage guandan:ui label set value {text:"$(label)",color:"$(color)"}
function guandan:ui/button_append with storage guandan:ui
''')
    put('ui/button_append','$data modify storage guandan:ui buttons append value {label:$(label),width:70,action:{type:"minecraft:run_command",command:"trigger gd_action set $(code)"}}')
    put('ui/menu','''
function guandan:input/context
execute unless entity @s[tag=gd.actor] run return 0
function guandan:ui/begin
data modify storage guandan:ui title set value "掼蛋 · 对局菜单"
data modify storage guandan:ui phase set value {text:"",color:"gray"}
function guandan:ui/players
function guandan:ui/button {code:1,label:"手牌与贡还牌",color:"green"}
function guandan:ui/button {code:3,label:"查看规则",color:"aqua"}
function guandan:ui/normalize
function guandan:ui/show with storage guandan:ui
''')
    put('ui/interpret','''
function guandan:input/context
execute unless entity @s[tag=gd.actor] run return 0
function guandan:ui/begin
data modify storage guandan:ui title set value "掼蛋 · 选择牌型"
data modify storage guandan:ui phase set value {text:"选择本次出牌的牌型与比较点数。",color:"yellow"}
data modify storage guandan:ui options set from entity @e[tag=gd.current,limit=1] data.guandan.options
scoreboard players set #ui_option gd_ctx 0
function guandan:ui/option_next
function guandan:ui/button {code:1,label:"返回手牌",color:"gray"}
function guandan:ui/normalize
function guandan:ui/show with storage guandan:ui
''')
    put('ui/option_next','''
execute unless data storage guandan:ui options[0] run return 0
data modify storage guandan:ui option set from storage guandan:ui options[0]
data remove storage guandan:ui options[0]
function guandan:ui/option with storage guandan:ui option
scoreboard players add #ui_option gd_ctx 1
function guandan:ui/option_next
''')
    put('ui/option','''
data modify storage guandan:ui option_label set from storage guandan:ui option.label
scoreboard players operation #ui_code gd_ctx = #ui_option gd_ctx
scoreboard players add #ui_code gd_ctx 1000
scoreboard players operation #ui_code gd_ctx += #ui_base gd_ctx
execute store result storage guandan:ui option_code int 1 run scoreboard players get #ui_code gd_ctx
data modify storage guandan:ui option_color set value "green"
execute unless data storage guandan:ui option{beat:1} run data modify storage guandan:ui option_color set value "dark_gray"
function guandan:ui/option_append with storage guandan:ui
''')
    high=['execute store result storage guandan:ui option_high int 1 run scoreboard players get #ui_high gd_ctx']
    for n,label in [(1,'A（低）'),(11,'J'),(12,'Q'),(13,'K'),(14,'A')]:high.append(f'execute if score #ui_high gd_ctx matches {n} run data modify storage guandan:ui option_high set value "{label}"')
    for n,label in [(15,'级牌'),(16,'小王'),(17,'大王')]:high.append(f'execute if score #ui_high gd_ctx matches {n} run data modify storage guandan:ui option_high set value "{label}"')
    put('ui/high_label',high)
    put('ui/option_append','''
$data modify storage guandan:ui option_button set value {label:{text:"$(option_label)",color:"$(option_color)"},width:220}
execute if data storage guandan:ui option{beat:1} run function guandan:ui/option_command with storage guandan:ui
data modify storage guandan:ui buttons append from storage guandan:ui option_button
''')
    put('ui/option_command','$data modify storage guandan:ui option_button.action set value {type:"minecraft:run_command",command:"trigger gd_action set $(option_code)"}')
    dialog={'type':'minecraft:multi_action','title':{'text':'$(title)','color':'gold'},'body':[{'type':'minecraft:plain_message','width':690 if key=='grid' else 480,'contents':'__'+key+'__'} for key in ['phase','rows','info','grid']], 'actions':'__buttons__','columns':2,'exit_action':{'label':{'text':'返回游戏'}},'pause':False,'can_close_with_escape':True,'after_action':'none'}
    text=js(dialog)
    for key in ['phase','rows','info','grid','buttons']:text=text.replace('"__'+key+'__"','$('+key+')')
    put('ui/normalize','\n'.join(f'execute unless data storage guandan:ui {key}.extra[0] run data remove storage guandan:ui {key}.extra' for key in ['phase','rows','info','grid']))
    put('ui/show','$dialog show @s '+text)
    sections=[('人数与目标','4名真人，两副扑克共108张，每人27张。对家为搭档；四人桌与八人桌均只打四方。按逆时针轮流出牌，先出完为头游。'),('选牌与操作','第1格手牌物品按Q打开，点击实卡多选、再点取消，选好点击出牌；成功出牌立刻关闭窗口。最后一格按Q打开对局菜单。贡还阶段选择一张牌再确定。普通玩家无需管理员。'),('级牌与逢人配','从设定级数开始。大王>小王>级牌>A>K>…>2；顺子、三连对、钢板按自然连续点数比较，A级可作A2345或10JQKA。红桃级牌为逢人配，可代替除大小王之外的牌，参与多种解释时自行选择牌型。'),('合法牌型','单张、对子、三张、三带二、连续三对、连续两组三张、五张顺子、四张及以上同点炸弹、五张同花顺、两大王加两小王。三带二可带自然王对；逢人配不能配王。普通5张天然同花仅作同花顺。'),('压制与接风','普通牌须牌型与张数相同且点数更大；炸弹依张数与点数比较，同花顺大于五炸小于六炸，四王最大。可自愿不出；无人跟牌后，由上手重新领出，上手已出完则由其搭档接风。'),('升级与贡还','头游与二游同队升3级，与三游同队升2级，与末游同队升1级。单下末游向头游进贡；双下败方两人分别进贡；符合双大王条件自动抗贡。贡除逢人配外的最大牌，受贡方还不大于10的牌，没有时还最小牌。'),('胜负与恢复','完整升级赛须打过A，固定副数则比较最终级数及副胜。可设置行动时限，超时由系统完成合法操作。重载保留手牌与贡还阶段；离桌或离线中止整场，旧窗口按Q重开。')]
    rule={'type':'minecraft:notice','title':{'text':'掼蛋 · 游戏规则','color':'gold'},'body':[{'type':'minecraft:plain_message','width':480,'contents':[{'text':title+'\n','color':'aqua','bold':True},{'text':text,'color':'white'}]} for title,text in sections],'pause':False,'can_close_with_escape':True}
    put('rules/show','dialog show @a[tag=ct.rules_actor,limit=1] '+js(rule))
    put('rules/player','dialog show @s '+js(rule))
    from build_guandan_settings import build as settings
    settings()


if __name__=='__main__':build(); __import__("build_guandan_layout").build_layout()

if __name__ == '__main__': __import__('build_turn_tools').build()
