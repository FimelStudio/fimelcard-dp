# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation @s xq_seen = @e[tag=xq.current,limit=1] xq_epoch
scoreboard players operation @s xq_ui_load = #ui_load xq_ctx
scoreboard players operation #ui_base xq_ctx = @s xq_seen
scoreboard players set #ui_100 xq_ctx 100
scoreboard players operation #ui_base xq_ctx *= #ui_100 xq_ctx
data modify storage xiangqi:ui buttons set value []
scoreboard players set @s xq_action 0
scoreboard players enable @s xq_action
