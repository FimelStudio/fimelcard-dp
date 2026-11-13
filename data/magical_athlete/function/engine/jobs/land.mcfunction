function magical_athlete:engine/pawn_context with storage magical_athlete:engine job
execute unless score #status ma_ctx matches 0 run return 0
$scoreboard players set #destination ma_ctx $(to)
execute if score #destination ma_ctx matches 30.. run return run function magical_athlete:engine/jobs/finish with storage magical_athlete:engine job
function magical_athlete:engine/cycle/check with storage magical_athlete:engine job
execute if score #repeated ma_ctx matches 1 run return 0
data modify storage magical_athlete:engine landed set from storage magical_athlete:engine job
function magical_athlete:engine/land/queue_reactions
function magical_athlete:engine/land/track with storage magical_athlete:engine landed
