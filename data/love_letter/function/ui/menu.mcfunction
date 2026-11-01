function love_letter:input/context
execute unless entity @s[tag=ll.actor] run return 0
function love_letter:ui/begin
data modify storage love_letter:ui title set value "情书 · 对局菜单"
data modify storage love_letter:ui phase set value {text:"",color:"gray"}
function love_letter:ui/players
function love_letter:ui/button {code:1,label:"查看手牌",color:"green"}
function love_letter:ui/button {code:3,label:"公开牌与积分",color:"aqua"}
function love_letter:ui/button {code:4,label:"查看规则",color:"yellow"}
execute if entity @e[tag=ll.me,scores={ll_alive=1},limit=1] if entity @e[tag=ll.current,scores={ll_state=2},limit=1] run function love_letter:ui/button {code:5,label:"本轮认输",color:"red"}
function love_letter:ui/normalize
function love_letter:ui/show with storage love_letter:ui
