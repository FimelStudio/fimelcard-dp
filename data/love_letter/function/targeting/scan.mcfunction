function love_letter:targeting/scan_clear
scoreboard players set #aim ll_ctx 0
scoreboard players set #pitch ll_ctx 0
execute as @a[tag=ll.audience] if score @s ll_seat = #actor ll_ctx run tag @s add ll.aim_actor
execute as @a[tag=ll.aim_actor] store result score #pitch ll_ctx run data get entity @s Rotation[1]
execute if score #pitch ll_ctx matches 50.. run return run function love_letter:targeting/scan_clear
execute as @a[tag=ll.audience] unless score @s ll_seat = #actor ll_ctx run tag @s add ll.aim_candidate
execute as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^ run summon minecraft:marker ~ ~ ~ {Tags:["ll.aim_ray"]}
function love_letter:targeting/ray
function love_letter:targeting/scan_clear
