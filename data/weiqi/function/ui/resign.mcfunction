# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless entity @e[tag=go.current,scores={go_state=1..2},limit=1] run return 0
function weiqi:ui/begin
data modify storage weiqi:ui phase set value "确认认输？"
function weiqi:ui/button {code:31,label:"确认认输",color:"red"}
function weiqi:ui/show with storage weiqi:ui
tag @a[tag=go.actor] remove go.actor
