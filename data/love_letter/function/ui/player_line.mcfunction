data modify storage love_letter:ui line_name set from entity @s data.ll_name
execute store result storage love_letter:ui line_seat int 1 run scoreboard players get @s ll_seat
execute store result storage love_letter:ui line_points int 1 run scoreboard players get @s ll_points
data modify storage love_letter:ui line_status set value ""
execute if score @s ll_alive matches 0 run data modify storage love_letter:ui line_status set value " · 已淘汰"
execute if score @s ll_protect matches 1 run data modify storage love_letter:ui line_status set value " · 保护"
execute if score @s ll_seat = @e[tag=ll.current,limit=1] ll_turn if score @s ll_alive matches 1 run data modify storage love_letter:ui line_status set value " ▶"
function love_letter:ui/player_append with storage love_letter:ui
