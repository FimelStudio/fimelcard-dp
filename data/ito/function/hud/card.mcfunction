data modify storage fimel_title:io text set value {text:"",color:"white",shadow_color:0}
execute store result score #hud_length it_ctx run data get entity @s data.description
data modify storage fimel_title:io text.text set from entity @s data.description
execute if score #hud_length it_ctx matches 25.. run data modify storage fimel_title:io text.text set string entity @s data.description 0 24
execute if data entity @s {data:{description:""}} run data modify storage fimel_title:io text.text set value "（尚未描述）"
execute if score @s it_used matches 2.. run data modify storage fimel_title:io text.color set value "dark_gray"
function ito:hud/text
execute if score #hud_length it_ctx matches 25.. run data modify storage fimel_title:io text.text set string entity @s data.description 24
execute if score #hud_length it_ctx matches 25.. run function ito:hud/text

