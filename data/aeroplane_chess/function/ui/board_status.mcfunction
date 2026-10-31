function aeroplane_chess:ui/color_name
data modify storage aeroplane_chess:status color set from storage aeroplane_chess:ui color
execute store result storage aeroplane_chess:status dice int 1 run scoreboard players get @s ac_roll
data modify storage aeroplane_chess:status phase set value "等待投骰"
execute if score @s ac_state matches 2 run data modify storage aeroplane_chess:status phase set value "投骰中"
execute if score @s ac_state matches 3 run data modify storage aeroplane_chess:status phase set value "选择飞机"
execute if score @s ac_state matches 4 run data modify storage aeroplane_chess:status phase set value "飞机移动中"
execute if score @s ac_state matches 6 run data modify storage aeroplane_chess:status phase set value "撞机返航中"
execute if score @s ac_state matches 5 run data modify storage aeroplane_chess:status phase set value "对局结束"
function aeroplane_chess:ui/board_status_show with storage aeroplane_chess:status
