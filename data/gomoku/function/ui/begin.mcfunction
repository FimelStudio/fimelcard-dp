# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation @s gm_seen = @e[tag=gm.current,limit=1] gm_epoch
scoreboard players operation @s gm_ui_load = #ui_load gm_ctx
scoreboard players operation #ui_base gm_ctx = @s gm_seen
scoreboard players set #ui_100 gm_ctx 100
scoreboard players operation #ui_base gm_ctx *= #ui_100 gm_ctx
data modify storage gomoku:ui buttons set value []
scoreboard players set @s gm_action 0
scoreboard players enable @s gm_action
