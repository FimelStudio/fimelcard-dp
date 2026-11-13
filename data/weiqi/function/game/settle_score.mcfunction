function weiqi:engine/score
scoreboard players set @s go_result 3
execute if score @s go_bscore > @s go_wscore run scoreboard players set @s go_result 1
execute if score @s go_wscore > @s go_bscore run scoreboard players set @s go_result 2
scoreboard players set @s go_reason 1
function weiqi:game/finish
