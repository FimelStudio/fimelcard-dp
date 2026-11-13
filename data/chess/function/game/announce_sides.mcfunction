data modify storage chess:runtime sides.white set value {selector:"@a[tag=ch.audience,scores={ch_side=1}]"}
data modify storage chess:runtime sides.black set value {selector:"@a[tag=ch.audience,scores={ch_side=-1}]"}
execute if score @s ch_bot matches 1 if score @s ch_level matches 1 run data modify storage chess:runtime sides.white set value {text:"简单人机",color:"aqua"}
execute if score @s ch_bot matches -1 if score @s ch_level matches 1 run data modify storage chess:runtime sides.black set value {text:"简单人机",color:"aqua"}
execute if score @s ch_bot matches 1 if score @s ch_level matches 2 run data modify storage chess:runtime sides.white set value {text:"普通人机",color:"aqua"}
execute if score @s ch_bot matches -1 if score @s ch_level matches 2 run data modify storage chess:runtime sides.black set value {text:"普通人机",color:"aqua"}
execute if score @s ch_bot matches 1 if score @s ch_level matches 3 run data modify storage chess:runtime sides.white set value {text:"困难人机",color:"aqua"}
execute if score @s ch_bot matches -1 if score @s ch_level matches 3 run data modify storage chess:runtime sides.black set value {text:"困难人机",color:"aqua"}
function chess:game/announce_sides_text with storage chess:runtime sides
