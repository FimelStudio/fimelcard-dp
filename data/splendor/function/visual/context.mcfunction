execute unless data storage splendor:layout c8s1.slots run function splendor:visual/load
scoreboard players operation #vis_table sp_ctx = @s ct_id
data modify storage splendor:visual layout set value "c4s3"
data modify storage splendor:visual bonus set value [0,0,0,0,0]
execute if score @s ct_capacity matches 8 run data modify storage splendor:visual layout set value "c8s5"
execute if data entity @s data.splendor.turn run function splendor:visual/orientation with entity @s data.splendor
