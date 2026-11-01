function weiqi:game/review_guard
execute unless score #review_ok go_ctx matches 1 run return 0
scoreboard players set @s go_state 5
scoreboard players add @s go_autoplay 1
execute if score @s go_autoplay matches 2.. run scoreboard players set @s go_autoplay 0
scoreboard players set @s go_timer 0
scoreboard players add @s go_epoch 1
function weiqi:ui/refresh
