execute if score @s go_bot matches 0 run return 0
execute unless score @s go_turn = @s go_bot run return 0
execute unless score @s go_state matches 1 run return 0
execute if score @s go_aistate matches 0 run return run function weiqi:ai/start
execute unless score @s go_aiepoch = @s go_epoch run return run function weiqi:ai/reset
execute if score @s go_aistate matches 2 run return run function weiqi:ai/commit
scoreboard players add @s go_aiwait 1
execute if score @s go_aiwait matches ..10 run return 0
function weiqi:system/context
execute if score @s go_passes matches 1.. run return run function weiqi:ai/pass
function weiqi:ai/probe
