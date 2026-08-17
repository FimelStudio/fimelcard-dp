scoreboard players operation #ctx_id lh_ctx = @s lh_id
scoreboard players set @s lh_allin 1
scoreboard players set @s lh_state 12
execute as @a[tag=lh.player,scores={lh_alive=1,lh_fold=0}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_done 0
execute as @a[tag=lh.player,scores={lh_alive=1,lh_fold=0}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_swap 0
scoreboard players set @a[tag=lh.action_actor,limit=1] lh_bullets 8
scoreboard players set @a[tag=lh.action_actor,limit=1] lh_done 1
scoreboard players operation @s lh_turn = @a[tag=lh.action_actor,limit=1] lh_seat
execute as @a[tag=lh.action_actor,limit=1] run function liars_holdem:util/clear_items_actions
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run tellraw @s [{selector:'@a[tag=lh.action_actor,limit=1]',color:'red',bold:true},{text:' 选择 ALL IN！其余玩家只能跟随或弃牌。',color:'gold'}]
function liars_holdem:sound/all_in
function liars_holdem:hud/update
function liars_holdem:log {text:"有玩家触发ALL IN，关闭全桌换牌"}
function liars_holdem:turn/advance
