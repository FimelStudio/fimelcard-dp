execute if score @s gm_animundo matches 1 run function gomoku:visual/refresh
execute unless score @s gm_animundo matches 1 run function gomoku:visual/finish_move
execute if score @s gm_result matches 1..3 run return run function gomoku:game/finish
execute unless score @s gm_animundo matches 1 run function gomoku:sound/move
scoreboard players set @s gm_animundo 0
scoreboard players set @s gm_state 1
function gomoku:clock/update
function gomoku:ui/refresh
