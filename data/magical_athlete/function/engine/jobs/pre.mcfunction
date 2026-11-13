function magical_athlete:engine/active_context
scoreboard players set #lead ma_ctx -1
scoreboard players set #last ma_ctx 31
scoreboard players set #alone ma_ctx 1
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x0 ma_ctx
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x0 ma_ctx
execute unless score #i ma_ctx matches 0 if score #s0 ma_ctx matches 0 if score #x0 ma_ctx = #position ma_ctx run scoreboard players set #alone ma_ctx 0
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x1 ma_ctx
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x1 ma_ctx
execute unless score #i ma_ctx matches 1 if score #s1 ma_ctx matches 0 if score #x1 ma_ctx = #position ma_ctx run scoreboard players set #alone ma_ctx 0
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x2 ma_ctx
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x2 ma_ctx
execute unless score #i ma_ctx matches 2 if score #s2 ma_ctx matches 0 if score #x2 ma_ctx = #position ma_ctx run scoreboard players set #alone ma_ctx 0
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x3 ma_ctx
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x3 ma_ctx
execute unless score #i ma_ctx matches 3 if score #s3 ma_ctx matches 0 if score #x3 ma_ctx = #position ma_ctx run scoreboard players set #alone ma_ctx 0
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x4 ma_ctx
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x4 ma_ctx
execute unless score #i ma_ctx matches 4 if score #s4 ma_ctx matches 0 if score #x4 ma_ctx = #position ma_ctx run scoreboard players set #alone ma_ctx 0
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x5 ma_ctx
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x5 ma_ctx
execute unless score #i ma_ctx matches 5 if score #s5 ma_ctx matches 0 if score #x5 ma_ctx = #position ma_ctx run scoreboard players set #alone ma_ctx 0
execute if score #power ma_ctx matches 14 if score #position ma_ctx = #lead ma_ctx if score #alone ma_ctx matches 1 run function magical_athlete:engine/notify_active
execute if score #power ma_ctx matches 14 if score #position ma_ctx = #lead ma_ctx if score #alone ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue append value {"type":"turn_end"}
execute if score #power ma_ctx matches 14 if score #position ma_ctx = #lead ma_ctx if score #alone ma_ctx matches 1 run return 0
execute if score #power ma_ctx matches 22 if score #position ma_ctx = #last ma_ctx if score #alone ma_ctx matches 1 run function magical_athlete:engine/turn/loser
execute if score #power ma_ctx matches 26 run function magical_athlete:engine/turn/party
execute if score #power ma_ctx matches 26 run return 0
execute if score #power ma_ctx matches 5 run function magical_athlete:engine/turn/offer_cheerleader
execute if score #power ma_ctx matches 5 run return 0
execute if score #power ma_ctx matches 17 run function magical_athlete:engine/turn/offer_hypnotist
execute if score #power ma_ctx matches 17 run return 0
execute if score #power ma_ctx matches 11 run function magical_athlete:engine/turn/offer_flip
execute if score #power ma_ctx matches 11 run return 0
execute if score #power ma_ctx matches 12 run function magical_athlete:engine/turn/offer_genius
execute if score #power ma_ctx matches 12 run return 0
execute if score #power ma_ctx matches 21 run function magical_athlete:engine/turn/offer_legs
execute if score #power ma_ctx matches 21 run return 0
execute if score #power ma_ctx matches 34 run function magical_athlete:engine/turn/offer_thirdwheel
execute if score #power ma_ctx matches 34 run return 0
data modify storage magical_athlete:engine s.queue append value {"type":"roll"}
