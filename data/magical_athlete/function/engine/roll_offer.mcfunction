function magical_athlete:engine/active_context
execute store result score #die ma_ctx run data get storage magical_athlete:engine s.dice
scoreboard players set #can ma_ctx 0
execute store result score #rerolls ma_ctx run data get storage magical_athlete:engine s.rerolls
execute if score #power ma_ctx matches 23 if score #rerolls ma_ctx matches ..1 run scoreboard players set #can ma_ctx 1
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 8 unless data storage magical_athlete:engine s{used_merchants:[0]} run scoreboard players set #can ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 8 unless data storage magical_athlete:engine s{used_merchants:[1]} run scoreboard players set #can ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 8 unless data storage magical_athlete:engine s{used_merchants:[2]} run scoreboard players set #can ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 8 unless data storage magical_athlete:engine s{used_merchants:[3]} run scoreboard players set #can ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 8 unless data storage magical_athlete:engine s{used_merchants:[4]} run scoreboard players set #can ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 8 unless data storage magical_athlete:engine s{used_merchants:[5]} run scoreboard players set #can ma_ctx 1
function magical_athlete:engine/dice_event
execute if score #can ma_ctx matches 1 run function magical_athlete:engine/offer_reroll
execute if score #can ma_ctx matches 0 run data modify storage magical_athlete:engine s.queue append value {"type":"roll_accept"}
