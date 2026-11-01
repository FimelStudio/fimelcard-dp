function love_letter:system/context
scoreboard players operation #actor ll_ctx = @s ll_turn
scoreboard players set #slot ll_ctx 0
scoreboard players set #auto_hand ll_ctx -1
scoreboard players set #auto_extra ll_ctx -1
execute as @e[tag=ll.board,scores={ll_alive=1}] if score @s ll_seat = #actor ll_ctx run scoreboard players operation #auto_hand ll_ctx = @s ll_hand
execute as @e[tag=ll.board,scores={ll_alive=1}] if score @s ll_seat = #actor ll_ctx run scoreboard players operation #auto_extra ll_ctx = @s ll_extra
execute if score #auto_extra ll_ctx matches 8 if score #auto_hand ll_ctx matches 5 run scoreboard players set #slot ll_ctx 1
execute if score #auto_extra ll_ctx matches 8 if score #auto_hand ll_ctx matches 7 run scoreboard players set #slot ll_ctx 1
function love_letter:engine/play
