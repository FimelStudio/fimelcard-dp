function love_letter:targeting/scan_clear
scoreboard players set #aim ll_ctx 0
scoreboard players set #pitch ll_ctx 0
execute as @a[tag=ll.audience] if score @s ll_seat = #actor ll_ctx run tag @s add ll.aim_actor
execute as @a[tag=ll.aim_actor] store result score #pitch ll_ctx run data get entity @s Rotation[1]
execute if score #pitch ll_ctx matches 50.. run return run function love_letter:targeting/scan_clear
execute as @a[tag=ll.audience] unless score @s ll_seat = #actor ll_ctx run tag @s add ll.aim_candidate
execute as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^ run summon minecraft:marker ~ ~ ~ {Tags:["ll.aim_ray"]}
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^0.35 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^0.70 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^1.05 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^1.40 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^1.75 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^2.10 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^2.45 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^2.80 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^3.15 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^3.50 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^3.85 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^4.20 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^4.55 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^4.90 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^5.25 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^5.60 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^5.95 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_actor] at @s anchored eyes positioned ^ ^ ^6.30 run tp @e[type=minecraft:marker,tag=ll.aim_ray,limit=1] ~ ~ ~
execute if score #aim ll_ctx matches 0 as @a[tag=ll.aim_candidate] at @s anchored eyes positioned ^ ^ ^ run function love_letter:targeting/body
function love_letter:targeting/scan_clear
