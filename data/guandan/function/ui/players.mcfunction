# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @e[tag=gd.board,scores={gd_order=0}] run function guandan:ui/player_line
execute as @e[tag=gd.board,scores={gd_order=1}] run function guandan:ui/player_line
execute as @e[tag=gd.board,scores={gd_order=2}] run function guandan:ui/player_line
execute as @e[tag=gd.board,scores={gd_order=3}] run function guandan:ui/player_line
