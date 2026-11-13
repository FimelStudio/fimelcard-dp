function love_letter:visual/event_seat with storage love_letter:visual
data modify storage love_letter:visual seat_data.model set value "back"
function love_letter:visual/swap_path with storage love_letter:visual
execute positioned ~ ~1.06 ~ summon minecraft:item_display run function love_letter:visual/play_fx with storage love_letter:visual seat_data
