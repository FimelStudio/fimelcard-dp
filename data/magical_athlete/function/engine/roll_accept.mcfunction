function magical_athlete:engine/active_context
execute store result score #die ma_ctx run data get storage magical_athlete:engine s.dice
execute store result storage magical_athlete:engine s.distance int 1 run scoreboard players get #die ma_ctx
execute if score #power ma_ctx matches 0 if score #die ma_ctx matches 1..2 run function magical_athlete:engine/offer_alchemist
execute if score #power ma_ctx matches 0 if score #die ma_ctx matches 1..2 run return 0
execute if score #power ma_ctx matches 27 run function magical_athlete:engine/offer_rocket
execute if score #power ma_ctx matches 27 run return 0
data modify storage magical_athlete:engine s.queue append value {"type":"roll_done"}
