execute unless data storage guandan:layout c8.seats run function guandan:visual/load
scoreboard players operation #vis_table gd_ctx = @s ct_id
execute store result storage guandan:visual cap int 1 run scoreboard players get @s ct_capacity
