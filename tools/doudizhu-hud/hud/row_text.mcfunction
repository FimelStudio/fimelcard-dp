$data modify storage title:io text set value {text:"$(label)",color:"aqua",shadow_color:0,extra:[]}
data modify storage title:io text.extra append from storage doudizhu:hud name
$data modify storage title:io text.extra append value {text:"  剩余 $(count) 张",color:"yellow"}
