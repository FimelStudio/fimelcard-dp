function love_letter:input/context
execute unless entity @s[tag=ll.actor] run return 0
function love_letter:ui/begin
data modify storage love_letter:ui title set value "情书 · 公开牌与积分"
data modify storage love_letter:ui phase set value {text:"所有打出、被弃的牌均公开；未展示其他玩家的留牌。",color:"gray"}
data modify storage love_letter:ui rows set value {text:"双人局额外移出的明牌：",color:"gray",extra:[]}
function love_letter:ui/public_initial {index:0}
function love_letter:ui/public_initial {index:1}
function love_letter:ui/public_initial {index:2}
data modify storage love_letter:ui rows.extra append value {text:"\n"}
execute as @e[tag=ll.board,scores={ll_seat=1}] run function love_letter:ui/history_player
execute as @e[tag=ll.board,scores={ll_seat=2}] run function love_letter:ui/history_player
execute as @e[tag=ll.board,scores={ll_seat=3}] run function love_letter:ui/history_player
execute as @e[tag=ll.board,scores={ll_seat=4}] run function love_letter:ui/history_player
execute as @e[tag=ll.board,scores={ll_seat=5}] run function love_letter:ui/history_player
execute as @e[tag=ll.board,scores={ll_seat=6}] run function love_letter:ui/history_player
execute as @e[tag=ll.board,scores={ll_seat=7}] run function love_letter:ui/history_player
execute as @e[tag=ll.board,scores={ll_seat=8}] run function love_letter:ui/history_player
function love_letter:ui/button {code:1,label:"查看手牌",color:"green"}
function love_letter:ui/button {code:2,label:"对局菜单",color:"gray"}
function love_letter:ui/normalize
function love_letter:ui/show with storage love_letter:ui
