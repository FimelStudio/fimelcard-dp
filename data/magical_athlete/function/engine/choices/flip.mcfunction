execute if score #target ma_ctx matches -1 run data modify storage magical_athlete:engine s.queue append value {"type":"roll"}
execute if score #target ma_ctx matches 0..5 run data modify storage magical_athlete:engine s.queue append value {"type":"swap"}
execute if score #target ma_ctx matches 0..5 run data modify storage magical_athlete:engine s.swap set from storage magical_athlete:engine request.target
execute if score #target ma_ctx matches 0..5 run data modify storage magical_athlete:engine s.queue append value {"type":"turn_end"}
