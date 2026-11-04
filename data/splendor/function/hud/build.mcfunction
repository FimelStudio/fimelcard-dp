execute unless entity @s[tag=sp.hud] run function splendor:hud/activate
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
data modify storage fimel_title:io x set value 8.0d
data modify storage fimel_title:io y set value -12.0d
data modify storage fimel_title:io origin set value "up-left"
data modify storage fimel_title:io align set value "left"
execute if data entity @e[tag=sp.current,limit=1] data.splendor.p1.name unless score @s sp_side matches 1 run function splendor:hud/row with entity @e[tag=sp.current,limit=1] data.splendor.p1
execute if data entity @e[tag=sp.current,limit=1] data.splendor.p2.name unless score @s sp_side matches 2 run function splendor:hud/row with entity @e[tag=sp.current,limit=1] data.splendor.p2
execute if data entity @e[tag=sp.current,limit=1] data.splendor.p3.name unless score @s sp_side matches 3 run function splendor:hud/row with entity @e[tag=sp.current,limit=1] data.splendor.p3
execute if data entity @e[tag=sp.current,limit=1] data.splendor.p4.name unless score @s sp_side matches 4 run function splendor:hud/row with entity @e[tag=sp.current,limit=1] data.splendor.p4
data modify storage fimel_title:io x set value 0.0d
data modify storage fimel_title:io y set value 8.0d
data modify storage fimel_title:io origin set value "default"
data modify storage fimel_title:io align set value "middle"
function splendor:game/hud_show with entity @e[tag=sp.current,limit=1] data.splendor
scoreboard players operation panel_id fbt_io = @s sp_hpanel
function fimel_title:replace_panel
scoreboard players operation @s fbt_panel = @s sp_hpanel
