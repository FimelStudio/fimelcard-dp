# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function love_letter:ui/player_line
function love_letter:ui/history_card {index:0}
function love_letter:ui/history_card {index:1}
function love_letter:ui/history_card {index:2}
function love_letter:ui/history_card {index:3}
function love_letter:ui/history_card {index:4}
function love_letter:ui/history_card {index:5}
function love_letter:ui/history_card {index:6}
function love_letter:ui/history_card {index:7}
function love_letter:ui/history_card {index:8}
function love_letter:ui/history_card {index:9}
function love_letter:ui/history_card {index:10}
function love_letter:ui/history_card {index:11}
function love_letter:ui/history_card {index:12}
function love_letter:ui/history_card {index:13}
function love_letter:ui/history_card {index:14}
function love_letter:ui/history_card {index:15}
function love_letter:ui/history_card {index:16}
function love_letter:ui/history_card {index:17}
function love_letter:ui/history_card {index:18}
function love_letter:ui/history_card {index:19}
function love_letter:ui/history_card {index:20}
data modify storage love_letter:ui rows.extra append value {text:"\n"}
