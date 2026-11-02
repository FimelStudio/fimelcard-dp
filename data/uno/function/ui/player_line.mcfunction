# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute at @s run function uno:name/resolve
data modify storage uno:ui line_name set value {text:"",color:"white",extra:[]}
data modify storage uno:ui line_name.extra append from storage uno:name resolved
execute store result storage uno:ui line_seat int 1 run scoreboard players get @s un_seat
execute store result storage uno:ui line_count int 1 run scoreboard players get @s un_count
execute store result storage uno:ui line_score int 1 run scoreboard players get @s un_score
data modify storage uno:ui line_turn set value ""
execute if score @s un_seat = @e[tag=un.current,limit=1] un_turn run data modify storage uno:ui line_turn set value " ▶"
function uno:ui/player_append with storage uno:ui
