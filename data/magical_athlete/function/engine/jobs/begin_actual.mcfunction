function magical_athlete:engine/active_context
data modify storage magical_athlete:engine temp.pawn set from storage magical_athlete:engine s.active
function magical_athlete:engine/turn/mark with storage magical_athlete:engine temp
execute if score #status ma_ctx matches 1.. run data modify storage magical_athlete:engine s.queue append value {"type":"turn_end"}
execute if score #status ma_ctx matches 1.. run return 0
function magical_athlete:engine/turn/first with storage magical_athlete:engine temp
execute if data storage magical_athlete:engine s.pending.options[0] run return 0
data modify storage magical_athlete:engine s.queue append value {"type":"pre"}
