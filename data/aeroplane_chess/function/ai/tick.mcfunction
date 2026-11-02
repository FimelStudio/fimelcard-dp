# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #bot ac_ctx 0
execute as @e[tag=ac.sides,scores={ac_active=1,ac_rank=0}] if score @s ac_color = @e[tag=ac.current,limit=1] ac_turn run scoreboard players operation #bot ac_ctx = @s ac_bot
execute unless score #bot ac_ctx matches 1 run return 0
scoreboard players remove @s ac_wait 1
execute if score @s ac_wait matches 1.. run return 0
execute if score @s ac_state matches 1 run return run function aeroplane_chess:game/roll_internal
execute if score @s ac_state matches 3 run function aeroplane_chess:ai/choose
