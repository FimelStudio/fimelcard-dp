# 固化真实玩家名，避免把选择器原文发送到任何展示组件。
function uno:name/resolve
data modify storage uno:visual status_name set value {text:"",color:"white",extra:[]}
data modify storage uno:visual status_name.extra append from storage uno:name resolved
execute store result storage uno:visual status_seat int 1 run scoreboard players get @s un_seat
execute store result storage uno:visual status_count int 1 run scoreboard players get @s un_count
execute store result storage uno:visual status_score int 1 run scoreboard players get @s un_score
data modify storage uno:visual status_turn set value ""
execute if score @s un_seat = #vis_turn un_ctx run data modify storage uno:visual status_turn set value " ▶"
function uno:visual/status_append with storage uno:visual
