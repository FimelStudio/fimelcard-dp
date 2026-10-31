# 由 player/clear_state 调用；离座会使全部旧面板、旧设置窗口失效。
clear @s minecraft:paper[minecraft:custom_data~{chess:{tool:1b}}]
scoreboard players reset @s ch_action
scoreboard players reset @s ch_settings
scoreboard players reset @s ch_drop
scoreboard players reset @s ch_seen
scoreboard players reset @s ch_ui_load
scoreboard players reset @s ch_ui_tmp
scoreboard players reset @s ch_set_table
scoreboard players reset @s ch_setnonce
scoreboard players reset @s ch_setepoch
scoreboard players reset @s ch_nonce
tag @s remove ch.actor
tag @s remove ch.clicker
tag @s remove ch.dropper
