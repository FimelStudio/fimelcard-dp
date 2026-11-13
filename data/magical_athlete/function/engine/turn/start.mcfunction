execute unless score #phase ma_ctx matches 3 run return run function magical_athlete:engine/error {id:5}
execute unless score #actor ma_ctx = #turn ma_ctx run return run function magical_athlete:engine/error {id:4}
execute unless score #target ma_ctx matches 0..5 run return run function magical_athlete:engine/error {id:8}
execute if data storage magical_athlete:engine s.pending.options[0] run return run function magical_athlete:engine/error {id:5}
execute if data storage magical_athlete:engine s.queue[0] run return run function magical_athlete:engine/error {id:5}
data modify storage magical_athlete:engine job set value {pawn:0}
data modify storage magical_athlete:engine job.pawn set from storage magical_athlete:engine request.target
function magical_athlete:engine/powers
function magical_athlete:engine/pawn_context with storage magical_athlete:engine job
execute unless score #owner ma_ctx = #actor ma_ctx run return run function magical_athlete:engine/error {id:4}
execute unless score #status ma_ctx matches 0 run return run function magical_athlete:engine/error {id:8}
function magical_athlete:engine/turn/validate_pawn with storage magical_athlete:engine job
execute unless score #valid ma_ctx matches 1 run return run function magical_athlete:engine/error {id:8}
data modify storage magical_athlete:engine s.used_merchants set value []
data modify storage magical_athlete:engine s.transmuted set value 0
data modify storage magical_athlete:engine s.active set from storage magical_athlete:engine request.target
data modify storage magical_athlete:engine s.pawn set from storage magical_athlete:engine request.target
execute store result storage magical_athlete:engine s.start_pos int 1 run scoreboard players get #position ma_ctx
data modify storage magical_athlete:engine s.dice set value 0
data modify storage magical_athlete:engine s.rerolls set value 0
data modify storage magical_athlete:engine s.merchant set value 0
data modify storage magical_athlete:engine s.prediction set value 0
data modify storage magical_athlete:engine s.bomb set value 0
data modify storage magical_athlete:engine s.skip set value 0
data modify storage magical_athlete:engine s.pre_done set value 0
data modify storage magical_athlete:engine s.extra set value -1
data modify storage magical_athlete:engine s.next_override set value -1
data modify storage magical_athlete:engine s.queue append value {"type":"begin"}
scoreboard players set #ok ma_ctx 1
