scoreboard players set @a[tag=lh.action_actor,limit=1] lh_bullets 8
scoreboard players set @a[tag=lh.action_actor,limit=1] lh_done 1
execute as @a[tag=lh.action_actor,limit=1] run function liars_holdem:util/clear_items_actions
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run tellraw @s [{selector:'@a[tag=lh.action_actor,limit=1]',color:'yellow'},{text:' 跟随 ALL IN。',color:'red'}]
function liars_holdem:sound/follow_all_in
function liars_holdem:hud/update
function liars_holdem:turn/advance
