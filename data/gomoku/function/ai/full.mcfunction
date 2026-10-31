scoreboard players set @s gm_aistate 0
function gomoku:engine/evaluate
execute if score @s gm_result matches 0 run function gomoku:engine/invalid
function gomoku:game/finish
