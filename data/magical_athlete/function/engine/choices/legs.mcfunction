execute if score #target ma_ctx matches 0 run data modify storage magical_athlete:engine s.queue append value {"type":"roll"}
execute if score #target ma_ctx matches 1 run data modify storage magical_athlete:engine s.dice set value 0
execute if score #target ma_ctx matches 1 run data modify storage magical_athlete:engine s.distance set value 5
execute if score #target ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue append value {"type":"main"}
