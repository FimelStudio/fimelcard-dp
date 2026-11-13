scoreboard players operation #match dd_ctx = @s ct_id
tag @e[tag=dd.other_lane] remove dd.other_lane
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_lane=2}] if score @s ct_id = #match dd_ctx run tag @s add dd.other_lane
