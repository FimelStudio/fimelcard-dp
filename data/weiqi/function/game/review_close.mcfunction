function weiqi:game/review_guard
execute unless score #review_ok go_ctx matches 1 run return 0
execute store result score @s go_review run data get entity @s data.weiqi.history
scoreboard players remove @s go_review 1
scoreboard players set @s go_state 0
scoreboard players set @s go_autoplay 0
scoreboard players add @s go_epoch 1
function weiqi:game/review_render
