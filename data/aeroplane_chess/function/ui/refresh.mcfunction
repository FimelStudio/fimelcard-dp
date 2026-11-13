# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function aeroplane_chess:system/context
execute as @a[tag=ac.audience] run function aeroplane_chess:input/give
scoreboard players set @a[tag=ac.audience] ac_action 0
scoreboard players enable @a[tag=ac.audience] ac_action
function aeroplane_chess:ui/board_status
