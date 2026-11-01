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
