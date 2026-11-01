function guandan:system/context
function guandan:visual/context
execute as @e[tag=gd.visual,tag=!gd.fx,tag=!gd.box] if score @s ct_id = #vis_table gd_ctx run kill @s
scoreboard players set #box_found gd_ctx 0
execute as @e[tag=gd.box] if score @s ct_id = #vis_table gd_ctx run scoreboard players add #box_found gd_ctx 1
execute unless score #box_found gd_ctx matches 2 run function guandan:visual/boxes
execute as @e[type=minecraft:marker,tag=gd.board] run function guandan:visual/participant
execute if score @s gd_state matches 1..5 positioned ~ ~1.075 ~ summon minecraft:text_display run function guandan:visual/status
