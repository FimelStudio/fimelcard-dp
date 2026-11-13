function love_letter:system/context
scoreboard players operation #old_turn ll_ctx = @s ll_turn
scoreboard players set #next ll_ctx 99
execute as @e[tag=ll.board,scores={ll_alive=1}] if score @s ll_seat > #old_turn ll_ctx run scoreboard players operation #next ll_ctx < @s ll_seat
execute if score #next ll_ctx matches 99 as @e[tag=ll.board,scores={ll_alive=1}] run scoreboard players operation #next ll_ctx < @s ll_seat
execute if score #next ll_ctx matches 99 run return run function love_letter:game/abort
scoreboard players operation @s ll_turn = #next ll_ctx
function love_letter:game/begin_turn
