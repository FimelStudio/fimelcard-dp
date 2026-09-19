function decrypto:game/cleanup_drops
scoreboard players operation #ctx dc_ctx = @s dc_id
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run function decrypto:player/clear_state
execute as @e[tag=dc.marker] if score @s dc_id = #ctx dc_ctx run kill @s
kill @e[tag=dc.marker,distance=..4]
execute as @e[type=minecraft:item_display,tag=dc.history] if score @s dc_id = #ctx dc_ctx run kill @s
execute if block ~ ~1 ~ minecraft:anvil run setblock ~ ~1 ~ air
execute if block ~ ~1 ~ minecraft:chipped_anvil run setblock ~ ~1 ~ air
execute if block ~ ~1 ~ minecraft:damaged_anvil run setblock ~ ~1 ~ air
data remove entity @s data.decrypto.note_lines
scoreboard players reset @s dc_page
scoreboard players reset @s dc_pages
scoreboard players reset @s dc_page_tick
data remove entity @s data.decrypto.keywords
tag @s remove dc.controller
scoreboard players reset @s dc_id
scoreboard players set @s dc_state 0
function cardtable:game/return_lobby
