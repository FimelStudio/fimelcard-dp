# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 认输在行棋和动画阶段均可使用；始终经过确认按钮。
function gomoku:ui/begin
data modify storage gomoku:ui phase set value "确认认输？"
function gomoku:ui/button {code:1,label:"确认认输",color:"red"}
function gomoku:ui/show with storage gomoku:ui
tag @a[tag=gm.actor] remove gm.actor
