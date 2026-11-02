# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players add @s av_clock 1
execute unless score @s av_clock matches 10.. run return 0
scoreboard players set @s av_clock 0
function avalon:context
scoreboard players set #online av_ctx 0
execute as @a[tag=av.audience] run scoreboard players add #online av_ctx 1
execute as @a[tag=av.audience] run function avalon:player/identity
execute as @a[tag=av.audience] run function avalon:player/private_info
