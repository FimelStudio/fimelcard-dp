$data modify storage fimel_title:io text set value {text:"$(label)",color:"gold",shadow_color:0}
$data modify storage fimel_title:io x set value $(x)
data modify storage fimel_title:io y set value -12.0d
function fimel_title:new_text
$data modify storage fimel_title:io text set value {text:"$(count)",color:"white",shadow_color:0}
$data modify storage fimel_title:io x set value $(x)
data modify storage fimel_title:io y set value -26.0d
function fimel_title:new_text
