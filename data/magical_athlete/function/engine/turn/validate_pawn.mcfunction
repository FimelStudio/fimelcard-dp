scoreboard players set #valid ma_ctx 1
execute store result score #forced ma_ctx run data get storage magical_athlete:engine s.forced
execute if score #forced ma_ctx matches 0..5 unless score #forced ma_ctx = #target ma_ctx run scoreboard players set #valid ma_ctx 0
execute if score #forced ma_ctx matches 0..5 run return 0
scoreboard players set #first_owned ma_ctx -1
execute if score #s0 ma_ctx matches 0 if score #o0 ma_ctx = #actor ma_ctx if score #first_owned ma_ctx matches -1 run scoreboard players set #first_owned ma_ctx 0
execute if score #s1 ma_ctx matches 0 if score #o1 ma_ctx = #actor ma_ctx if score #first_owned ma_ctx matches -1 run scoreboard players set #first_owned ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #o2 ma_ctx = #actor ma_ctx if score #first_owned ma_ctx matches -1 run scoreboard players set #first_owned ma_ctx 2
execute if score #s3 ma_ctx matches 0 if score #o3 ma_ctx = #actor ma_ctx if score #first_owned ma_ctx matches -1 run scoreboard players set #first_owned ma_ctx 3
execute if score #s4 ma_ctx matches 0 if score #o4 ma_ctx = #actor ma_ctx if score #first_owned ma_ctx matches -1 run scoreboard players set #first_owned ma_ctx 4
execute if score #s5 ma_ctx matches 0 if score #o5 ma_ctx = #actor ma_ctx if score #first_owned ma_ctx matches -1 run scoreboard players set #first_owned ma_ctx 5
execute unless score #first_owned ma_ctx = #target ma_ctx run scoreboard players set #valid ma_ctx 0
