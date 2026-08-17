scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @e[type=minecraft:item_display,tag=lh.community,scores={lh_slot=4}] if score @s lh_id = #ctx_id lh_ctx run data merge entity @s {start_interpolation:0,interpolation_duration:15,transformation:{right_rotation:[0.0f,0.0f,-1.0f,0.0f]}}
execute as @e[type=minecraft:item_display,tag=lh.community,scores={lh_slot=4}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_flipped 1
function liars_holdem:sound/reveal_turn
scoreboard players set @s lh_state 8
scoreboard players set @s lh_timer 0
function liars_holdem:transition/turn
