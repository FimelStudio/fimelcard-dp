scoreboard players set #ok gd_ctx 0
execute unless score @s gd_state matches 3 run return 0
execute if score @s gd_anim matches 1.. run return 0
execute unless score #actor gd_ctx = @s gd_turn run return 0
function guandan:system/context
scoreboard players set #actor_valid gd_ctx 0
execute as @e[tag=gd.board,scores={gd_rank=0,gd_count=1..27}] if score @s gd_seat = #actor gd_ctx run scoreboard players set #actor_valid gd_ctx 1
execute unless score #actor_valid gd_ctx matches 1 run return 0
scoreboard players set #ok gd_ctx 1
