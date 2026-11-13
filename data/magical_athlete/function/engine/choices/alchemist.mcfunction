execute if score #target ma_ctx matches 1 run data modify storage magical_athlete:engine s.transmuted set value 1
execute if score #target ma_ctx matches 1 run data modify storage magical_athlete:engine s.distance set value 4
data modify storage magical_athlete:engine s.queue append value {"type":"roll_done"}
