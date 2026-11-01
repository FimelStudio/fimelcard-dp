scoreboard players operation #cap gd_ctx = @s ct_capacity
scoreboard players set #two gd_ctx 2
scoreboard players set #sides_ok gd_ctx 1
execute as @a[tag=gd.start] run function guandan:player/side
scoreboard players set #side0 gd_ctx 0
scoreboard players set #side1 gd_ctx 0
scoreboard players set #side2 gd_ctx 0
scoreboard players set #side3 gd_ctx 0
execute as @a[tag=gd.start,scores={gd_order=0}] run scoreboard players add #side0 gd_ctx 1
execute as @a[tag=gd.start,scores={gd_order=1}] run scoreboard players add #side1 gd_ctx 1
execute as @a[tag=gd.start,scores={gd_order=2}] run scoreboard players add #side2 gd_ctx 1
execute as @a[tag=gd.start,scores={gd_order=3}] run scoreboard players add #side3 gd_ctx 1
execute if score #side0 gd_ctx matches 2.. run scoreboard players set #sides_ok gd_ctx 0
execute if score #side1 gd_ctx matches 2.. run scoreboard players set #sides_ok gd_ctx 0
execute if score #side2 gd_ctx matches 2.. run scoreboard players set #sides_ok gd_ctx 0
execute if score #side3 gd_ctx matches 2.. run scoreboard players set #sides_ok gd_ctx 0
