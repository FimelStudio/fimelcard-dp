# ALL IN响应完成后一次翻开所有仍盖住的公共牌
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @e[type=minecraft:item_display,tag=lh.community,scores={lh_flipped=0}] if score @s lh_id = #ctx_id lh_ctx run data merge entity @s {start_interpolation:0,interpolation_duration:15,transformation:{right_rotation:[0.0f,0.0f,-1.0f,0.0f]}}
execute as @e[type=minecraft:item_display,tag=lh.community] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_flipped 1
function liars_holdem:sound/reveal_all
scoreboard players set @s lh_auto 1
scoreboard players set @s lh_state 10
scoreboard players set @s lh_timer 0
function liars_holdem:transition/showdown
