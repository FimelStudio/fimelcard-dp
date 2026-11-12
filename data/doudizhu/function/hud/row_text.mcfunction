$data modify storage fimel_title:io text set value {text:"$(label)",color:"aqua",shadow_color:0,extra:[]}
execute unless score @e[tag=dd.current,limit=1] dd_lane matches 1..2 if score @s dd_team matches 1 run data modify storage fimel_title:io text.extra append value {text:"[橙队] ",color:"gold"}
execute unless score @e[tag=dd.current,limit=1] dd_lane matches 1..2 if score @s dd_team matches 2 run data modify storage fimel_title:io text.extra append value {text:"[青队] ",color:"aqua"}
execute if score @s dd_seat = #hud_out dd_ctx run data modify storage fimel_title:io text.extra append value {text:"[轮空] ",color:"gray"}
execute if score @e[tag=dd.current,limit=1] dd_lane matches 1..2 if score @s dd_team matches 1 run data modify storage fimel_title:io text.extra append value {text:"[红队] ",color:"red"}
execute if score @e[tag=dd.current,limit=1] dd_lane matches 1..2 if score @s dd_team matches 2 run data modify storage fimel_title:io text.extra append value {text:"[蓝队] ",color:"blue"}
# 地主和农民在叫分结束后显示。
execute if score @e[tag=dd.current,limit=1] dd_state matches 3..4 if score @e[tag=dd.current,limit=1] dd_lord matches 1..8 if score @s dd_seat = @e[tag=dd.current,limit=1] dd_lord run data modify storage fimel_title:io text.extra append value {text:"[地主] ",color:"gold"}
execute if score @e[tag=dd.current,limit=1] dd_state matches 3..4 if score @e[tag=dd.current,limit=1] dd_lord matches 1..8 unless score @s dd_seat = #hud_out dd_ctx unless score @s dd_seat = @e[tag=dd.current,limit=1] dd_lord run data modify storage fimel_title:io text.extra append value {text:"[农民] ",color:"green"}
data modify storage fimel_title:io text.extra append from storage doudizhu:hud name
function doudizhu:hud/countdown
$execute unless score @s dd_seat = #hud_out dd_ctx unless score @e[tag=dd.current,limit=1] dd_counts matches 0 run data modify storage fimel_title:io text.extra append value {text:"  剩余 $(count) 张",color:"yellow"}
