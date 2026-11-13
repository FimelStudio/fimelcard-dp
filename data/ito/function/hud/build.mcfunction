execute unless entity @s[tag=it.hud] run function ito:hud/activate
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
data modify storage fimel_title:io x set value 8.0d
data modify storage fimel_title:io y set value -12.0d
data modify storage fimel_title:io origin set value "up-left"
data modify storage fimel_title:io align set value "left"
execute as @e[tag=it.parts,scores={it_order=0}] run function ito:hud/participant
execute as @e[tag=it.parts,scores={it_order=1}] run function ito:hud/participant
execute as @e[tag=it.parts,scores={it_order=2}] run function ito:hud/participant
execute as @e[tag=it.parts,scores={it_order=3}] run function ito:hud/participant
execute as @e[tag=it.parts,scores={it_order=4}] run function ito:hud/participant
execute as @e[tag=it.parts,scores={it_order=5}] run function ito:hud/participant
execute as @e[tag=it.parts,scores={it_order=6}] run function ito:hud/participant
execute as @e[tag=it.parts,scores={it_order=7}] run function ito:hud/participant
data modify storage fimel_title:io x set value 0.0d
data modify storage fimel_title:io y set value 8.0d
data modify storage fimel_title:io origin set value "default"
data modify storage fimel_title:io align set value "middle"
data modify storage fimel_title:io text set value {text:"正在随机抽取主题",color:"gold",shadow_color:0}
execute unless score @e[tag=it.current,limit=1] it_state matches 1 run data modify storage fimel_title:io text.text set from entity @e[tag=it.current,limit=1] data.ito.theme.question
function ito:hud/text
scoreboard players operation panel_id fbt_io = @s it_panel
function fimel_title:replace_panel
scoreboard players operation @s fbt_panel = @s it_panel
