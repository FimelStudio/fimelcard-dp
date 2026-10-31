function aeroplane_chess:input/context
execute unless entity @s[tag=ac.actor] run return 0
function aeroplane_chess:ui/begin
data modify storage aeroplane_chess:ui status set value "等待其他玩家"
execute if score @e[tag=ac.current,limit=1] ac_state matches 2 run data modify storage aeroplane_chess:ui status set value "投骰中"
execute if score @e[tag=ac.current,limit=1] ac_state matches 4 run data modify storage aeroplane_chess:ui status set value "飞机移动中"
execute if score @e[tag=ac.current,limit=1] ac_state matches 6 run data modify storage aeroplane_chess:ui status set value "撞机返航中"
execute if score @e[tag=ac.current,limit=1] ac_state matches 5 run data modify storage aeroplane_chess:ui status set value "对局结束"
execute if score @s ac_color = @e[tag=ac.current,limit=1] ac_turn if score @e[tag=ac.current,limit=1] ac_state matches 1 run function aeroplane_chess:ui/button {code:1,label:"投骰"}
execute if score @s ac_color = @e[tag=ac.current,limit=1] ac_turn if score @e[tag=ac.current,limit=1] ac_state matches 1 run data modify storage aeroplane_chess:ui status set value "轮到你投骰"
execute if score @s ac_color = @e[tag=ac.current,limit=1] ac_turn if score @e[tag=ac.current,limit=1] ac_state matches 3 run function aeroplane_chess:ui/planes
execute if score @e[tag=ac.current,limit=1] ac_state matches 1..4 run function aeroplane_chess:ui/button {code:6,label:"认输"}
execute if score @e[tag=ac.current,limit=1] ac_state matches 6 run function aeroplane_chess:ui/button {code:6,label:"认输"}
execute store result storage aeroplane_chess:ui dice int 1 run scoreboard players get @e[tag=ac.current,limit=1] ac_roll
function aeroplane_chess:ui/color_name
execute if data storage aeroplane_chess:ui buttons[0] run return run function aeroplane_chess:ui/show with storage aeroplane_chess:ui
function aeroplane_chess:ui/notice with storage aeroplane_chess:ui
