$data modify storage fimel_title:io text set from storage uno:hud rows[$(row)].cards
# 每种牌的全部层共用X坐标，下一种牌在完整牌面之后留3px间距。
data modify storage fimel_title:io text.extra append value {text:""}
$data modify storage fimel_title:io y set value $(y).0d
function uno:hud/text_cards
