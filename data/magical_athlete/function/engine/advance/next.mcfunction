scoreboard players add #turn ma_ctx 1
execute if score #turn ma_ctx > #n ma_ctx run scoreboard players set #turn ma_ctx 1
execute store result storage magical_athlete:engine s.turn int 1 run scoreboard players get #turn ma_ctx
data modify storage magical_athlete:engine s.racers[0].done set value 0
data modify storage magical_athlete:engine s.racers[1].done set value 0
data modify storage magical_athlete:engine s.racers[2].done set value 0
data modify storage magical_athlete:engine s.racers[3].done set value 0
data modify storage magical_athlete:engine s.racers[4].done set value 0
data modify storage magical_athlete:engine s.racers[5].done set value 0
scoreboard players set #remaining ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #o0 ma_ctx = #turn ma_ctx run scoreboard players add #remaining ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #o1 ma_ctx = #turn ma_ctx run scoreboard players add #remaining ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #o2 ma_ctx = #turn ma_ctx run scoreboard players add #remaining ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #o3 ma_ctx = #turn ma_ctx run scoreboard players add #remaining ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #o4 ma_ctx = #turn ma_ctx run scoreboard players add #remaining ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #o5 ma_ctx = #turn ma_ctx run scoreboard players add #remaining ma_ctx 1
execute if score #remaining ma_ctx matches 0 run function magical_athlete:engine/advance/next
