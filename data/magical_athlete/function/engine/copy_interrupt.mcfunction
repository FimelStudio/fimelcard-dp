execute store result score #raw ma_ctx run data get storage magical_athlete:engine s.racers[0].power
execute store result score #lock ma_ctx run data get storage magical_athlete:engine s.copy_locks[0]
execute if score #s0 ma_ctx matches 0 if score #raw ma_ctx matches 7 if score #lock ma_ctx matches 0 run function magical_athlete:engine/copy/offer {pawn:0}
execute if data storage magical_athlete:engine s.pending.options[0] run return 0
execute store result score #raw ma_ctx run data get storage magical_athlete:engine s.racers[1].power
execute store result score #lock ma_ctx run data get storage magical_athlete:engine s.copy_locks[1]
execute if score #s1 ma_ctx matches 0 if score #raw ma_ctx matches 7 if score #lock ma_ctx matches 0 run function magical_athlete:engine/copy/offer {pawn:1}
execute if data storage magical_athlete:engine s.pending.options[0] run return 0
execute store result score #raw ma_ctx run data get storage magical_athlete:engine s.racers[2].power
execute store result score #lock ma_ctx run data get storage magical_athlete:engine s.copy_locks[2]
execute if score #s2 ma_ctx matches 0 if score #raw ma_ctx matches 7 if score #lock ma_ctx matches 0 run function magical_athlete:engine/copy/offer {pawn:2}
execute if data storage magical_athlete:engine s.pending.options[0] run return 0
execute store result score #raw ma_ctx run data get storage magical_athlete:engine s.racers[3].power
execute store result score #lock ma_ctx run data get storage magical_athlete:engine s.copy_locks[3]
execute if score #s3 ma_ctx matches 0 if score #raw ma_ctx matches 7 if score #lock ma_ctx matches 0 run function magical_athlete:engine/copy/offer {pawn:3}
execute if data storage magical_athlete:engine s.pending.options[0] run return 0
execute store result score #raw ma_ctx run data get storage magical_athlete:engine s.racers[4].power
execute store result score #lock ma_ctx run data get storage magical_athlete:engine s.copy_locks[4]
execute if score #s4 ma_ctx matches 0 if score #raw ma_ctx matches 7 if score #lock ma_ctx matches 0 run function magical_athlete:engine/copy/offer {pawn:4}
execute if data storage magical_athlete:engine s.pending.options[0] run return 0
execute store result score #raw ma_ctx run data get storage magical_athlete:engine s.racers[5].power
execute store result score #lock ma_ctx run data get storage magical_athlete:engine s.copy_locks[5]
execute if score #s5 ma_ctx matches 0 if score #raw ma_ctx matches 7 if score #lock ma_ctx matches 0 run function magical_athlete:engine/copy/offer {pawn:5}
execute if data storage magical_athlete:engine s.pending.options[0] run return 0
