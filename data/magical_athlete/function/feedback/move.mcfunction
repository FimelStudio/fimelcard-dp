$scoreboard players set #move_from ma_ctx $(from)
$scoreboard players set #move_to ma_ctx $(to)
scoreboard players operation #move_steps ma_ctx = #move_to ma_ctx
scoreboard players operation #move_steps ma_ctx -= #move_from ma_ctx
data modify storage magical_athlete:feedback event.direction set value "原地停留"
execute if score #move_steps ma_ctx matches 1.. run data modify storage magical_athlete:feedback event.direction set value "前进"
execute if score #move_steps ma_ctx matches ..-1 run data modify storage magical_athlete:feedback event.direction set value "后退"
function magical_athlete:feedback/move_message with storage magical_athlete:feedback event
