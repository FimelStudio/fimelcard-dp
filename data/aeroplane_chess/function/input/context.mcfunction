tag @a[tag=ac.actor] remove ac.actor
tag @e[tag=ac.current] remove ac.current
execute unless entity @s[tag=ct.player,tag=ac.player] run return 0
execute unless score @s ct_id = @s ac_table run return 0
scoreboard players operation #ui_table ac_ctx = @s ac_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ac.controller,scores={ct_game=15,ct_state=1}] if score @s ct_id = #ui_table ac_ctx run tag @s add ac.current
execute unless entity @e[tag=ac.current,limit=1] run return 0
tag @s add ac.actor
execute as @e[tag=ac.current,limit=1] at @s run function aeroplane_chess:system/context
