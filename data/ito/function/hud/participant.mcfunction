data modify storage fimel_title:io text set value {text:"",color:"white",shadow_color:0,extra:[]}
data modify storage fimel_title:io text.extra append value {text:"",extra:[]}
data modify storage fimel_title:io text.extra[0].extra append from entity @s data.name
execute if score @s it_seat matches 1 run data modify storage fimel_title:io text.extra[0].color set value "red"
execute if score @s it_seat matches 2 run data modify storage fimel_title:io text.extra[0].color set value "gold"
execute if score @s it_seat matches 3 run data modify storage fimel_title:io text.extra[0].color set value "yellow"
execute if score @s it_seat matches 4 run data modify storage fimel_title:io text.extra[0].color set value "green"
execute if score @s it_seat matches 5 run data modify storage fimel_title:io text.extra[0].color set value "aqua"
execute if score @s it_seat matches 6 run data modify storage fimel_title:io text.extra[0].color set value "blue"
execute if score @s it_seat matches 7 run data modify storage fimel_title:io text.extra[0].color set value "light_purple"
execute if score @s it_seat matches 8 run data modify storage fimel_title:io text.extra[0].color set value "white"
data modify storage fimel_title:io text.extra append value {text:"：",color:"white"}
scoreboard players operation #hud_owner it_ctx = @s it_seat
execute as @e[tag=it.cards,scores={it_owner=1..8,it_slot=1}] if score @s it_owner = #hud_owner it_ctx run function ito:hud/card
execute as @e[tag=it.cards,scores={it_owner=1..8,it_slot=2}] if score @s it_owner = #hud_owner it_ctx run function ito:hud/card
execute as @e[tag=it.cards,scores={it_owner=1..8,it_slot=3}] if score @s it_owner = #hud_owner it_ctx run function ito:hud/card
function ito:hud/text
