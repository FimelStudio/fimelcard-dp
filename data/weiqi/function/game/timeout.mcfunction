scoreboard players set @s go_result 1
execute if score @s go_turn matches 1 run scoreboard players set @s go_result 2
scoreboard players set @s go_reason 6
function weiqi:game/finish
