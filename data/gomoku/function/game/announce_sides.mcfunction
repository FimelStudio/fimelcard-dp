data modify storage gomoku:runtime sides.black set value {selector:"@a[tag=gm.audience,scores={gm_side=1}]"}
data modify storage gomoku:runtime sides.white set value {selector:"@a[tag=gm.audience,scores={gm_side=-1}]"}
execute if score @s gm_bot matches 1 if score @s gm_level matches 1 run data modify storage gomoku:runtime sides.black set value {text:"简单人机",color:"aqua"}
execute if score @s gm_bot matches -1 if score @s gm_level matches 1 run data modify storage gomoku:runtime sides.white set value {text:"简单人机",color:"aqua"}
execute if score @s gm_bot matches 1 if score @s gm_level matches 2 run data modify storage gomoku:runtime sides.black set value {text:"普通人机",color:"aqua"}
execute if score @s gm_bot matches -1 if score @s gm_level matches 2 run data modify storage gomoku:runtime sides.white set value {text:"普通人机",color:"aqua"}
execute if score @s gm_bot matches 1 if score @s gm_level matches 3 run data modify storage gomoku:runtime sides.black set value {text:"困难人机",color:"aqua"}
execute if score @s gm_bot matches -1 if score @s gm_level matches 3 run data modify storage gomoku:runtime sides.white set value {text:"困难人机",color:"aqua"}
function gomoku:game/announce_sides_text with storage gomoku:runtime sides
