data modify storage ito:hud answer set value {text:"",color:"white",extra:[{text:"["},{text:""},{text:"]"}]}
data modify storage ito:hud answer.extra[1].text set from entity @s data.description
execute if data entity @s {data:{description:""}} run data modify storage ito:hud answer.extra[1].text set value "尚未描述"
execute if score @s it_used matches 2.. run data modify storage ito:hud answer.color set value "dark_gray"
data modify storage fimel_title:io text.extra append from storage ito:hud answer
