data modify storage fimel_title:io font set value "card:splendor/hud"
data modify storage fimel_title:io neg_font set value "card:splendor/hud_neg"
$data modify storage fimel_title:io x set value $(x)d
$data modify storage fimel_title:io y set value $(y)d
$data modify storage fimel_title:io origin set value "$(origin)"
$data modify storage fimel_title:io align set value "$(align)"
data modify storage fimel_title:io dx set value 0.0d
data modify storage fimel_title:io dy set value 0.0d
function fimel_title:new_text
