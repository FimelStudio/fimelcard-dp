# 仅读取公开的 action.card、actor、target、eliminated，不访问 ll_hand 或 ll_extra。
function love_letter:system/context
function love_letter:visual/context
execute unless data entity @s data.love_letter.action.actor run return 0
data modify storage love_letter:visual seat set from entity @s data.love_letter.action.actor
data modify storage love_letter:visual card set from entity @s data.love_letter.action.card
data modify storage love_letter:visual target set from entity @s data.love_letter.action.target
function love_letter:visual/event_seat with storage love_letter:visual
function love_letter:visual/resolve_model
data modify storage love_letter:visual seat_data.model set from storage love_letter:visual model
function love_letter:visual/play_path with storage love_letter:visual
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function love_letter:visual/play_fx with storage love_letter:visual seat_data
execute if data storage love_letter:visual {card:2} run function love_letter:visual/peek
execute if data storage love_letter:visual {card:7} run function love_letter:visual/swap
data modify storage love_letter:visual eliminated set from entity @s data.love_letter.action.eliminated
execute if data storage love_letter:visual eliminated[0] run function love_letter:visual/eliminated
