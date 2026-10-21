$data modify storage fimel_title:io text set value {text:"$(label)",color:"aqua",shadow_color:0,extra:[]}
# Roles are final only after bidding; @s is the displayed player or bot.
execute if score @e[tag=dd.current,limit=1] dd_state matches 3..4 if score @s dd_seat = @e[tag=dd.current,limit=1] dd_lord run data modify storage fimel_title:io text.extra append value {text:"[地主] ",color:"gold"}
execute if score @e[tag=dd.current,limit=1] dd_state matches 3..4 unless score @s dd_seat = @e[tag=dd.current,limit=1] dd_lord run data modify storage fimel_title:io text.extra append value {text:"[农民] ",color:"green"}
data modify storage fimel_title:io text.extra append from storage doudizhu:hud name
$execute unless score @e[tag=dd.current,limit=1] dd_counts matches 0 run data modify storage fimel_title:io text.extra append value {text:"  剩余 $(count) 张",color:"yellow"}
