execute store result score #result_card sp_ctx run data get storage splendor:result queue[0]
data remove storage splendor:result queue[0]
data modify storage splendor:result glyph set value {text:"?",color:"red"}
function splendor:result/glyph_nobles
data modify storage splendor:result line.extra append from storage splendor:result glyph
data modify storage splendor:result line.extra append value {text:" ",font:"minecraft:default"}
execute if data storage splendor:result queue[0] run function splendor:result/nobles
