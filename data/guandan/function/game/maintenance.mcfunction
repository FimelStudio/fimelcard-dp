# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s gd_tick 0
function guandan:system/context
scoreboard players set #online gd_ctx 0
execute as @a[tag=gd.audience] run scoreboard players add #online gd_ctx 1
execute unless score @s gd_humans matches 1..4 run scoreboard players set @s gd_humans 4
function guandan:hud/refresh
