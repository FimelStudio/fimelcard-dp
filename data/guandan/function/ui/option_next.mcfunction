# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless data storage guandan:ui options[0] run return 0
data modify storage guandan:ui option set from storage guandan:ui options[0]
data remove storage guandan:ui options[0]
function guandan:ui/option with storage guandan:ui option
scoreboard players add #ui_option gd_ctx 1
function guandan:ui/option_next
