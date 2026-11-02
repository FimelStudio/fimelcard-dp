# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function guandan:input/context
execute unless entity @s[tag=gd.actor] run return 0
function guandan:ui/begin
data modify storage guandan:ui title set value "掼蛋 · 对局菜单"
data modify storage guandan:ui phase set value {text:"",color:"gray"}
function guandan:ui/players
function guandan:ui/button {code:1,label:"手牌与贡还牌",color:"green"}
function guandan:ui/button {code:3,label:"查看规则",color:"aqua"}
function guandan:ui/normalize
function guandan:ui/show with storage guandan:ui
