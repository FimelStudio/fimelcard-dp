execute if score @s go_eff matches 0 run tag @s add go.lib
execute if score #color go_ctx matches 0 if score @s go_eff matches 1 run scoreboard players set #border_black go_ctx 1
execute if score #color go_ctx matches 0 if score @s go_eff matches -1 run scoreboard players set #border_white go_ctx 1
execute if score @s go_eff = #color go_ctx unless entity @s[tag=go.seen] run function weiqi:engine/group/enqueue
