function cardtable:chairs/settings/minimum
execute if score #chair_choice ct_ctx < #chair_min ct_ctx run return run function cardtable:chairs/settings/rejected
execute if score #chair_choice ct_ctx > @s ct_capacity run return run function cardtable:chairs/settings/rejected
scoreboard players set #chair_occupied ct_ctx 0
scoreboard players operation #chair_table ct_ctx = @s ct_id
execute as @a[tag=ct.player] if score @s ct_id = #chair_table ct_ctx run scoreboard players add #chair_occupied ct_ctx 1
execute if score #chair_choice ct_ctx < #chair_occupied ct_ctx run return run function cardtable:chairs/settings/rejected
scoreboard players operation @s ct_chairs = #chair_choice ct_ctx
function cardtable:chairs/layout/apply
function cardtable:chairs/settings/open
