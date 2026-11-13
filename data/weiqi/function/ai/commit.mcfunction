function weiqi:system/context
execute unless score @s go_state matches 1 run return run function weiqi:ai/reset
execute unless score @s go_turn = @s go_bot run return run function weiqi:ai/reset
execute unless score @s go_aiepoch = @s go_epoch run return run function weiqi:ai/reset
execute if score @s go_aibest matches ..-1 run return run function weiqi:ai/pass
execute if score @s go_aiscore matches ..-100 run return run function weiqi:ai/pass
scoreboard players operation #to go_ctx = @s go_aibest
function weiqi:engine/try_move
execute unless score #legal go_ctx matches 1 run return run function weiqi:ai/pass
function weiqi:game/after_move
