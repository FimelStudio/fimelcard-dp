function weiqi:game/clear_requests
function weiqi:visual/place
function weiqi:visual/capture
execute store result score #placed_captured go_ctx run data get entity @s data.weiqi.last.captured
execute if score #placed_captured go_ctx matches 1.. run function weiqi:sound/capture
execute if score #placed_captured go_ctx matches 0 run function weiqi:sound/move
function weiqi:game/announce_move
scoreboard players set @s go_state 2
scoreboard players set @s go_timer 6
function weiqi:clock/update
function weiqi:ui/refresh
scoreboard players set #legal go_ctx 1
