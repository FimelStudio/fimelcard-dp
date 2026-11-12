$data modify storage fimel_title:io text set value [{text:"    ",bold:false},{text:"剩余 $(seconds) 秒",color:"yellow"}]
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
data modify storage fimel_title:io x set value 24.0d
data modify storage fimel_title:io y set value -184.0d
data modify storage fimel_title:io dx set value 0.0d
data modify storage fimel_title:io dy set value 0.0d
data modify storage fimel_title:io align set value "left"
data modify storage fimel_title:io origin set value "up-left"
function fimel_title:new_text
