execute if score #target ma_ctx matches 0 run data modify storage magical_athlete:engine s.queue append value {"type":"roll_accept"}
execute if score #target ma_ctx matches 1 run function magical_athlete:engine/reroll
