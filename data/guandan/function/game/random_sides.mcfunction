scoreboard players operation #cap gd_ctx = @s ct_capacity
scoreboard players set #two gd_ctx 2
scoreboard players set #assign gd_ctx 0
tag @a[tag=gd.assigned] remove gd.assigned
execute as @a[tag=gd.start] run ride @s dismount
function guandan:game/assign_one
function guandan:game/assign_one
function guandan:game/assign_one
function guandan:game/assign_one
function cardtable:table/ensure_seats
execute as @a[tag=gd.start] at @s run function cardtable:seat/mount
tag @a[tag=gd.assigned] remove gd.assigned
