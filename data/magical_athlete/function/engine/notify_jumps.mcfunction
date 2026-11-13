execute store result score #jump_count ma_ctx run data get storage magical_athlete:engine s.motion.jumps
data modify storage magical_athlete:engine jump_notify set value {type:"power",pawn:0}
data modify storage magical_athlete:engine jump_notify.pawn set from storage magical_athlete:engine s.motion.pawn
function magical_athlete:engine/notify_jump_loop
