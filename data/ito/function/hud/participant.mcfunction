data modify storage fimel_title:io text set from entity @s data.name
function ito:hud/text
scoreboard players operation #hud_owner it_ctx = @s it_seat
execute as @e[tag=it.cards,scores={it_owner=1..8}] if score @s it_owner = #hud_owner it_ctx run function ito:hud/card
