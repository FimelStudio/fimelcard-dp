data modify storage guandan:ui line_name set value {text:"玩家"}
data modify storage guandan:ui line_name set from entity @s data.gd_name
execute store result storage guandan:ui line_seat int 1 run scoreboard players get @s gd_seat
execute store result storage guandan:ui line_team int 1 run scoreboard players get @s gd_team
data modify storage guandan:ui line_count set value ""
execute if entity @e[tag=gd.current,scores={gd_show=1},limit=1] run function guandan:ui/player_count
data modify storage guandan:ui line_status set value ""
execute if score @s gd_rank matches 1 run data modify storage guandan:ui line_status set value " · 头游"
execute if score @s gd_rank matches 2 run data modify storage guandan:ui line_status set value " · 二游"
execute if score @s gd_rank matches 3 run data modify storage guandan:ui line_status set value " · 三游"
execute if score @s gd_rank matches 4 run data modify storage guandan:ui line_status set value " · 末游"
execute if score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn if score @e[tag=gd.current,limit=1] gd_state matches 3 run data modify storage guandan:ui line_status set value " ▶"
function guandan:ui/player_append with storage guandan:ui
