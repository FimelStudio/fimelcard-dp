execute if score #visual_count dd_ctx = #visual_index dd_ctx unless entity @s[tag=dd.bot] run scoreboard players set #real_target dd_ctx 1
execute if score #visual_count dd_ctx = #visual_index dd_ctx store result storage cardtable:deal seat int 1 run scoreboard players get @s dd_seat
scoreboard players add #visual_count dd_ctx 1
