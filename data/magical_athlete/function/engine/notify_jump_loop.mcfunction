execute unless score #jump_count ma_ctx matches 1.. run return 0
data modify storage magical_athlete:engine s.queue prepend from storage magical_athlete:engine jump_notify
scoreboard players remove #jump_count ma_ctx 1
function magical_athlete:engine/notify_jump_loop
