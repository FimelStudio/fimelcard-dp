execute unless entity @e[tag=sp.current,limit=1] run return 0
execute unless score @s sp_table = @e[tag=sp.current,limit=1] ct_id run return 0
execute unless entity @s[tag=sp.hud] run function splendor:hud/activate
execute if entity @s[tag=sp.owns_hud] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove sp.owns_hud
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
data modify storage splendor:hud anchor set value {x:8,origin:"up-left",align:"left"}
scoreboard players set #hud_y sp_ctx -8
data modify storage fimel_title:io text set value {text:"璀璨宝石",color:"gold",bold:false,shadow_color:0}
function splendor:hud/text
execute if data entity @e[tag=sp.current,limit=1] data.splendor.p1.name run function splendor:hud/row {"side":1,"x":8,"y":-24,"origin":"up-left","align":"left"}
execute if data entity @e[tag=sp.current,limit=1] data.splendor.p2.name run function splendor:hud/row {"side":2,"x":-8,"y":-24,"origin":"up-right","align":"right"}
execute if data entity @e[tag=sp.current,limit=1] data.splendor.p3.name run function splendor:hud/row {"side":3,"x":8,"y":-80,"origin":"up-left","align":"left"}
execute if data entity @e[tag=sp.current,limit=1] data.splendor.p4.name run function splendor:hud/row {"side":4,"x":-8,"y":-80,"origin":"up-right","align":"right"}
execute if score @s sp_htimer matches 1.. run function splendor:hud/show_notice
execute unless score @s sp_htimer matches 1.. run function splendor:hud/status with entity @e[tag=sp.current,limit=1] data.splendor
scoreboard players operation panel_id fbt_io = @s sp_hpanel
function fimel_title:replace_panel
scoreboard players operation @s fbt_panel = @s sp_hpanel
