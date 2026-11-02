$execute if score #metric$(player) ca_ctx > #max_metric ca_ctx run return run function catan:engine/award/higher {player:$(player)}
$execute if score #metric$(player) ca_ctx = #max_metric ca_ctx run scoreboard players add #metric_count ca_ctx 1
