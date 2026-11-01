execute if score @s ll_state matches 3..4 run return 0
function love_letter:system/context
function love_letter:engine/score_round
scoreboard players set @s ll_state 3
scoreboard players set @s ll_timer 120
scoreboard players set @s ll_anim 0
scoreboard players set @s ll_clock 0
function love_letter:game/bump_epoch
tellraw @a[tag=ll.audience] {text:"[情书] 本轮结束。",color:"gold"}
execute as @e[tag=ll.board,scores={ll_won=1}] run function love_letter:game/round_winner
execute as @e[tag=ll.board,scores={ll_bonus=1}] run function love_letter:game/spy_winner
execute as @e[tag=ll.board,scores={ll_alive=1}] run function love_letter:game/showdown
scoreboard players operation #goal ll_ctx = @s ll_goal
scoreboard players set @e[tag=ll.board] ll_matchwin 0
execute as @e[tag=ll.board] if score @s ll_points >= #goal ll_ctx run scoreboard players set @s ll_matchwin 1
execute if entity @e[tag=ll.board,scores={ll_matchwin=1}] run function love_letter:game/match_over
execute if score @s ll_state matches 3 run function love_letter:sound/round_win
function love_letter:visual/refresh
function love_letter:hud/refresh
function love_letter:ui/refresh
