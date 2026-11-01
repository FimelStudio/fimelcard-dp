"""飞行棋普通玩家 Q 操作、精确实体右键与对局面板。"""
from pathlib import Path
import json
ROOT=Path(__file__).resolve().parents[1]/'data/aeroplane_chess/function'

def build(root=ROOT):
 def put(name,lines):
  p=root/(name+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True)
  p.write_text(('\n'.join(lines) if isinstance(lines,list) else lines).strip()+'\n',encoding='utf-8')
 def js(v):return json.dumps(v,ensure_ascii=False,separators=(',',':'))
 put('input/give','''
clear @s minecraft:paper[minecraft:custom_data~{aeroplane_chess:{tool:1b}}]
execute store result storage aeroplane_chess:input table int 1 run scoreboard players get @s ac_table
function aeroplane_chess:input/tools with storage aeroplane_chess:input
''')
 put('input/tools','''
$function aeroplane_chess:input/place {table:$(table),slot:0,action:1,name:"飞行棋 · 投骰",model:"card:aeroplane_chess/dice"}
$function aeroplane_chess:input/place {table:$(table),slot:8,action:0,name:"飞行棋 · 对局菜单",model:"minecraft:book"}
''')
 put('input/place','''
$execute unless items entity @s hotbar.$(slot) * run return run item replace entity @s hotbar.$(slot) with minecraft:paper[minecraft:item_name="$(name)",minecraft:item_model="$(model)",minecraft:custom_data={aeroplane_chess:{tool:1b,action:$(action),table:$(table)}},minecraft:max_stack_size=1]
$give @s minecraft:paper[minecraft:item_name="$(name)",minecraft:item_model="$(model)",minecraft:custom_data={aeroplane_chess:{tool:1b,action:$(action),table:$(table)}},minecraft:max_stack_size=1]
''')
 put('input/clear',['clear @s minecraft:paper[minecraft:custom_data~{aeroplane_chess:{tool:1b}}]']+['scoreboard players reset @s ac_'+k for k in ['action','settings','drop','seen','ui_load','ui_tmp','set_table','setnonce','setepoch','nonce']]+['tag @s remove ac.actor','tag @s remove ac.dropper'])
 put('input/tick','''
execute as @e[type=minecraft:interaction,tag=ac.dice_click] if data entity @s interaction at @s run function aeroplane_chess:input/dice
execute as @e[type=minecraft:interaction,tag=ac.plane_click] if data entity @s interaction at @s run function aeroplane_chess:input/plane
execute as @a[tag=ac.player,scores={ac_drop=1..}] at @s run function aeroplane_chess:input/drop
execute as @a[tag=ac.player,scores={ac_action=1..}] at @s run function aeroplane_chess:input/submit
execute as @a[scores={ac_settings=1..}] at @s run function aeroplane_chess:settings/save
''')
 put('input/context','''
tag @a[tag=ac.actor] remove ac.actor
tag @e[tag=ac.current] remove ac.current
execute unless entity @s[tag=ct.player,tag=ac.player] run return 0
execute unless score @s ct_id = @s ac_table run return 0
scoreboard players operation #ui_table ac_ctx = @s ac_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ac.controller,scores={ct_game=15,ct_state=1}] if score @s ct_id = #ui_table ac_ctx run tag @s add ac.current
execute unless entity @e[tag=ac.current,limit=1] run return 0
tag @s add ac.actor
execute as @e[tag=ac.current,limit=1] at @s run function aeroplane_chess:system/context
''')
 for kind in ('dice','plane'):
  lines=['scoreboard players operation #click_table ac_ctx = @s ct_id']
  if kind=='plane':lines+=['scoreboard players operation #click_plane ac_ctx = @s ac_plane','scoreboard players operation #click_color ac_ctx = @s ac_color']
  lines+=['tag @a[tag=ac.actor] remove ac.actor',f'execute on target if entity @s[type=minecraft:player] run function aeroplane_chess:input/{kind}_player','data remove entity @s interaction','tag @a[tag=ac.actor] remove ac.actor']
  put('input/'+kind,lines)
 guard='''
execute unless entity @s[tag=ct.player,tag=ac.player] run return 0
execute unless score @s ct_id = #click_table ac_ctx run return 0
execute unless score @s ac_table = #click_table ac_ctx run return 0
function aeroplane_chess:input/context
execute unless entity @s[tag=ac.actor] run return 0
'''
 put('input/dice_player',guard+'execute as @e[tag=ac.current,limit=1] at @s run function aeroplane_chess:game/roll')
 put('input/plane_player',guard+'''
execute unless score @s ac_color = #click_color ac_ctx run return 0
scoreboard players operation #plane ac_ctx = #click_plane ac_ctx
execute as @e[tag=ac.current,limit=1] at @s run function aeroplane_chess:game/choose
''')
 put('input/drop','''
scoreboard players set @s ac_drop 0
tag @a[tag=ac.dropper] remove ac.dropper
tag @s add ac.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:paper[minecraft:custom_data~{aeroplane_chess:{tool:1b}}] run function aeroplane_chess:input/check_drop
tag @s remove ac.dropper
''')
 put('input/check_drop','''
scoreboard players set #owner ac_ctx 0
execute on origin if entity @s[tag=ac.dropper,tag=ac.player] run scoreboard players set #owner ac_ctx 1
execute unless score #owner ac_ctx matches 1 run return 0
execute store result score #tool ac_ctx run data get entity @s Item.components."minecraft:custom_data".aeroplane_chess.action
execute store result score #tool_table ac_ctx run data get entity @s Item.components."minecraft:custom_data".aeroplane_chess.table
kill @s
execute unless score @a[tag=ac.dropper,limit=1] ac_table = #tool_table ac_ctx run return 0
execute as @a[tag=ac.dropper,limit=1] run function aeroplane_chess:input/give
execute as @a[tag=ac.dropper,limit=1] at @s run function aeroplane_chess:input/tool_use
''')
 put('input/tool_use','''
function aeroplane_chess:input/context
execute unless entity @s[tag=ac.actor] run return 0
execute if score #tool ac_ctx matches 1 as @e[tag=ac.current,limit=1] at @s run function aeroplane_chess:game/roll
execute if score #tool ac_ctx matches 0 run function aeroplane_chess:ui/quick
''')
 put('input/invalid','tellraw @s {text:"[飞行棋] 窗口已过期，请按 Q 重新打开。",color:"yellow"}')
 put('input/submit','''
scoreboard players operation @s ac_ui_tmp = @s ac_action
scoreboard players set @s ac_action 0
scoreboard players enable @s ac_action
function aeroplane_chess:input/context
execute unless entity @s[tag=ac.actor] run return run function aeroplane_chess:input/invalid
execute unless score @s ac_ui_load = #ui_load ac_ctx run return run function aeroplane_chess:input/invalid
scoreboard players operation #ui_epoch ac_ctx = @s ac_ui_tmp
scoreboard players operation #ui_epoch ac_ctx /= #hundred ac_ctx
execute unless score #ui_epoch ac_ctx = @s ac_seen run return run function aeroplane_chess:input/invalid
execute unless score #ui_epoch ac_ctx = @e[tag=ac.current,limit=1] ac_epoch run return run function aeroplane_chess:input/invalid
scoreboard players operation #ui_action ac_ctx = @s ac_ui_tmp
scoreboard players operation #ui_action ac_ctx %= #hundred ac_ctx
execute unless score #ui_action ac_ctx matches 1..8 run return run function aeroplane_chess:input/invalid
execute if score #ui_action ac_ctx matches 1 as @e[tag=ac.current,limit=1] at @s run function aeroplane_chess:game/roll
execute if score #ui_action ac_ctx matches 2..5 run function aeroplane_chess:input/submit_plane
execute if score #ui_action ac_ctx matches 6 run function aeroplane_chess:ui/resign
execute if score #ui_action ac_ctx matches 7 as @e[tag=ac.current,limit=1] at @s run function aeroplane_chess:game/resign
execute if score #ui_action ac_ctx matches 8 run function aeroplane_chess:ui/quick
''')
 put('input/submit_plane','''
scoreboard players operation #plane ac_ctx = #ui_action ac_ctx
scoreboard players remove #plane ac_ctx 2
execute as @e[tag=ac.current,limit=1] at @s run function aeroplane_chess:game/choose
dialog clear @s
''')
 put('ui/refresh','''
function aeroplane_chess:system/context
scoreboard players set @a[tag=ac.audience] ac_action 0
scoreboard players enable @a[tag=ac.audience] ac_action
function aeroplane_chess:ui/board_status
''')
 put('ui/board_status','''
function aeroplane_chess:ui/color_name
data modify storage aeroplane_chess:status color set from storage aeroplane_chess:ui color
execute store result storage aeroplane_chess:status dice int 1 run scoreboard players get @s ac_roll
data modify storage aeroplane_chess:status phase set value "等待投骰"
execute if score @s ac_state matches 2 run data modify storage aeroplane_chess:status phase set value "投骰中"
execute if score @s ac_state matches 3 run data modify storage aeroplane_chess:status phase set value "选择飞机"
execute if score @s ac_state matches 4 run data modify storage aeroplane_chess:status phase set value "飞机移动中"
execute if score @s ac_state matches 6 run data modify storage aeroplane_chess:status phase set value "撞机返航中"
execute if score @s ac_state matches 5 run data modify storage aeroplane_chess:status phase set value "对局结束"
function aeroplane_chess:ui/board_status_show with storage aeroplane_chess:status
''')
 put('ui/board_status_show','$title @a[tag=ac.audience] actionbar [{text:"$(color)方",color:"gold"},{text:" · $(phase) · 骰子 $(dice)",color:"white"}]')
 put('ui/begin','''
scoreboard players operation @s ac_seen = @e[tag=ac.current,limit=1] ac_epoch
scoreboard players operation @s ac_ui_load = #ui_load ac_ctx
scoreboard players operation #ui_base ac_ctx = @s ac_seen
scoreboard players operation #ui_base ac_ctx *= #hundred ac_ctx
scoreboard players set @s ac_action 0
scoreboard players enable @s ac_action
data modify storage aeroplane_chess:ui buttons set value []
''')
 put('ui/button','''
$scoreboard players set #ui_code ac_ctx $(code)
scoreboard players operation #ui_code ac_ctx += #ui_base ac_ctx
execute store result storage aeroplane_chess:ui code int 1 run scoreboard players get #ui_code ac_ctx
$data modify storage aeroplane_chess:ui label set value "$(label)"
function aeroplane_chess:ui/append_button with storage aeroplane_chess:ui
''')
 put('ui/append_button','$data modify storage aeroplane_chess:ui buttons append value {label:{text:"$(label)"},width:180,action:{type:"minecraft:run_command",command:"trigger ac_action set $(code)"}}')
 quick='''
function aeroplane_chess:input/context
execute unless entity @s[tag=ac.actor] run return 0
function aeroplane_chess:ui/begin
data modify storage aeroplane_chess:ui status set value "等待其他玩家"
execute if score @e[tag=ac.current,limit=1] ac_state matches 2 run data modify storage aeroplane_chess:ui status set value "投骰中"
execute if score @e[tag=ac.current,limit=1] ac_state matches 4 run data modify storage aeroplane_chess:ui status set value "飞机移动中"
execute if score @e[tag=ac.current,limit=1] ac_state matches 6 run data modify storage aeroplane_chess:ui status set value "撞机返航中"
execute if score @e[tag=ac.current,limit=1] ac_state matches 5 run data modify storage aeroplane_chess:ui status set value "对局结束"
execute if score @s ac_color = @e[tag=ac.current,limit=1] ac_turn if score @e[tag=ac.current,limit=1] ac_state matches 1 run function aeroplane_chess:ui/button {code:1,label:"投骰"}
execute if score @s ac_color = @e[tag=ac.current,limit=1] ac_turn if score @e[tag=ac.current,limit=1] ac_state matches 1 run data modify storage aeroplane_chess:ui status set value "轮到你投骰"
execute if score @s ac_color = @e[tag=ac.current,limit=1] ac_turn if score @e[tag=ac.current,limit=1] ac_state matches 3 run function aeroplane_chess:ui/planes
execute if score @e[tag=ac.current,limit=1] ac_state matches 1..4 run function aeroplane_chess:ui/button {code:6,label:"认输"}
execute if score @e[tag=ac.current,limit=1] ac_state matches 6 run function aeroplane_chess:ui/button {code:6,label:"认输"}
execute store result storage aeroplane_chess:ui dice int 1 run scoreboard players get @e[tag=ac.current,limit=1] ac_roll
function aeroplane_chess:ui/color_name
execute if data storage aeroplane_chess:ui buttons[0] run return run function aeroplane_chess:ui/show with storage aeroplane_chess:ui
function aeroplane_chess:ui/notice with storage aeroplane_chess:ui
'''
 put('ui/quick',quick)
 put('ui/color_name',[f'execute if score @e[tag=ac.current,limit=1] ac_turn matches {c} run data modify storage aeroplane_chess:ui color set value "{name}"' for c,name in enumerate(['红','蓝','绿','黄'])]+[f'execute if score @e[tag=ac.current,limit=1] ac_state matches 5 if score @e[tag=ac.current,limit=1] ac_winner matches {c} run data modify storage aeroplane_chess:ui color set value "{name}"' for c,name in enumerate(['红','蓝','绿','黄'])]+[f'execute if score @s ac_color matches {c} run data modify storage aeroplane_chess:ui own set value "{name}"' for c,name in enumerate(['红','蓝','绿','黄'])])
 put('ui/planes',['data modify storage aeroplane_chess:ui status set value "选择一架飞机"','scoreboard players operation #ui_color ac_ctx = @s ac_color']+[
  f'execute as @e[tag=ac.board,scores={{ac_plane={p},ac_legal=1}}] if score @s ac_color = #ui_color ac_ctx run function aeroplane_chess:ui/button {{code:{p+2},label:"{p+1} 号飞机"}}' for p in range(4)])
 common={'title':{'text':'飞行棋 · 对局','color':'gold'},'body':[{'type':'minecraft:plain_message','width':380,'contents':{'text':'$(status)\n你：$(own)方 · 当前：$(color)方 · 骰子：$(dice)'}}],'pause':False,'can_close_with_escape':True,'after_action':'close'}
 dialog={'type':'minecraft:multi_action',**common,'actions':'__buttons__','columns':2,'exit_action':{'label':{'text':'返回游戏'},'width':140}}
 put('ui/show','$dialog show @s '+js(dialog).replace('"__buttons__"','$(buttons)'))
 dialog={'type':'minecraft:notice',**common,'action':{'label':{'text':'返回游戏'},'width':140}}
 put('ui/notice','$dialog show @s '+js(dialog))
 put('ui/resign','''
function aeroplane_chess:ui/begin
function aeroplane_chess:ui/button {code:7,label:"确认认输"}
function aeroplane_chess:ui/button {code:8,label:"返回"}
data modify storage aeroplane_chess:ui status set value "认输后本方退出当前牌局"
execute store result storage aeroplane_chess:ui dice int 1 run scoreboard players get @e[tag=ac.current,limit=1] ac_roll
function aeroplane_chess:ui/color_name
function aeroplane_chess:ui/show with storage aeroplane_chess:ui
''')
 rules={'type':'minecraft:notice','title':{'text':'飞行棋 · 规则','color':'gold'},'body':[{'type':'minecraft:plain_message','width':460,'contents':{'text':s}} for s in [
  '2～4 方，每方四架飞机。电脑补位可关闭、单人补一位或补满四方；单人开局需开启补位。红、蓝、绿、黄顺序行动，跳过停用方。',
  '默认六点起飞，本次点数只把飞机移到起飞格；也可移动已起飞飞机。六点追加投骰。',
  '飞机按点数逐格前进。落在本色格跳四格，落在航线入口可飞跃至对面；每种特殊移动每次至多触发一次。',
  '普通前进、跳格、飞跃的实际落点撞回该格所有敌机；途经格不撞机，同色可叠放。',
  '终点默认准确到达，超出的点数向后反弹。四架全部到达后获胜。规则变化见本桌设置。',
  '第 1 格按 Q 或右键骰子投骰；骰子停稳后右键飞机，或在最后一格 Q 菜单选机、认输。'
 ]],'action':{'label':{'text':'知道了'},'width':140},'pause':False,'can_close_with_escape':True}
 put('rules/open','dialog show @a[tag=ct.rules_actor,limit=1] '+js(rules))
 put('rules/show','function aeroplane_chess:rules/open')

if __name__=='__main__':build()

if __name__ == '__main__': __import__('build_turn_tools').build()
