# 独占 custom_data 清理，保留玩家的普通纸、染料和其他游戏物品。
function uno:hud/deactivate
clear @s *[minecraft:custom_data~{uno:{tool:1b}}]
clear @s *[minecraft:custom_data~{uno:{card:1b}}]
scoreboard players reset @s un_table
scoreboard players reset @s un_seat
scoreboard players reset @s un_count
scoreboard players reset @s un_score
scoreboard players reset @s un_pick
scoreboard players reset @s un_colorpick
scoreboard players reset @s un_seen
scoreboard players reset @s un_drop
scoreboard players reset @s un_action
scoreboard players reset @s un_set_table
scoreboard players reset @s un_setnonce
scoreboard players reset @s un_nonce
scoreboard players reset @s un_settings
tag @s remove un.player
tag @s remove un.audience
tag @s remove un.actor
