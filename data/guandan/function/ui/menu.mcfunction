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
