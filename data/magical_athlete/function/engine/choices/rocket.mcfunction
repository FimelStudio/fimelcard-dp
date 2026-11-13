execute if score #target ma_ctx matches 1 run data modify storage magical_athlete:engine s.bomb set value 1
execute store result score #distance ma_ctx run data get storage magical_athlete:engine s.distance
execute if score #target ma_ctx matches 1 run scoreboard players operation #distance ma_ctx += #distance ma_ctx
execute store result storage magical_athlete:engine s.distance int 1 run scoreboard players get #distance ma_ctx
data modify storage magical_athlete:engine s.queue append value {"type":"roll_done"}
