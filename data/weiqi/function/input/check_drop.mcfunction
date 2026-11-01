scoreboard players set #ui_drop_owner go_ctx 0
execute on origin if entity @s[tag=go.dropper,tag=go.player] run scoreboard players set #ui_drop_owner go_ctx 1
execute unless score #ui_drop_owner go_ctx matches 1 run return 0
kill @s
execute as @a[tag=go.dropper,limit=1] run function weiqi:input/give
execute as @a[tag=go.dropper,limit=1] at @s run function weiqi:ui/open
