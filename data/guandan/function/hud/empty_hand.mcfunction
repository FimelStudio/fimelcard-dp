data modify storage fimel_title:io text set value {text:"已出完手牌",color:"gray",shadow_color:0}
execute if score @e[tag=gd.current,limit=1] gd_state matches 1 run data modify storage fimel_title:io text.text set value "正在发牌…"
data modify storage fimel_title:io y set value 18.0d
function guandan:hud/text_default
