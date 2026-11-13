execute unless data storage magical_athlete:engine s.pending.options[0] run return run function magical_athlete:engine/error {id:5}
execute store result score #owner ma_ctx run data get storage magical_athlete:engine s.pending.owner
execute unless score #actor ma_ctx = #owner ma_ctx run return run function magical_athlete:engine/error {id:4}
data modify storage magical_athlete:engine check.target set from storage magical_athlete:engine request.target
function magical_athlete:engine/choice_valid with storage magical_athlete:engine check
execute unless score #found ma_ctx matches 1 run return run function magical_athlete:engine/error {id:8}
data modify storage magical_athlete:engine choice set from storage magical_athlete:engine s.pending
data modify storage magical_athlete:engine s.pending set value {kind:"",owner:0,pawn:-1,options:[]}
function magical_athlete:engine/choice_dispatch with storage magical_athlete:engine choice
scoreboard players set #ok ma_ctx 1
