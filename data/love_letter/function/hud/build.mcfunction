execute unless entity @s[tag=ll.hud_active] run function love_letter:hud/activate
scoreboard players operation #hud_seat ll_ctx = @s ll_seat
scoreboard players operation #hud_table ll_ctx = @s ll_table
tag @e[tag=ll.hud_part] remove ll.hud_part
execute as @e[tag=ll.part] if score @s ct_id = #hud_table ll_ctx if score @s ll_seat = #hud_seat ll_ctx run tag @s add ll.hud_part
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
execute if entity @e[tag=ll.hud_part,scores={ll_alive=1},limit=1] run function love_letter:hud/cards
function love_letter:hud/status
scoreboard players operation panel_id fbt_io = @s ll_panel
function fimel_title:replace_panel
scoreboard players operation @s fbt_panel = @s ll_panel
tag @e[tag=ll.hud_part] remove ll.hud_part
