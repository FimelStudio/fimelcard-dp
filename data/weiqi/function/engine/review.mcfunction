scoreboard players set #ok go_ctx 0
execute unless score #frame go_ctx matches 0.. run return 0
execute store result storage weiqi:runtime review.frame int 1 run scoreboard players get #frame go_ctx
function weiqi:engine/review_at with storage weiqi:runtime review
