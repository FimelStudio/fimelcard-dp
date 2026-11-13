execute if score @s ll_state matches 4 run return 0
scoreboard players set @s ll_state 4
scoreboard players set @s ll_timer 120
data modify storage cardtable:result names set value {text:"",extra:[]}
execute as @e[tag=ll.board,scores={ll_matchwin=1}] run function love_letter:game/match_winner
function cardtable:game/result/title {audience:"@a[tag=ll.audience]",title:{text:"最终胜利者",color:"gold",bold:true},subtitle:{nbt:"names",storage:"cardtable:result",interpret:true}}
function love_letter:sound/end
function love_letter:log {text:"情书整场结束，所有达到目标者共同获胜"}
