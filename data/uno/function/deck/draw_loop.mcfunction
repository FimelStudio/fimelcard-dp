function uno:deck/take
execute if score #draw_idx un_ctx matches 0 run return fail
scoreboard players add #draw_actual un_ctx 1
scoreboard players remove #draw_left un_ctx 1
execute if score #draw_left un_ctx matches 1.. run function uno:deck/draw_loop
