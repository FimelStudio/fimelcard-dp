# -*- coding: utf-8 -*-
"""围棋只用一个棋盘interaction；点击时复用五子棋的有界二分射线。"""
from pathlib import Path
import json

PACK=Path(__file__).resolve().parents[1]
ROOT=PACK/'data/weiqi/function'
OBJECTIVES={name:'dummy' for name in ['go_ui_tmp','go_seen','go_ui_serial','go_ui_table','go_ui_load','go_coordnonce','go_coordepoch','go_coordload','go_coordtable','go_revelig','go_reviewtable','go_view']}
OBJECTIVES.update(go_action='trigger',go_coord='trigger',go_drop='minecraft.dropped:minecraft.paper')

def build(root=ROOT):
 def put(name,text):
  path=root/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True);path.write_text(text.strip()+'\n',encoding='utf8')
 put('input/give','''
# 最后一格只放一个菜单；不覆盖玩家已有物品。
clear @s minecraft:paper[minecraft:custom_data~{weiqi:{tool:1b}}]
execute store result storage weiqi:input table int 1 run scoreboard players get @s go_table
function weiqi:input/give_tool with storage weiqi:input
''')
 tool='minecraft:paper[minecraft:item_name="围棋 · 对局菜单",minecraft:item_model="minecraft:book",minecraft:custom_data={weiqi:{tool:1b,table:$(table)}},minecraft:max_stack_size=1]'
 put('input/give_tool','$execute unless items entity @s hotbar.8 * run return run item replace entity @s hotbar.8 with '+tool+'\n$give @s '+tool)
 put('input/clear','clear @s minecraft:paper[minecraft:custom_data~{weiqi:{tool:1b}}]\n'+'\n'.join('scoreboard players reset @s '+name for name in OBJECTIVES)+'\nfunction weiqi:settings/clear_session\ntag @s remove go.actor\ntag @s remove go.dropper')
 put('input/tick','''
execute as @e[type=minecraft:interaction,tag=go.cell] if data entity @s interaction at @s run function weiqi:input/cell
execute as @a[tag=go.player,scores={go_drop=1..}] at @s run function weiqi:input/drop
execute as @a[tag=go.player,scores={go_action=1..}] at @s run function weiqi:input/submit
execute as @a[scores={go_settings=1..}] at @s run function weiqi:settings/save
execute as @a[tag=go.player,scores={go_coord=1..}] at @s run function weiqi:input/coordinate_submit
''')
 put('input/context','''
# actor必须同时属于这张公共牌桌及围棋对局，复盘另校验原局资格。
tag @a[tag=go.actor] remove go.actor
tag @e[tag=go.current] remove go.current
execute unless entity @s[tag=ct.player,tag=go.player] run return 0
execute unless score @s ct_id = @s go_table run return 0
execute unless score @s go_side matches 1 unless score @s go_side matches -1 run return 0
scoreboard players operation #ui_table go_ctx = @s go_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=go.controller,scores={ct_game=20,ct_state=1}] if score @s ct_id = #ui_table go_ctx run tag @s add go.current
execute if score @s go_revelig matches 1 if score @s go_reviewtable = #ui_table go_ctx as @e[type=minecraft:marker,tag=ct.controller,tag=go.controller,scores={ct_game=20,ct_state=0}] if score @s ct_id = #ui_table go_ctx if data entity @s data.weiqi{review:1b} run tag @s add go.current
execute unless entity @e[tag=go.current,limit=1] run return 0
tag @s add go.actor
scoreboard players operation #actor go_ctx = @s go_side
execute as @e[tag=go.current,limit=1] at @s run function weiqi:system/context
''')
 put('input/click_dispatch','advancement revoke @s only weiqi:click_cell')
 put('input/cell','''
scoreboard players operation #ui_click_table go_ctx = @s ct_id
tag @a[tag=go.actor] remove go.actor
execute on target if entity @s[type=minecraft:player] run function weiqi:input/cell_player
data remove entity @s interaction
tag @a[tag=go.actor] remove go.actor
''')
 put('input/cell_player','''
execute unless entity @s[tag=ct.player,tag=go.player] run return 0
execute unless score @s ct_id = #ui_click_table go_ctx run return 0
execute unless score @s go_table = #ui_click_table go_ctx run return 0
function weiqi:input/context
execute unless entity @s[tag=go.actor] run return 0
execute unless entity @e[tag=go.current,scores={go_state=1},limit=1] unless entity @e[tag=go.current,scores={go_state=3},limit=1] run return 0
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] unless score @s go_side = @e[tag=go.current,limit=1] go_turn run return 0
function weiqi:input/ray
execute unless score #ray_ok go_ctx matches 1 run return 0
execute if entity @e[tag=go.current,scores={go_state=1},limit=1] as @e[tag=go.current,limit=1] at @s run function weiqi:game/click
execute if entity @e[tag=go.current,scores={go_state=3},limit=1] as @e[tag=go.current,limit=1] at @s run function weiqi:game/toggle_dead
''')
 for name in ['ray','ray_probe','ray_position','ray_bisect','ray_target','ray_clear']:
  body=(PACK/'data/gomoku/function/input'/(name+'.mcfunction')).read_text(encoding='utf8')
  put('input/'+name,body.replace('gomoku','weiqi').replace('gm.','go.').replace('gm_','go_').replace('#target','#to'))
 put('input/drop','''
scoreboard players set @s go_drop 0
tag @a[tag=go.dropper] remove go.dropper
tag @s add go.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:paper[minecraft:custom_data~{weiqi:{tool:1b}}] run function weiqi:input/check_drop
tag @s remove go.dropper
''')
 put('input/check_drop','''
scoreboard players set #ui_drop_owner go_ctx 0
execute on origin if entity @s[tag=go.dropper,tag=go.player] run scoreboard players set #ui_drop_owner go_ctx 1
execute unless score #ui_drop_owner go_ctx matches 1 run return 0
kill @s
execute as @a[tag=go.dropper,limit=1] run function weiqi:input/give
execute as @a[tag=go.dropper,limit=1] at @s run function weiqi:ui/open
''')
 put('input/invalid','tellraw @s {text:"[围棋] 窗口已过期或此时不能操作，请按Q重新打开对局菜单。",color:"yellow"}\ntag @a[tag=go.actor] remove go.actor')
 submit='''
# 面板独立nonce防同一回合重开窗口后复用旧按钮，epoch防回合/点目变化。
scoreboard players operation @s go_ui_tmp = @s go_action
scoreboard players set @s go_action 0
scoreboard players enable @s go_action
function weiqi:input/context
execute unless entity @s[tag=go.actor] run return run function weiqi:input/invalid
execute unless score @s go_ui_load = #ui_load go_ctx run return run function weiqi:input/invalid
execute unless score @s go_ui_table = @s go_table run return run function weiqi:input/invalid
execute unless score @s go_seen = @e[tag=go.current,limit=1] go_epoch run return run function weiqi:input/invalid
scoreboard players set #ui_factor go_ctx 10000
scoreboard players operation #ui_serial go_ctx = @s go_ui_tmp
scoreboard players operation #ui_serial go_ctx /= #ui_factor go_ctx
execute unless score #ui_serial go_ctx = @s go_ui_serial run return run function weiqi:input/invalid
scoreboard players operation #ui_action go_ctx = @s go_ui_tmp
scoreboard players operation #ui_action go_ctx %= #ui_factor go_ctx
scoreboard players set #ui_valid go_ctx 0
'''.strip().splitlines()
 calls={10:'game/pass',11:'game/estimate',20:'game/request_undo',21:'game/accept_undo',22:'game/reject_undo',30:'ui/resign',31:'game/resign',40:'game/confirm_score',41:'game/resume',50:'ui/coordinates',60:'game/review_open',61:'game/review_close',62:'game/review_prev',63:'game/review_next',64:'game/review_first',65:'game/review_last',66:'game/review_play',70:'rules/player'}
 for code in calls:submit.append(f'execute if score #ui_action go_ctx matches {code} run scoreboard players set #ui_valid go_ctx 1')
 submit+=['execute unless score #ui_valid go_ctx matches 1 run return run function weiqi:input/invalid']
 for code,call in calls.items():
  if code in (30,50,70):submit.append(f'execute if score #ui_action go_ctx matches {code} run return run function weiqi:{call}')
  else:submit.append(f'execute if score #ui_action go_ctx matches {code} as @e[tag=go.current,limit=1] at @s run function weiqi:{call}')
 submit+=['execute if entity @s[tag=go.actor] run function weiqi:ui/open','tag @a[tag=go.actor] remove go.actor'];put('input/submit','\n'.join(submit))
 coords='''
scoreboard players operation #coord_input go_ctx = @s go_coord
scoreboard players reset @s go_coord
function weiqi:input/context
execute unless entity @s[tag=go.actor] run return run function weiqi:input/invalid
execute unless score @s go_coordload = #ui_load go_ctx run return run function weiqi:input/invalid
execute unless score @s go_coordtable = @s go_table run return run function weiqi:input/invalid
execute unless score @s go_coordepoch = @e[tag=go.current,limit=1] go_epoch run return run function weiqi:input/invalid
execute unless entity @e[tag=go.current,scores={go_state=1},limit=1] run return run function weiqi:input/invalid
execute unless score @s go_side = @e[tag=go.current,limit=1] go_turn run return run function weiqi:input/invalid
execute unless score @s go_coordnonce matches 1000..9999 run return run function weiqi:input/invalid
scoreboard players set #coord_suffix go_ctx -1
'''.strip().splitlines()
 for factor in (1000,10000,100000):coords += [f'scoreboard players set #coord_factor go_ctx {factor}','scoreboard players operation #coord_nonce go_ctx = #coord_input go_ctx','scoreboard players operation #coord_nonce go_ctx /= #coord_factor go_ctx','execute if score #coord_nonce go_ctx = @s go_coordnonce run scoreboard players operation #coord_suffix go_ctx = #coord_input go_ctx','execute if score #coord_nonce go_ctx = @s go_coordnonce run scoreboard players operation #coord_suffix go_ctx %= #coord_factor go_ctx']
 coords+=['scoreboard players set @s go_coordnonce 0','scoreboard players set #to go_ctx -1']
 for row in range(1,20):
  for col in range(1,20):coords.append(f'execute if score #coord_suffix go_ctx matches {row}0{col} run scoreboard players set #to go_ctx {(row-1)*19+col-1}')
 coords+=['execute unless score #to go_ctx matches 0..360 run return run function weiqi:input/invalid','execute as @e[tag=go.current,limit=1] at @s run function weiqi:game/click','tag @a[tag=go.actor] remove go.actor'];put('input/coordinate_submit','\n'.join(coords))
 path=PACK/'data/weiqi/advancement/click_cell.json';path.parent.mkdir(parents=True,exist_ok=True)
 path.write_text(json.dumps({'criteria':{'click':{'trigger':'minecraft:player_interacted_with_entity','conditions':{'entity':[{'condition':'minecraft:entity_properties','entity':'this','predicate':{'minecraft:entity_type':'minecraft:interaction'}}]}}},'rewards':{'function':'weiqi:input/click_dispatch'}},indent=2)+'\n',encoding='utf8')

if __name__=='__main__':build();print('围棋输入和单棋盘射线已生成')
