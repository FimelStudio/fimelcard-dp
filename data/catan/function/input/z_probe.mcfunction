# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute at @e[tag=ca.current,limit=1] positioned ~-4 ~-8 ~$(offset) if entity @e[type=minecraft:marker,tag=ca.ray,dx=7,dy=15,dz=7,limit=1] run scoreboard players set #greater ca_ctx 1
