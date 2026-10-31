function aeroplane_chess:input/context
execute unless entity @s[tag=ac.actor] run return 0
execute if score #tool ac_ctx matches 1 as @e[tag=ac.current,limit=1] at @s run function aeroplane_chess:game/roll
execute if score #tool ac_ctx matches 0 run function aeroplane_chess:ui/quick
