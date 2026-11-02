# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s ll_tick 0
function love_letter:system/context
scoreboard players set #online ll_ctx 0
execute as @a[tag=ll.audience] run scoreboard players add #online ll_ctx 1
function love_letter:hud/refresh
