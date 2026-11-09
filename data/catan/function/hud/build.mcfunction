function catan:hud/activate
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text set value {"text":"卡坦岛","color":"gold","bold":false}
function catan:hud/line {x:8,y:-8,origin:"left_top",align:"left"}
execute if data entity @e[tag=ca.current,limit=1] data.catan.p1.name run function catan:hud/row {"side":1,"x":8,"y":-24,"y2":-36,"y3":-48,"origin":"left_top","align":"left"}
execute if data entity @e[tag=ca.current,limit=1] data.catan.p2.name run function catan:hud/row {"side":2,"x":-8,"y":-24,"y2":-36,"y3":-48,"origin":"right_top","align":"right"}
execute if data entity @e[tag=ca.current,limit=1] data.catan.p3.name run function catan:hud/row {"side":3,"x":8,"y":-64,"y2":-76,"y3":-88,"origin":"left_top","align":"left"}
execute if data entity @e[tag=ca.current,limit=1] data.catan.p4.name run function catan:hud/row {"side":4,"x":-8,"y":-64,"y2":-76,"y3":-88,"origin":"right_top","align":"right"}
execute if score @s ca_htimer matches 1.. run function catan:hud/show_notice
execute unless score @s ca_htimer matches 1.. run function catan:hud/status
scoreboard players operation panel_id fbt_io = @s ca_hpanel
function fimel_title:replace_panel
execute unless entity @s[tag=fimel.anim_text.replace.actionbar] run tag @s add ca.owns_hud
tag @s add fimel.anim_text.replace.actionbar
function fimel_title:use_panel
