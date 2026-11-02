execute unless data storage splendor:layout c8.slots run function splendor:visual/load
scoreboard players operation #vis_table sp_ctx = @s ct_id
data modify storage splendor:visual layout set value "c4"
execute if score @s ct_capacity matches 8 run data modify storage splendor:visual layout set value "c8"
