function love_letter:hud/deactivate
function love_letter:input/clear
function love_letter:settings/clear_session
clear @s *[minecraft:custom_data~{love_letter:{tool:1b}}]
execute if entity @s[tag=ll.player] run dialog clear @s
tag @s remove ll.player
tag @s remove ll.audience
tag @s remove ll.actor
scoreboard players reset @s ll_table
scoreboard players reset @s ll_seat
scoreboard players reset @s ll_action
scoreboard players reset @s ll_seen
scoreboard players reset @s ll_pick
scoreboard players set @s ll_drop 0
