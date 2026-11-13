$execute store result score #other_pos ma_ctx run data get storage magical_athlete:engine s.racers[$(pawn)].pos
scoreboard players set #batch_amount ma_ctx 1
execute if score #other_pos ma_ctx > #position ma_ctx run scoreboard players set #batch_amount ma_ctx -1
$data modify storage magical_athlete:engine batch_args set value {pawn:$(pawn),amount:1}
execute store result storage magical_athlete:engine batch_args.amount int 1 run scoreboard players get #batch_amount ma_ctx
function magical_athlete:engine/batch/arrive with storage magical_athlete:engine batch_args
function magical_athlete:engine/active_context
