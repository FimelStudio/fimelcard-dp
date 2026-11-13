# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s ac_pulse 0
execute unless score @s ct_state matches 1 run return 0
scoreboard players set #online ac_ctx 0
execute as @a[tag=ac.audience] run scoreboard players add #online ac_ctx 1
scoreboard players set #expected ac_ctx 0
execute as @e[tag=ac.sides,scores={ac_active=1,ac_bot=0,ac_rank=0}] run scoreboard players add #expected ac_ctx 1
scoreboard players set #online_active ac_ctx 0
execute as @a[tag=ac.audience] run function aeroplane_chess:player/count_active
execute if score @s ct_state matches 1 run function aeroplane_chess:ui/board_status
