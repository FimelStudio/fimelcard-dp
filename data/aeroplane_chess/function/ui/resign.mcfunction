function aeroplane_chess:ui/begin
function aeroplane_chess:ui/button {code:7,label:"确认认输"}
function aeroplane_chess:ui/button {code:8,label:"返回"}
data modify storage aeroplane_chess:ui status set value "认输后本方退出当前牌局"
execute store result storage aeroplane_chess:ui dice int 1 run scoreboard players get @e[tag=ac.current,limit=1] ac_roll
function aeroplane_chess:ui/color_name
function aeroplane_chess:ui/show with storage aeroplane_chess:ui
