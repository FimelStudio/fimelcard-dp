data modify storage fimel_title:io text set value {text:"情书 · ",color:"gold",shadow_color:0,extra:[]}
execute if score @e[tag=ll.current,limit=1] ll_state matches 1 run data modify storage fimel_title:io text.extra append value {text:"正在发牌",color:"yellow"}
execute if score @e[tag=ll.current,limit=1] ll_state matches 2 if score @s ll_seat = @e[tag=ll.current,limit=1] ll_turn run data modify storage fimel_title:io text.extra append value {text:"轮到你",color:"green"}
execute if score @e[tag=ll.current,limit=1] ll_state matches 2 unless score @s ll_seat = @e[tag=ll.current,limit=1] ll_turn run data modify storage fimel_title:io text.extra append value {text:"等待出牌",color:"gray"}
execute if entity @e[tag=ll.hud_part,scores={ll_alive=0},limit=1] run data modify storage fimel_title:io text.extra append value {text:" · 本轮已淘汰",color:"red"}
execute if entity @e[tag=ll.hud_part,scores={ll_alive=1,ll_protect=1},limit=1] run data modify storage fimel_title:io text.extra append value {text:" · 保护中",color:"aqua"}
execute if score @e[tag=ll.current,limit=1] ll_state matches 3 run data modify storage fimel_title:io text.extra append value {text:"本轮结算",color:"yellow"}
execute if score @e[tag=ll.current,limit=1] ll_state matches 4 run data modify storage fimel_title:io text.extra append value {text:"整场结束",color:"yellow"}
data modify storage fimel_title:io text.extra append value {text:" · ",color:"dark_gray"}
execute store result storage love_letter:hud points int 1 run scoreboard players get @e[tag=ll.hud_part,limit=1] ll_points
function love_letter:hud/points with storage love_letter:hud
execute if score @e[tag=ll.current,limit=1] ll_state matches 2 if score @e[tag=ll.current,limit=1] ll_time_setting matches 1.. run function love_letter:hud/clock
data modify storage fimel_title:io y set value 84.0d
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
function love_letter:hud/text
