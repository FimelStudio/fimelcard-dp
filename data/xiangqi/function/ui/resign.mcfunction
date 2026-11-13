# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 认输在行棋和动画阶段均可使用；始终经过确认按钮。
function xiangqi:ui/begin
data modify storage xiangqi:ui phase set value "确认认输？"
function xiangqi:ui/button {code:1,label:"确认认输",color:"red"}
function xiangqi:ui/show with storage xiangqi:ui
tag @a[tag=xq.actor] remove xq.actor
