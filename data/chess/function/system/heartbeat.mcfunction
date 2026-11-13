# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s ch_pulse 0
function chess:system/context
execute if score @s ct_state matches 0 run function chess:system/check_visual
execute unless score @s ct_state matches 1 run return 0
scoreboard players set #online ch_ctx 0
execute as @a[tag=ch.audience] run scoreboard players add #online ch_ctx 1
scoreboard players set #expected ch_ctx 2
execute unless score @s ch_bot matches 0 run scoreboard players set #expected ch_ctx 1
function chess:clock/update
