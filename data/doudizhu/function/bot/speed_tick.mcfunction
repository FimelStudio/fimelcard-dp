# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players add @s dd_bot_timer 1
execute unless score @s dd_bot_timer matches 60.. run return 0
scoreboard players set @s dd_bot_timer 0
scoreboard players operation #speed_table dd_ctx = @s dd_id
tag @e[tag=dd.speed_pool] remove dd.speed_pool
execute as @e[tag=dd.bot] if score @s dd_id = #speed_table dd_ctx run tag @s add dd.speed_pool
execute as @e[tag=dd.speed_pool,sort=random,limit=1] run function doudizhu:bot/act
tag @e[tag=dd.speed_pool] remove dd.speed_pool
