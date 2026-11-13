# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players add @a[tag=lh.action_actor,limit=1] lh_bullets 1
scoreboard players set @a[tag=lh.action_actor,limit=1] lh_done 1
execute as @a[tag=lh.action_actor,limit=1] run function liars_holdem:util/clear_items_actions
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run tellraw @s [{selector:'@a[tag=lh.action_actor,limit=1]',color:'yellow'},{text:' 跟注，当前 ',color:'gray'},{score:{name:'@a[tag=lh.action_actor,limit=1]',objective:'lh_bullets'},color:'red'},{text:' 发。',color:'gray'}]
function liars_holdem:sound/call
function liars_holdem:hud/update
function liars_holdem:log {text:"当前玩家选择跟注并增加1发"}
function liars_holdem:turn/advance
