execute if score #found lh_ctx matches 1 run return 0
scoreboard players add @s lh_turn 1
execute if score @s lh_turn matches 9.. run scoreboard players set @s lh_turn 1
scoreboard players operation #target_seat lh_ctx = @s lh_turn
execute as @a[tag=lh.turn_candidate] if score @s lh_seat = #target_seat lh_ctx run tag @s add lh.turn
execute as @a[tag=lh.turn,tag=lh.turn_candidate] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set #found lh_ctx 1
