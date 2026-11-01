function guandan:hud/deactivate
function guandan:input/clear
function guandan:settings/clear_session
clear @s *[minecraft:custom_data~{guandan:{tool:1b}}]
execute if entity @s[tag=gd.player] run dialog clear @s
tag @s remove gd.player
tag @s remove gd.audience
tag @s remove gd.actor
scoreboard players reset @s gd_table
scoreboard players reset @s gd_seat
scoreboard players reset @s gd_team
scoreboard players reset @s gd_order
scoreboard players reset @s gd_action
scoreboard players set @s gd_drop 0
