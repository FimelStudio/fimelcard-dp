function magical_athlete:engine/pawn_context with storage magical_athlete:engine job
execute unless score #status ma_ctx matches 0 run return 0
execute if score #power ma_ctx matches 30 run function magical_athlete:engine/prerace/sisyphus with storage magical_athlete:engine job
execute if score #power ma_ctx matches 10 run function magical_athlete:engine/prerace/egg
execute if score #power ma_ctx matches 35 run function magical_athlete:engine/prerace/twin
