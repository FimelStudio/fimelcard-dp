execute if score #found lh_ctx matches 1 run return 0
scoreboard players add @s lh_gun_seat 1
execute if score @s lh_gun_seat matches 5.. run scoreboard players set @s lh_gun_seat 1
scoreboard players operation #gun_seat lh_ctx = @s lh_gun_seat
tag @a[tag=lh.gun_target] remove lh.gun_target
execute as @a[tag=lh.pending_target] if score @s lh_seat = #gun_seat lh_ctx run tag @s add lh.gun_target
execute if entity @a[tag=lh.gun_target,limit=1] run scoreboard players set #found lh_ctx 1
