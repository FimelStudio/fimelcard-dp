execute if score #target ma_ctx matches 0..5 run function magical_athlete:engine/choices/pull with storage magical_athlete:engine choice
data modify storage magical_athlete:engine s.queue append value {"type":"roll"}
execute if score #target ma_ctx matches 0.. run function magical_athlete:engine/notify_active
