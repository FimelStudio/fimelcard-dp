# 由 player/clear_state 调用；离座会使全部旧面板、旧设置窗口失效。
clear @s minecraft:paper[minecraft:custom_data~{gomoku:{tool:1b}}]
scoreboard players reset @s gm_action
scoreboard players reset @s gm_settings
scoreboard players reset @s gm_drop
scoreboard players reset @s gm_seen
scoreboard players reset @s gm_ui_load
scoreboard players reset @s gm_ui_tmp
scoreboard players reset @s gm_set_table
scoreboard players reset @s gm_setnonce
scoreboard players reset @s gm_setepoch
scoreboard players reset @s gm_nonce
scoreboard players reset @s gm_coord
scoreboard players reset @s gm_coordnonce
scoreboard players reset @s gm_coordepoch
scoreboard players reset @s gm_coordload
scoreboard players reset @s gm_coordtable
tag @s remove gm.actor
tag @s remove gm.clicker
tag @s remove gm.dropper
