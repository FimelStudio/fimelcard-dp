execute if score @s ll_state matches 4 run return 0
scoreboard players set @s ll_state 4
scoreboard players set @s ll_timer 120
execute as @e[tag=ll.board,scores={ll_matchwin=1}] run function love_letter:game/match_winner
function love_letter:sound/end
function love_letter:log {text:"情书整场结束，所有达到目标者共同获胜"}
