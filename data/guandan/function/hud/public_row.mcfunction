execute store result storage guandan:hud public_count int 1 run scoreboard players get @s gd_count
function guandan:hud/public_label with storage guandan:hud
data modify storage fimel_title:io text.extra append from entity @s data.gd_name
execute if score @e[tag=gd.current,limit=1] gd_show matches 1 run function guandan:hud/public_count with storage guandan:hud
execute if score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run data modify storage fimel_title:io text.extra append value {text:" ◀",color:"green"}
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
data modify storage fimel_title:io dx set value 0.0d
data modify storage fimel_title:io dy set value 0.0d
function fimel_title:new_text
data modify storage fimel_title:io text set value {text:"本轮：",color:"gray",shadow_color:0,extra:[]}
data modify storage guandan:hud shown set from entity @s data.last_play
execute unless data storage guandan:hud shown[0] run data modify storage fimel_title:io text.extra append value {text:"尚未出牌"}
function guandan:hud/public_cards
data modify storage fimel_title:io font set value "card:guandan/public"
data modify storage fimel_title:io neg_font set value "card:guandan/public_neg"
data modify storage fimel_title:io dy set value -20.0d
function fimel_title:new_text
execute unless data entity @s data.last_play[0] run return 0
data modify storage fimel_title:io text set value {text:"",color:"gray",shadow_color:0}
# Resolve the label now, not later in the viewer context.
data modify storage fimel_title:io text.text set from entity @s data.last_label
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
data modify storage fimel_title:io dy set value -22.0d
function fimel_title:new_text
