clear @s minecraft:paper[minecraft:custom_data~{weiqi:{tool:1b}}]
scoreboard players reset @s go_ui_tmp
scoreboard players reset @s go_seen
scoreboard players reset @s go_ui_serial
scoreboard players reset @s go_ui_table
scoreboard players reset @s go_ui_load
scoreboard players reset @s go_coordnonce
scoreboard players reset @s go_coordepoch
scoreboard players reset @s go_coordload
scoreboard players reset @s go_coordtable
scoreboard players reset @s go_revelig
scoreboard players reset @s go_reviewtable
scoreboard players reset @s go_view
scoreboard players reset @s go_action
scoreboard players reset @s go_coord
scoreboard players reset @s go_drop
function weiqi:settings/clear_session
tag @s remove go.actor
tag @s remove go.dropper
