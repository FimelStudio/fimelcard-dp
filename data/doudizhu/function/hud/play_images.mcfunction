# 图片字形不指定子组件字体，正向和回退字体由title统一切换。
data modify storage title:io font set value "card:doudizhu/hud"
data modify storage title:io neg_font set value "card:doudizhu/hud_neg"
data modify storage title:io text set value {text:"本轮：",color:"gray",shadow_color:0,extra:[]}
execute unless data storage doudizhu:hud shown_play.extra[0] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play
execute if data storage doudizhu:hud shown_play.extra[0] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[0]
execute if data storage doudizhu:hud shown_play.extra[1] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[1]
execute if data storage doudizhu:hud shown_play.extra[2] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[2]
execute if data storage doudizhu:hud shown_play.extra[3] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[3]
execute if data storage doudizhu:hud shown_play.extra[4] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[4]
execute if data storage doudizhu:hud shown_play.extra[5] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[5]
execute if data storage doudizhu:hud shown_play.extra[6] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[6]
execute if data storage doudizhu:hud shown_play.extra[7] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[7]
execute if data storage doudizhu:hud shown_play.extra[8] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[8]
execute if data storage doudizhu:hud shown_play.extra[9] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[9]
data modify storage title:io dy set value -20.0d
function title:new_text
execute unless data storage doudizhu:hud shown_play.extra[10] run return 0
data modify storage title:io text set value {text:"",color:"white",shadow_color:0,extra:[]}
execute if data storage doudizhu:hud shown_play.extra[10] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[10]
execute if data storage doudizhu:hud shown_play.extra[11] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[11]
execute if data storage doudizhu:hud shown_play.extra[12] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[12]
execute if data storage doudizhu:hud shown_play.extra[13] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[13]
execute if data storage doudizhu:hud shown_play.extra[14] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[14]
execute if data storage doudizhu:hud shown_play.extra[15] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[15]
execute if data storage doudizhu:hud shown_play.extra[16] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[16]
execute if data storage doudizhu:hud shown_play.extra[17] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[17]
execute if data storage doudizhu:hud shown_play.extra[18] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[18]
execute if data storage doudizhu:hud shown_play.extra[19] run data modify storage title:io text.extra append from storage doudizhu:hud shown_play.extra[19]
data modify storage title:io dy set value -28.0d
function title:new_text
