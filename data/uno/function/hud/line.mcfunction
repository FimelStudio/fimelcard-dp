$data modify storage fimel_title:io text set from storage uno:hud rows[$(row)].cards
# 交叠行最后一张保留完整牌面宽度，避免居中时偏右或裁掉末牌。
data modify storage fimel_title:io text.extra append value {text:""}
$data modify storage fimel_title:io y set value $(y).0d
function uno:hud/text_cards
$data modify storage fimel_title:io text set from storage uno:hud rows[$(row)].counts
data modify storage fimel_title:io text.extra prepend value {text:""}
data modify storage fimel_title:io text.extra append value {text:""}
$data modify storage fimel_title:io y set value $(count_y).0d
function uno:hud/text_cards
