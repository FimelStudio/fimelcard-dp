# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #ui_value go_ctx 0
execute if score @e[tag=go.current,limit=1] go_wterrit = @e[tag=go.current,limit=1] go_wterrit run scoreboard players operation #ui_value go_ctx = @e[tag=go.current,limit=1] go_wterrit
execute store result storage weiqi:ui wterrit int 1 run scoreboard players get #ui_value go_ctx
