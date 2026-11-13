scoreboard players set #count ma_ctx 0
scoreboard players set #victim ma_ctx -1
execute unless score #mover ma_ctx matches 0 if score #s0 ma_ctx matches 0 if score #x0 ma_ctx = #to ma_ctx run scoreboard players add #count ma_ctx 1
execute unless score #mover ma_ctx matches 0 if score #s0 ma_ctx matches 0 if score #x0 ma_ctx = #to ma_ctx run scoreboard players set #victim ma_ctx 0
execute unless score #mover ma_ctx matches 1 if score #s1 ma_ctx matches 0 if score #x1 ma_ctx = #to ma_ctx run scoreboard players add #count ma_ctx 1
execute unless score #mover ma_ctx matches 1 if score #s1 ma_ctx matches 0 if score #x1 ma_ctx = #to ma_ctx run scoreboard players set #victim ma_ctx 1
execute unless score #mover ma_ctx matches 2 if score #s2 ma_ctx matches 0 if score #x2 ma_ctx = #to ma_ctx run scoreboard players add #count ma_ctx 1
execute unless score #mover ma_ctx matches 2 if score #s2 ma_ctx matches 0 if score #x2 ma_ctx = #to ma_ctx run scoreboard players set #victim ma_ctx 2
execute unless score #mover ma_ctx matches 3 if score #s3 ma_ctx matches 0 if score #x3 ma_ctx = #to ma_ctx run scoreboard players add #count ma_ctx 1
execute unless score #mover ma_ctx matches 3 if score #s3 ma_ctx matches 0 if score #x3 ma_ctx = #to ma_ctx run scoreboard players set #victim ma_ctx 3
execute unless score #mover ma_ctx matches 4 if score #s4 ma_ctx matches 0 if score #x4 ma_ctx = #to ma_ctx run scoreboard players add #count ma_ctx 1
execute unless score #mover ma_ctx matches 4 if score #s4 ma_ctx matches 0 if score #x4 ma_ctx = #to ma_ctx run scoreboard players set #victim ma_ctx 4
execute unless score #mover ma_ctx matches 5 if score #s5 ma_ctx matches 0 if score #x5 ma_ctx = #to ma_ctx run scoreboard players add #count ma_ctx 1
execute unless score #mover ma_ctx matches 5 if score #s5 ma_ctx matches 0 if score #x5 ma_ctx = #to ma_ctx run scoreboard players set #victim ma_ctx 5
