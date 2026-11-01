scoreboard players set #ok go_ctx 0
execute unless score #to go_ctx matches 0..360 run return 0
execute store result storage weiqi:runtime dead.sq int 1 run scoreboard players get #to go_ctx
function weiqi:engine/toggle_dead_at with storage weiqi:runtime dead
