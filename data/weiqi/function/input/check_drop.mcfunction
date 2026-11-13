# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #ui_drop_owner go_ctx 0
execute on origin if entity @s[tag=go.dropper,tag=go.player] run scoreboard players set #ui_drop_owner go_ctx 1
execute unless score #ui_drop_owner go_ctx matches 1 run return 0
kill @s
execute as @a[tag=go.dropper,limit=1] run function weiqi:input/give
execute as @a[tag=go.dropper,limit=1] at @s run function weiqi:ui/open
