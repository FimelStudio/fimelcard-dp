execute if data storage love_letter:visual public[0] run data modify storage love_letter:visual card set from storage love_letter:visual public[0]
execute if data storage love_letter:visual public[0] run function love_letter:visual/resolve_model
execute if data storage love_letter:visual public[0] positioned ~-0.42 ~1.045 ~0.48 summon minecraft:item_display run function love_letter:visual/public_face with storage love_letter:visual
execute if data storage love_letter:visual public[1] run data modify storage love_letter:visual card set from storage love_letter:visual public[1]
execute if data storage love_letter:visual public[1] run function love_letter:visual/resolve_model
execute if data storage love_letter:visual public[1] positioned ~0 ~1.045 ~0.48 summon minecraft:item_display run function love_letter:visual/public_face with storage love_letter:visual
execute if data storage love_letter:visual public[2] run data modify storage love_letter:visual card set from storage love_letter:visual public[2]
execute if data storage love_letter:visual public[2] run function love_letter:visual/resolve_model
execute if data storage love_letter:visual public[2] positioned ~0.42 ~1.045 ~0.48 summon minecraft:item_display run function love_letter:visual/public_face with storage love_letter:visual
