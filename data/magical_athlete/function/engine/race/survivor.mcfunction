function magical_athlete:engine/powers
scoreboard players set #alive ma_ctx 0
scoreboard players set #survivor ma_ctx -1
execute if score #s0 ma_ctx matches 0 run scoreboard players add #alive ma_ctx 1
execute if score #s0 ma_ctx matches 0 run scoreboard players set #survivor ma_ctx 0
execute if score #s1 ma_ctx matches 0 run scoreboard players add #alive ma_ctx 1
execute if score #s1 ma_ctx matches 0 run scoreboard players set #survivor ma_ctx 1
execute if score #s2 ma_ctx matches 0 run scoreboard players add #alive ma_ctx 1
execute if score #s2 ma_ctx matches 0 run scoreboard players set #survivor ma_ctx 2
execute if score #s3 ma_ctx matches 0 run scoreboard players add #alive ma_ctx 1
execute if score #s3 ma_ctx matches 0 run scoreboard players set #survivor ma_ctx 3
execute if score #s4 ma_ctx matches 0 run scoreboard players add #alive ma_ctx 1
execute if score #s4 ma_ctx matches 0 run scoreboard players set #survivor ma_ctx 4
execute if score #s5 ma_ctx matches 0 run scoreboard players add #alive ma_ctx 1
execute if score #s5 ma_ctx matches 0 run scoreboard players set #survivor ma_ctx 5
execute if score #alive ma_ctx matches 1 if score #survivor ma_ctx matches 0 run function magical_athlete:engine/jobs/finish {pawn:0}
execute if score #alive ma_ctx matches 1 if score #survivor ma_ctx matches 1 run function magical_athlete:engine/jobs/finish {pawn:1}
execute if score #alive ma_ctx matches 1 if score #survivor ma_ctx matches 2 run function magical_athlete:engine/jobs/finish {pawn:2}
execute if score #alive ma_ctx matches 1 if score #survivor ma_ctx matches 3 run function magical_athlete:engine/jobs/finish {pawn:3}
execute if score #alive ma_ctx matches 1 if score #survivor ma_ctx matches 4 run function magical_athlete:engine/jobs/finish {pawn:4}
execute if score #alive ma_ctx matches 1 if score #survivor ma_ctx matches 5 run function magical_athlete:engine/jobs/finish {pawn:5}
execute if score #alive ma_ctx matches ..1 run function magical_athlete:engine/race/end
