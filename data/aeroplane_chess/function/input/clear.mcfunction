clear @s minecraft:paper[minecraft:custom_data~{aeroplane_chess:{tool:1b}}]
scoreboard players reset @s ac_action
scoreboard players reset @s ac_settings
scoreboard players reset @s ac_drop
scoreboard players reset @s ac_seen
scoreboard players reset @s ac_ui_load
scoreboard players reset @s ac_ui_tmp
scoreboard players reset @s ac_set_table
scoreboard players reset @s ac_setnonce
scoreboard players reset @s ac_setepoch
scoreboard players reset @s ac_nonce
tag @s remove ac.actor
tag @s remove ac.dropper
