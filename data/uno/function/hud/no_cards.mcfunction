data modify storage fimel_title:io text set value {text:"暂无手牌",color:"gray",shadow_color:0}
execute if score @e[tag=un.current,limit=1] un_state matches 1 run data modify storage fimel_title:io text.text set value "正在发牌…"
data modify storage fimel_title:io y set value 12.0d
function uno:hud/text_default
