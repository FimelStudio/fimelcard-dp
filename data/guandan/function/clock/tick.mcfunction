execute if score @s gd_anim matches 1.. run return run function guandan:clock/animation
function guandan:system/context
scoreboard players operation #actor gd_ctx = @s gd_turn
scoreboard players set #clock_bot gd_ctx 0
execute if score @s gd_state matches 3 as @e[tag=gd.board,tag=gd.bot] if score @s gd_seat = #actor gd_ctx run scoreboard players set #clock_bot gd_ctx 1
execute if score #clock_bot gd_ctx matches 1 run return 0
execute if score @s gd_limit matches 0 run return 0
execute if score @s gd_clock matches 1.. run scoreboard players remove @s gd_clock 1
execute if score @s gd_clock matches 0 run function guandan:clock/timeout
