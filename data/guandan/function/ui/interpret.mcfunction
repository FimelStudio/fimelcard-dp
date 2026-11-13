# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function guandan:input/context
execute unless entity @s[tag=gd.actor] run return 0
function guandan:ui/begin
data modify storage guandan:ui title set value "掼蛋 · 选择牌型"
data modify storage guandan:ui phase set value {text:"选择本次出牌的牌型与比较点数。",color:"yellow"}
data modify storage guandan:ui options set from entity @e[tag=gd.current,limit=1] data.guandan.options
scoreboard players set #ui_option gd_ctx 0
function guandan:ui/option_next
function guandan:ui/button {code:1,label:"返回手牌",color:"gray"}
function guandan:ui/normalize
function guandan:ui/show with storage guandan:ui
