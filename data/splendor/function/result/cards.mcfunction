execute store result score #result_card sp_ctx run data get storage splendor:result queue[0]
data remove storage splendor:result queue[0]
data modify storage splendor:result glyph set value {text:"?",color:"red"}
function splendor:result/glyph_cards
data modify storage splendor:result line.extra append from storage splendor:result glyph
data modify storage splendor:result line.extra append value {text:" ",font:"minecraft:default"}
scoreboard players add #result_col sp_ctx 1
execute if score #result_col sp_ctx matches 16 run function splendor:result/emit
execute if score #result_col sp_ctx matches 16 run data modify storage splendor:result line set value {text:"发展卡（续）： ",color:"aqua",extra:[]}
execute if score #result_col sp_ctx matches 16 run scoreboard players set #result_col sp_ctx 0
execute if data storage splendor:result queue[0] run function splendor:result/cards
