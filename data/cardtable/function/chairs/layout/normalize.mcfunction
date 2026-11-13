# Keep occupied actual seat IDs, then fill opposite sides before doubling a side.
execute unless score @s ct_ch_epoch matches 0.. run scoreboard players set @s ct_ch_epoch 0
execute unless score @s ct_chairs matches 1..8 run scoreboard players operation @s ct_chairs = @s ct_capacity
function cardtable:chairs/settings/minimum
execute if score @s ct_chairs < #chair_min ct_ctx run scoreboard players operation @s ct_chairs = #chair_min ct_ctx
execute if score @s ct_chairs > @s ct_capacity run scoreboard players operation @s ct_chairs = @s ct_capacity
scoreboard players operation #chair_table ct_ctx = @s ct_id
scoreboard players set #chair_count ct_ctx 0
scoreboard players set #chair_slot_1 ct_ctx 0
scoreboard players set #chair_slot_2 ct_ctx 0
scoreboard players set #chair_slot_3 ct_ctx 0
scoreboard players set #chair_slot_4 ct_ctx 0
scoreboard players set #chair_slot_5 ct_ctx 0
scoreboard players set #chair_slot_6 ct_ctx 0
scoreboard players set #chair_slot_7 ct_ctx 0
scoreboard players set #chair_slot_8 ct_ctx 0
scoreboard players set #chair_old_1 ct_ctx 0
execute if score @s ct_c1 matches 1 run scoreboard players set #chair_old_1 ct_ctx 1
scoreboard players set @s ct_c1 0
execute as @a[tag=ct.player,scores={ct_seat=1}] if score @s ct_id = #chair_table ct_ctx run scoreboard players set #chair_slot_1 ct_ctx 1
scoreboard players set #chair_old_2 ct_ctx 0
execute if score @s ct_c2 matches 1 run scoreboard players set #chair_old_2 ct_ctx 1
scoreboard players set @s ct_c2 0
execute as @a[tag=ct.player,scores={ct_seat=2}] if score @s ct_id = #chair_table ct_ctx run scoreboard players set #chair_slot_2 ct_ctx 1
scoreboard players set #chair_old_3 ct_ctx 0
execute if score @s ct_c3 matches 1 run scoreboard players set #chair_old_3 ct_ctx 1
scoreboard players set @s ct_c3 0
execute as @a[tag=ct.player,scores={ct_seat=3}] if score @s ct_id = #chair_table ct_ctx run scoreboard players set #chair_slot_3 ct_ctx 1
scoreboard players set #chair_old_4 ct_ctx 0
execute if score @s ct_c4 matches 1 run scoreboard players set #chair_old_4 ct_ctx 1
scoreboard players set @s ct_c4 0
execute as @a[tag=ct.player,scores={ct_seat=4}] if score @s ct_id = #chair_table ct_ctx run scoreboard players set #chair_slot_4 ct_ctx 1
scoreboard players set #chair_old_5 ct_ctx 0
execute if score @s ct_c5 matches 1 run scoreboard players set #chair_old_5 ct_ctx 1
scoreboard players set @s ct_c5 0
execute as @a[tag=ct.player,scores={ct_seat=5}] if score @s ct_id = #chair_table ct_ctx run scoreboard players set #chair_slot_5 ct_ctx 1
scoreboard players set #chair_old_6 ct_ctx 0
execute if score @s ct_c6 matches 1 run scoreboard players set #chair_old_6 ct_ctx 1
scoreboard players set @s ct_c6 0
execute as @a[tag=ct.player,scores={ct_seat=6}] if score @s ct_id = #chair_table ct_ctx run scoreboard players set #chair_slot_6 ct_ctx 1
scoreboard players set #chair_old_7 ct_ctx 0
execute if score @s ct_c7 matches 1 run scoreboard players set #chair_old_7 ct_ctx 1
scoreboard players set @s ct_c7 0
execute as @a[tag=ct.player,scores={ct_seat=7}] if score @s ct_id = #chair_table ct_ctx run scoreboard players set #chair_slot_7 ct_ctx 1
scoreboard players set #chair_old_8 ct_ctx 0
execute if score @s ct_c8 matches 1 run scoreboard players set #chair_old_8 ct_ctx 1
scoreboard players set @s ct_c8 0
execute as @a[tag=ct.player,scores={ct_seat=8}] if score @s ct_id = #chair_table ct_ctx run scoreboard players set #chair_slot_8 ct_ctx 1
execute if score #chair_slot_1 ct_ctx matches 1 run scoreboard players set @s ct_c1 1
execute if score @s ct_c1 matches 1 run scoreboard players add #chair_count ct_ctx 1
execute if score #chair_slot_2 ct_ctx matches 1 run scoreboard players set @s ct_c2 1
execute if score @s ct_c2 matches 1 run scoreboard players add #chair_count ct_ctx 1
execute if score #chair_slot_3 ct_ctx matches 1 run scoreboard players set @s ct_c3 1
execute if score @s ct_c3 matches 1 run scoreboard players add #chair_count ct_ctx 1
execute if score #chair_slot_4 ct_ctx matches 1 run scoreboard players set @s ct_c4 1
execute if score @s ct_c4 matches 1 run scoreboard players add #chair_count ct_ctx 1
execute if score #chair_slot_5 ct_ctx matches 1 run scoreboard players set @s ct_c5 1
execute if score @s ct_c5 matches 1 run scoreboard players add #chair_count ct_ctx 1
execute if score #chair_slot_6 ct_ctx matches 1 run scoreboard players set @s ct_c6 1
execute if score @s ct_c6 matches 1 run scoreboard players add #chair_count ct_ctx 1
execute if score #chair_slot_7 ct_ctx matches 1 run scoreboard players set @s ct_c7 1
execute if score @s ct_c7 matches 1 run scoreboard players add #chair_count ct_ctx 1
execute if score #chair_slot_8 ct_ctx matches 1 run scoreboard players set @s ct_c8 1
execute if score @s ct_c8 matches 1 run scoreboard players add #chair_count ct_ctx 1
execute if score @s ct_chairs < #chair_count ct_ctx run scoreboard players operation @s ct_chairs = #chair_count ct_ctx
execute unless score @s ct_capacity matches 8 run function cardtable:chairs/layout/fill4
execute if score @s ct_capacity matches 8 run function cardtable:chairs/layout/fill8
scoreboard players set #chair_mask ct_ctx 0
execute if score @s ct_c1 matches 1 run scoreboard players add #chair_mask ct_ctx 1
execute if score @s ct_c2 matches 1 run scoreboard players add #chair_mask ct_ctx 2
execute if score @s ct_c3 matches 1 run scoreboard players add #chair_mask ct_ctx 4
execute if score @s ct_c4 matches 1 run scoreboard players add #chair_mask ct_ctx 8
execute if score @s ct_c5 matches 1 run scoreboard players add #chair_mask ct_ctx 16
execute if score @s ct_c6 matches 1 run scoreboard players add #chair_mask ct_ctx 32
execute if score @s ct_c7 matches 1 run scoreboard players add #chair_mask ct_ctx 64
execute if score @s ct_c8 matches 1 run scoreboard players add #chair_mask ct_ctx 128
