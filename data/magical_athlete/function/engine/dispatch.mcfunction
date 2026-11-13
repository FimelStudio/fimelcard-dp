execute if score #code ma_ctx matches 1 run return run function magical_athlete:engine/draft/pick
execute if score #code ma_ctx matches 2 run return run function magical_athlete:engine/lineup/pick
execute if score #code ma_ctx matches 3 run return run function magical_athlete:engine/turn/start
execute if score #code ma_ctx matches 4 run return run function magical_athlete:engine/choice
execute if score #code ma_ctx matches 5 run return run function magical_athlete:engine/next_race
return run function magical_athlete:engine/error {id:9}
