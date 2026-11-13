execute unless score #reactor ma_ctx = #mover ma_ctx if score #joint ma_ctx matches 1 run return 0
execute unless score #reactor ma_ctx = #mover ma_ctx unless score #rpos ma_ctx = #to ma_ctx run return 0
data modify storage magical_athlete:engine s.pending set value {kind:"duel",owner:0,pawn:0,options:[-1]}
data modify storage magical_athlete:engine s.pending.pawn set from storage magical_athlete:engine job.reactor
execute if score #reactor ma_ctx matches 0 run data modify storage magical_athlete:engine s.pending.owner set from storage magical_athlete:engine s.racers[0].owner
execute unless score #reactor ma_ctx matches 0 if score #s0 ma_ctx matches 0 if score #x0 ma_ctx = #rpos ma_ctx run data modify storage magical_athlete:engine s.pending.options append value 0
execute if score #reactor ma_ctx matches 1 run data modify storage magical_athlete:engine s.pending.owner set from storage magical_athlete:engine s.racers[1].owner
execute unless score #reactor ma_ctx matches 1 if score #s1 ma_ctx matches 0 if score #x1 ma_ctx = #rpos ma_ctx run data modify storage magical_athlete:engine s.pending.options append value 1
execute if score #reactor ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.owner set from storage magical_athlete:engine s.racers[2].owner
execute unless score #reactor ma_ctx matches 2 if score #s2 ma_ctx matches 0 if score #x2 ma_ctx = #rpos ma_ctx run data modify storage magical_athlete:engine s.pending.options append value 2
execute if score #reactor ma_ctx matches 3 run data modify storage magical_athlete:engine s.pending.owner set from storage magical_athlete:engine s.racers[3].owner
execute unless score #reactor ma_ctx matches 3 if score #s3 ma_ctx matches 0 if score #x3 ma_ctx = #rpos ma_ctx run data modify storage magical_athlete:engine s.pending.options append value 3
execute if score #reactor ma_ctx matches 4 run data modify storage magical_athlete:engine s.pending.owner set from storage magical_athlete:engine s.racers[4].owner
execute unless score #reactor ma_ctx matches 4 if score #s4 ma_ctx matches 0 if score #x4 ma_ctx = #rpos ma_ctx run data modify storage magical_athlete:engine s.pending.options append value 4
execute if score #reactor ma_ctx matches 5 run data modify storage magical_athlete:engine s.pending.owner set from storage magical_athlete:engine s.racers[5].owner
execute unless score #reactor ma_ctx matches 5 if score #s5 ma_ctx matches 0 if score #x5 ma_ctx = #rpos ma_ctx run data modify storage magical_athlete:engine s.pending.options append value 5
execute unless data storage magical_athlete:engine s.pending.options[1] run data modify storage magical_athlete:engine s.pending set value {kind:"",owner:0,pawn:-1,options:[]}
