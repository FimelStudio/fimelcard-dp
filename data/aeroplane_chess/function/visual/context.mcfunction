execute unless data storage aeroplane_chess:layout r6 run function aeroplane_chess:visual/load
scoreboard players operation #vis_table ac_ctx = @s ct_id
execute store result storage aeroplane_chess:visual cap int 1 run scoreboard players get @s ct_capacity
execute store result storage aeroplane_chess:visual orient int 1 run scoreboard players get @s ac_orient
data modify storage aeroplane_chess:visual palette set value "classic"
execute if score @s ac_palette matches 0 run data modify storage aeroplane_chess:visual palette set value "classic"
function aeroplane_chess:visual/layout with storage aeroplane_chess:visual
