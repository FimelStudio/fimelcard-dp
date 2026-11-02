function splendor:sound/stop_player
clear @s minecraft:paper[minecraft:custom_data~{splendor:{tool:1b}}]
function splendor:settings/clear_session
scoreboard players reset @s sp_nonce
scoreboard players reset @s sp_action
scoreboard players reset @s sp_drop
scoreboard players reset @s sp_panel
scoreboard players reset @s sp_target
tag @s remove sp.player
tag @s remove sp.audience
tag @s remove sp.actor
scoreboard players reset @s sp_table
scoreboard players reset @s sp_seat
scoreboard players reset @s sp_side
scoreboard players reset @s sp_seen
scoreboard players reset @s sp_ui_load
scoreboard players reset @s sp_ui_table
scoreboard players reset @s sp_pick0
scoreboard players reset @s sp_pick1
scoreboard players reset @s sp_pick2
scoreboard players reset @s sp_pick3
scoreboard players reset @s sp_pick4
scoreboard players reset @s sp_pick5
