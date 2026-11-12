scoreboard players set #limit dc_ctx 0
$scoreboard players operation #limit dc_ctx = @s $(limit)
scoreboard players set @s dc_seconds 0
execute if score #limit dc_ctx matches 1 run scoreboard players set @s dc_seconds 60
execute if score #limit dc_ctx matches 2 run scoreboard players set @s dc_seconds 90
execute if score #limit dc_ctx matches 3 run scoreboard players set @s dc_seconds 120
execute if score #limit dc_ctx matches 4 run scoreboard players set @s dc_seconds 180
execute if score #limit dc_ctx matches 5 run scoreboard players set @s dc_seconds 240
scoreboard players operation @s dc_timer = @s dc_seconds
scoreboard players operation @s dc_timer *= #ticks_per_second dc_ctx
