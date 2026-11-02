# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function love_letter:ui/begin
data modify storage love_letter:ui title set value "情书 · 本轮认输"
data modify storage love_letter:ui phase set value {text:"确认退出本轮？下轮仍可继续。",color:"yellow"}
function love_letter:ui/button {code:6,label:"确认认输",color:"red"}
function love_letter:ui/button {code:2,label:"返回",color:"gray"}
function love_letter:ui/normalize
function love_letter:ui/show with storage love_letter:ui
