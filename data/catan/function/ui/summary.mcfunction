execute store result storage catan:ui side int 1 run scoreboard players get @s ca_side
function catan:ui/color_label
data modify storage catan:ui public set value {text:"",extra:[]}
data modify storage catan:ui phase set value "等待其他玩家操作。"
data modify storage catan:ui note set value {text:"",color:"aqua"}
data modify storage catan:ui title set value "卡坦岛 · 对局菜单"
data modify storage catan:ui columns set value 3
data modify storage catan:ui button_width set value 145
function catan:ui/private with storage catan:ui
execute as @e[tag=ca.current,limit=1] run function catan:ui/public
function catan:ui/phase
data modify storage catan:ui turn_name set value {text:"—",color:"gray"}
function catan:ui/turn_name with storage catan:ui
