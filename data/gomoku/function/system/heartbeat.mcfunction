# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s gm_pulse 0
function gomoku:system/context
execute if score @s ct_state matches 0 run function gomoku:system/check_visual
execute unless score @s ct_state matches 1 run return 0
scoreboard players set #online gm_ctx 0
execute as @a[tag=gm.audience] run scoreboard players add #online gm_ctx 1
scoreboard players set #expected gm_ctx 2
execute unless score @s gm_bot matches 0 run scoreboard players set #expected gm_ctx 1
function gomoku:clock/update
