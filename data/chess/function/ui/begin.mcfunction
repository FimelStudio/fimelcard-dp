# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation @s ch_seen = @e[tag=ch.current,limit=1] ch_epoch
scoreboard players operation @s ch_ui_load = #ui_load ch_ctx
scoreboard players operation #ui_base ch_ctx = @s ch_seen
scoreboard players set #ui_100 ch_ctx 100
scoreboard players operation #ui_base ch_ctx *= #ui_100 ch_ctx
data modify storage chess:ui buttons set value []
scoreboard players set @s ch_action 0
scoreboard players enable @s ch_action
