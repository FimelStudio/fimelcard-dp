execute if score @s gd_state matches 1 run function guandan:deal/tick
execute if score @s gd_state matches 2..3 run function guandan:clock/tick
execute if score @s gd_state matches 4..5 run function guandan:round/result_tick
scoreboard players add @s gd_tick 1
execute if score @s gd_tick matches 20.. run function guandan:game/maintenance

execute if score @s gd_state matches 2..3 if score @s gd_anim matches 0 run function guandan:bot/tick
