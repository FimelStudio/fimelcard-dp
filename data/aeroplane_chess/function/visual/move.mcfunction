function aeroplane_chess:visual/context
execute as @e[tag=ac.highlight] if score @s ct_id = #vis_table ac_ctx run kill @s
execute store result storage aeroplane_chess:visual color int 1 run scoreboard players get @s ac_turn
execute store result storage aeroplane_chess:visual plane int 1 run scoreboard players get @s ac_selected
scoreboard players operation #vis_index ac_ctx = @s ac_frompos
scoreboard players add #vis_index ac_ctx 1
execute store result storage aeroplane_chess:visual index int 1 run scoreboard players get #vis_index ac_ctx
function aeroplane_chess:visual/coord with storage aeroplane_chess:visual
data modify storage aeroplane_chess:visual from set from storage aeroplane_chess:visual point
scoreboard players operation #vis_index ac_ctx = @s ac_topos
scoreboard players add #vis_index ac_ctx 1
execute store result storage aeroplane_chess:visual index int 1 run scoreboard players get #vis_index ac_ctx
function aeroplane_chess:visual/coord with storage aeroplane_chess:visual
data modify storage aeroplane_chess:visual to set from storage aeroplane_chess:visual point
execute store result storage aeroplane_chess:visual total int 1 run scoreboard players get @s ac_timer
data modify entity @s data.aeroplane_visual set value {}
data modify entity @s data.aeroplane_visual.from set from storage aeroplane_chess:visual from
data modify entity @s data.aeroplane_visual.to set from storage aeroplane_chess:visual to
data modify entity @s data.aeroplane_visual.total set from storage aeroplane_chess:visual total
data modify entity @s data.aeroplane_visual.color set from storage aeroplane_chess:visual color
data modify entity @s data.aeroplane_visual.plane set from storage aeroplane_chess:visual plane
