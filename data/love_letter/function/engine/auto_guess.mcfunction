scoreboard players operation #actor ll_ctx = @s ll_actor
execute store result score #guess ll_ctx run random value 0..8
execute if score #guess ll_ctx matches 1.. run scoreboard players add #guess ll_ctx 1
function love_letter:engine/guess
