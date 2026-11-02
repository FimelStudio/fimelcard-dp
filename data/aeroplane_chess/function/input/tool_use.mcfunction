# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function aeroplane_chess:input/context
execute unless entity @s[tag=ac.actor] run return 0
execute if score #tool ac_ctx matches 1 as @e[tag=ac.current,limit=1] at @s run function aeroplane_chess:game/roll
execute if score #tool ac_ctx matches 0 run function aeroplane_chess:ui/quick
