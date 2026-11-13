execute unless score @s ct_state matches 0 run return 0
function cardtable:chairs/settings/minimum
function cardtable:chairs/layout/ensure
scoreboard players add #chair_serial ct_ctx 1
execute if score #chair_serial ct_ctx matches 100000000.. run scoreboard players add #chair_load ct_ctx 1
execute if score #chair_serial ct_ctx matches 100000000.. run scoreboard players set #chair_serial ct_ctx 1
scoreboard players operation @a[tag=ct.chair_actor,limit=1] ct_ch_nonce = #chair_serial ct_ctx
scoreboard players operation @a[tag=ct.chair_actor,limit=1] ct_ch_load = #chair_load ct_ctx
scoreboard players operation @a[tag=ct.chair_actor,limit=1] ct_ch_table = @s ct_id
scoreboard players operation @a[tag=ct.chair_actor,limit=1] ct_ch_game = @s ct_game
scoreboard players operation @a[tag=ct.chair_actor,limit=1] ct_ch_seen = @s ct_ch_epoch
scoreboard players operation @a[tag=ct.chair_actor,limit=1] ct_ch_seat = @a[tag=ct.chair_actor,limit=1] ct_seat
scoreboard players set @a[tag=ct.chair_actor,limit=1] ct_chair_pick 0
scoreboard players enable @a[tag=ct.chair_actor,limit=1] ct_chair_pick
data modify storage cardtable:chairs row set value {text:"椅子数量：",color:"gray",extra:[]}
execute store result storage cardtable:chairs current int 1 run scoreboard players get @s ct_chairs
execute store result storage cardtable:chairs minimum int 1 run scoreboard players get #chair_min ct_ctx
scoreboard players operation #chair_base ct_ctx = #chair_serial ct_ctx
scoreboard players operation #chair_base ct_ctx *= #chair_ten ct_ctx
execute store result storage cardtable:chairs back int 1 run scoreboard players get #chair_base ct_ctx
execute if score #chair_min ct_ctx matches ..1 if score @s ct_capacity matches 1.. run function cardtable:chairs/settings/choice {count:1}
execute if score #chair_min ct_ctx matches ..2 if score @s ct_capacity matches 2.. run function cardtable:chairs/settings/choice {count:2}
execute if score #chair_min ct_ctx matches ..3 if score @s ct_capacity matches 3.. run function cardtable:chairs/settings/choice {count:3}
execute if score #chair_min ct_ctx matches ..4 if score @s ct_capacity matches 4.. run function cardtable:chairs/settings/choice {count:4}
execute if score #chair_min ct_ctx matches ..5 if score @s ct_capacity matches 5.. run function cardtable:chairs/settings/choice {count:5}
execute if score #chair_min ct_ctx matches ..6 if score @s ct_capacity matches 6.. run function cardtable:chairs/settings/choice {count:6}
execute if score #chair_min ct_ctx matches ..7 if score @s ct_capacity matches 7.. run function cardtable:chairs/settings/choice {count:7}
execute if score #chair_min ct_ctx matches ..8 if score @s ct_capacity matches 8.. run function cardtable:chairs/settings/choice {count:8}
function cardtable:chairs/settings/show with storage cardtable:chairs
