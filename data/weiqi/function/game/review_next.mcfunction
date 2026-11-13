function weiqi:game/review_guard
execute unless score #review_ok go_ctx matches 1 run return 0
scoreboard players set @s go_autoplay 0
function weiqi:game/review_advance
