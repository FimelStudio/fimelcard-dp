# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
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
function catan:ui/guidance
data modify storage catan:ui turn_name set value {text:"—",color:"gray"}
function catan:ui/turn_name with storage catan:ui
