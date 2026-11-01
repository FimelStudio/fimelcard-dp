data modify storage weiqi:runtime comparison set from storage weiqi:runtime candidates[0].board
execute store success score #different go_ctx run data modify storage weiqi:runtime comparison set from storage weiqi:runtime position.board
execute if score #different go_ctx matches 0 run scoreboard players set #legal go_ctx 0
execute if score #different go_ctx matches 0 run scoreboard players set #error go_ctx 4
data remove storage weiqi:runtime candidates[0]
execute if score #legal go_ctx matches 1 if data storage weiqi:runtime candidates[0] run function weiqi:engine/superko/compare
