execute unless score #phase ma_ctx matches 1 run return run function magical_athlete:engine/error {id:5}
execute unless score #actor ma_ctx = #turn ma_ctx run return run function magical_athlete:engine/error {id:4}
execute unless score #target ma_ctx matches 0..35 run return run function magical_athlete:engine/error {id:8}
data modify storage magical_athlete:engine probe set value {id:0}
execute store result storage magical_athlete:engine probe.id int 1 run scoreboard players get #target ma_ctx
function magical_athlete:engine/draft/has with storage magical_athlete:engine request
execute unless score #found ma_ctx matches 1 run return run function magical_athlete:engine/error {id:8}
function magical_athlete:engine/draft/advance
scoreboard players set #ok ma_ctx 1
