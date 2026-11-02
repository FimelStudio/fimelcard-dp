# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players remove @s av_timer 1
scoreboard players operation #reveal_table av_ctx = @s av_id
execute if score @s av_timer matches 95 as @e[type=minecraft:item_display,tag=av.reveal] if score @s av_id = #reveal_table av_ctx run function avalon:reveal/lift
execute if score @s av_timer matches 85 as @e[type=minecraft:item_display,tag=av.reveal] if score @s av_id = #reveal_table av_ctx run function avalon:reveal/flip
execute if score @s av_timer matches 75 as @e[type=minecraft:item_display,tag=av.reveal] if score @s av_id = #reveal_table av_ctx run function avalon:reveal/lower
execute if score @s av_timer matches ..0 run function avalon:game/abort
