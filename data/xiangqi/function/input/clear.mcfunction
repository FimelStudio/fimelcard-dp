# 由 player/clear_state 调用；离座会使全部旧面板、旧设置窗口失效。
clear @s minecraft:paper[minecraft:custom_data~{xiangqi:{tool:1b}}]
scoreboard players reset @s xq_action
scoreboard players reset @s xq_settings
scoreboard players reset @s xq_drop
scoreboard players reset @s xq_seen
scoreboard players reset @s xq_ui_load
scoreboard players reset @s xq_ui_tmp
scoreboard players reset @s xq_set_table
scoreboard players reset @s xq_setnonce
scoreboard players reset @s xq_setepoch
scoreboard players reset @s xq_nonce
tag @s remove xq.actor
tag @s remove xq.clicker
tag @s remove xq.dropper
