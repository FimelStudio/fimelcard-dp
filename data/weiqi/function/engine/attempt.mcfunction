function weiqi:engine/constants
scoreboard players set #legal go_ctx 0
scoreboard players set #error go_ctx 1
scoreboard players set #captured go_ctx 0
scoreboard players operation #side go_ctx = @s go_turn
execute unless score #side go_ctx matches -1 unless score #side go_ctx matches 1 run return 0
execute unless score #to go_ctx matches 0..360 run return 0
execute store result storage weiqi:runtime move.sq int 1 run scoreboard players get #to go_ctx
function weiqi:engine/attempt_at with storage weiqi:runtime move
