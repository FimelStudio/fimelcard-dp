function magical_athlete:hud/activate
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text set value {"text":"胡闹运动会","color":"gold","bold":false}
function magical_athlete:hud/line {x:8,y:-8,origin:"left_top",align:"left"}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.p1.name run function magical_athlete:hud/row {"side":1,"x":8,"y":-24,"y2":-36,"y3":-48,"origin":"left_top","align":"left"}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.p2.name run function magical_athlete:hud/row {"side":2,"x":-8,"y":-24,"y2":-36,"y3":-48,"origin":"right_top","align":"right"}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.p3.name run function magical_athlete:hud/row {"side":3,"x":8,"y":-64,"y2":-76,"y3":-88,"origin":"left_top","align":"left"}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.p4.name run function magical_athlete:hud/row {"side":4,"x":-8,"y":-64,"y2":-76,"y3":-88,"origin":"right_top","align":"right"}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.p5.name run function magical_athlete:hud/row {"side":5,"x":8,"y":-104,"y2":-116,"y3":-128,"origin":"left_top","align":"left"}
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete.p6.name run function magical_athlete:hud/row {"side":6,"x":-8,"y":-104,"y2":-116,"y3":-128,"origin":"right_top","align":"right"}
execute if score @s ma_htimer matches 1.. run function magical_athlete:hud/show_notice
execute unless score @s ma_htimer matches 1.. run function magical_athlete:hud/status
scoreboard players operation panel_id fbt_io = @s ma_hpanel
function fimel_title:replace_panel
execute unless entity @s[tag=fimel.anim_text.replace.actionbar] run tag @s add ma.owns_hud
tag @s add fimel.anim_text.replace.actionbar
function fimel_title:use_panel
