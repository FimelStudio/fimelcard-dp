# Preserve only passengers actually riding this table. Move all seats before remounting.
tag @s add ct.layout_busy
scoreboard players operation #seat_owner ct_ctx = @s ct_id
scoreboard players operation @s ct_clmask = #chair_mask ct_ctx
scoreboard players set @s ct_clver 1
tag @a[tag=ct.layout_remount] remove ct.layout_remount
execute as @e[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #seat_owner ct_ctx on passengers if entity @s[type=minecraft:player,tag=ct.player] if score @s ct_id = #seat_owner ct_ctx run tag @s add ct.layout_remount
execute as @a[tag=ct.layout_remount] run ride @s dismount
execute unless score @s ct_c1 matches 1 as @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=1}] if score @s ct_id = #seat_owner ct_ctx run kill @s
execute unless score @s ct_c2 matches 1 as @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=2}] if score @s ct_id = #seat_owner ct_ctx run kill @s
execute unless score @s ct_c3 matches 1 as @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=3}] if score @s ct_id = #seat_owner ct_ctx run kill @s
execute unless score @s ct_c4 matches 1 as @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=4}] if score @s ct_id = #seat_owner ct_ctx run kill @s
execute unless score @s ct_c5 matches 1 as @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=5}] if score @s ct_id = #seat_owner ct_ctx run kill @s
execute unless score @s ct_c6 matches 1 as @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=6}] if score @s ct_id = #seat_owner ct_ctx run kill @s
execute unless score @s ct_c7 matches 1 as @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=7}] if score @s ct_id = #seat_owner ct_ctx run kill @s
execute unless score @s ct_c8 matches 1 as @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=8}] if score @s ct_id = #seat_owner ct_ctx run kill @s
execute unless score @s ct_capacity matches 8 run function cardtable:chairs/layout/ensure4
execute if score @s ct_capacity matches 8 run function cardtable:chairs/layout/ensure8
function cardtable:chairs/layout/rebuild_visual
execute as @a[tag=ct.layout_remount] at @s run function cardtable:seat/mount
tag @a[tag=ct.layout_remount] remove ct.layout_remount
tag @s remove ct.layout_busy
