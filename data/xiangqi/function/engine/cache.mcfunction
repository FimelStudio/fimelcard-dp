scoreboard players operation #side xq_ctx = @s xq_turn
scoreboard players set #variant xq_ctx 0
execute if score @s xq_variant matches 1 run scoreboard players set #variant xq_ctx 1
scoreboard players set #wking xq_ctx -1
scoreboard players set #bking xq_ctx -1
scoreboard players set #cache_ok xq_ctx 1
execute store result score #cache_size xq_ctx if entity @e[type=minecraft:marker,tag=xq.board]
execute unless score #cache_size xq_ctx matches 90 run scoreboard players set #cache_ok xq_ctx 0
execute as @e[type=minecraft:marker,tag=xq.board] unless score @s xq_piece matches -7..7 run scoreboard players set #cache_ok xq_ctx 0
execute store result score #king_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_piece=6}]
execute unless score #king_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
execute store result score #king_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_piece=-6}]
execute unless score #king_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players set #b0 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=0}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b0 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=0},limit=1] xq_piece
scoreboard players set #q0 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=0},limit=1] xq_covered matches 1 run scoreboard players set #q0 xq_ctx 1
execute if score #b0 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 0
execute if score #b0 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 0
scoreboard players set #b1 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=1}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b1 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=1},limit=1] xq_piece
scoreboard players set #q1 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=1},limit=1] xq_covered matches 1 run scoreboard players set #q1 xq_ctx 1
execute if score #b1 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 1
execute if score #b1 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 1
scoreboard players set #b2 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=2}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b2 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=2},limit=1] xq_piece
scoreboard players set #q2 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=2},limit=1] xq_covered matches 1 run scoreboard players set #q2 xq_ctx 1
execute if score #b2 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 2
execute if score #b2 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 2
scoreboard players set #b3 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=3}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b3 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=3},limit=1] xq_piece
scoreboard players set #q3 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=3},limit=1] xq_covered matches 1 run scoreboard players set #q3 xq_ctx 1
execute if score #b3 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 3
execute if score #b3 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 3
scoreboard players set #b4 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=4}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b4 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=4},limit=1] xq_piece
scoreboard players set #q4 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=4},limit=1] xq_covered matches 1 run scoreboard players set #q4 xq_ctx 1
execute if score #b4 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 4
execute if score #b4 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 4
scoreboard players set #b5 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=5}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b5 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=5},limit=1] xq_piece
scoreboard players set #q5 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=5},limit=1] xq_covered matches 1 run scoreboard players set #q5 xq_ctx 1
execute if score #b5 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 5
execute if score #b5 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 5
scoreboard players set #b6 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=6}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b6 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=6},limit=1] xq_piece
scoreboard players set #q6 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=6},limit=1] xq_covered matches 1 run scoreboard players set #q6 xq_ctx 1
execute if score #b6 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 6
execute if score #b6 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 6
scoreboard players set #b7 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=7}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b7 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=7},limit=1] xq_piece
scoreboard players set #q7 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=7},limit=1] xq_covered matches 1 run scoreboard players set #q7 xq_ctx 1
execute if score #b7 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 7
execute if score #b7 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 7
scoreboard players set #b8 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=8}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b8 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=8},limit=1] xq_piece
scoreboard players set #q8 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=8},limit=1] xq_covered matches 1 run scoreboard players set #q8 xq_ctx 1
execute if score #b8 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 8
execute if score #b8 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 8
scoreboard players set #b9 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=9}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b9 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=9},limit=1] xq_piece
scoreboard players set #q9 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=9},limit=1] xq_covered matches 1 run scoreboard players set #q9 xq_ctx 1
execute if score #b9 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 9
execute if score #b9 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 9
scoreboard players set #b10 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=10}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b10 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=10},limit=1] xq_piece
scoreboard players set #q10 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=10},limit=1] xq_covered matches 1 run scoreboard players set #q10 xq_ctx 1
execute if score #b10 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 10
execute if score #b10 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 10
scoreboard players set #b11 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=11}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b11 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=11},limit=1] xq_piece
scoreboard players set #q11 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=11},limit=1] xq_covered matches 1 run scoreboard players set #q11 xq_ctx 1
execute if score #b11 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 11
execute if score #b11 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 11
scoreboard players set #b12 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=12}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b12 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=12},limit=1] xq_piece
scoreboard players set #q12 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=12},limit=1] xq_covered matches 1 run scoreboard players set #q12 xq_ctx 1
execute if score #b12 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 12
execute if score #b12 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 12
scoreboard players set #b13 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=13}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b13 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=13},limit=1] xq_piece
scoreboard players set #q13 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=13},limit=1] xq_covered matches 1 run scoreboard players set #q13 xq_ctx 1
execute if score #b13 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 13
execute if score #b13 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 13
scoreboard players set #b14 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=14}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b14 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=14},limit=1] xq_piece
scoreboard players set #q14 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=14},limit=1] xq_covered matches 1 run scoreboard players set #q14 xq_ctx 1
execute if score #b14 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 14
execute if score #b14 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 14
scoreboard players set #b15 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=15}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b15 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=15},limit=1] xq_piece
scoreboard players set #q15 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=15},limit=1] xq_covered matches 1 run scoreboard players set #q15 xq_ctx 1
execute if score #b15 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 15
execute if score #b15 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 15
scoreboard players set #b16 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=16}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b16 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=16},limit=1] xq_piece
scoreboard players set #q16 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=16},limit=1] xq_covered matches 1 run scoreboard players set #q16 xq_ctx 1
execute if score #b16 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 16
execute if score #b16 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 16
scoreboard players set #b17 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=17}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b17 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=17},limit=1] xq_piece
scoreboard players set #q17 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=17},limit=1] xq_covered matches 1 run scoreboard players set #q17 xq_ctx 1
execute if score #b17 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 17
execute if score #b17 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 17
scoreboard players set #b18 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=18}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b18 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=18},limit=1] xq_piece
scoreboard players set #q18 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=18},limit=1] xq_covered matches 1 run scoreboard players set #q18 xq_ctx 1
execute if score #b18 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 18
execute if score #b18 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 18
scoreboard players set #b19 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=19}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b19 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=19},limit=1] xq_piece
scoreboard players set #q19 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=19},limit=1] xq_covered matches 1 run scoreboard players set #q19 xq_ctx 1
execute if score #b19 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 19
execute if score #b19 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 19
scoreboard players set #b20 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=20}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b20 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=20},limit=1] xq_piece
scoreboard players set #q20 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=20},limit=1] xq_covered matches 1 run scoreboard players set #q20 xq_ctx 1
execute if score #b20 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 20
execute if score #b20 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 20
scoreboard players set #b21 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=21}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b21 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=21},limit=1] xq_piece
scoreboard players set #q21 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=21},limit=1] xq_covered matches 1 run scoreboard players set #q21 xq_ctx 1
execute if score #b21 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 21
execute if score #b21 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 21
scoreboard players set #b22 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=22}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b22 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=22},limit=1] xq_piece
scoreboard players set #q22 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=22},limit=1] xq_covered matches 1 run scoreboard players set #q22 xq_ctx 1
execute if score #b22 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 22
execute if score #b22 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 22
scoreboard players set #b23 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=23}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b23 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=23},limit=1] xq_piece
scoreboard players set #q23 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=23},limit=1] xq_covered matches 1 run scoreboard players set #q23 xq_ctx 1
execute if score #b23 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 23
execute if score #b23 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 23
scoreboard players set #b24 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=24}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b24 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=24},limit=1] xq_piece
scoreboard players set #q24 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=24},limit=1] xq_covered matches 1 run scoreboard players set #q24 xq_ctx 1
execute if score #b24 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 24
execute if score #b24 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 24
scoreboard players set #b25 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=25}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b25 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=25},limit=1] xq_piece
scoreboard players set #q25 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=25},limit=1] xq_covered matches 1 run scoreboard players set #q25 xq_ctx 1
execute if score #b25 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 25
execute if score #b25 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 25
scoreboard players set #b26 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=26}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b26 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=26},limit=1] xq_piece
scoreboard players set #q26 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=26},limit=1] xq_covered matches 1 run scoreboard players set #q26 xq_ctx 1
execute if score #b26 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 26
execute if score #b26 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 26
scoreboard players set #b27 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=27}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b27 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=27},limit=1] xq_piece
scoreboard players set #q27 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=27},limit=1] xq_covered matches 1 run scoreboard players set #q27 xq_ctx 1
execute if score #b27 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 27
execute if score #b27 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 27
scoreboard players set #b28 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=28}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b28 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=28},limit=1] xq_piece
scoreboard players set #q28 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=28},limit=1] xq_covered matches 1 run scoreboard players set #q28 xq_ctx 1
execute if score #b28 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 28
execute if score #b28 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 28
scoreboard players set #b29 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=29}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b29 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=29},limit=1] xq_piece
scoreboard players set #q29 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=29},limit=1] xq_covered matches 1 run scoreboard players set #q29 xq_ctx 1
execute if score #b29 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 29
execute if score #b29 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 29
scoreboard players set #b30 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=30}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b30 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=30},limit=1] xq_piece
scoreboard players set #q30 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=30},limit=1] xq_covered matches 1 run scoreboard players set #q30 xq_ctx 1
execute if score #b30 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 30
execute if score #b30 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 30
scoreboard players set #b31 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=31}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b31 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=31},limit=1] xq_piece
scoreboard players set #q31 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=31},limit=1] xq_covered matches 1 run scoreboard players set #q31 xq_ctx 1
execute if score #b31 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 31
execute if score #b31 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 31
scoreboard players set #b32 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=32}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b32 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=32},limit=1] xq_piece
scoreboard players set #q32 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=32},limit=1] xq_covered matches 1 run scoreboard players set #q32 xq_ctx 1
execute if score #b32 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 32
execute if score #b32 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 32
scoreboard players set #b33 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=33}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b33 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=33},limit=1] xq_piece
scoreboard players set #q33 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=33},limit=1] xq_covered matches 1 run scoreboard players set #q33 xq_ctx 1
execute if score #b33 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 33
execute if score #b33 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 33
scoreboard players set #b34 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=34}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b34 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=34},limit=1] xq_piece
scoreboard players set #q34 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=34},limit=1] xq_covered matches 1 run scoreboard players set #q34 xq_ctx 1
execute if score #b34 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 34
execute if score #b34 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 34
scoreboard players set #b35 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=35}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b35 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=35},limit=1] xq_piece
scoreboard players set #q35 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=35},limit=1] xq_covered matches 1 run scoreboard players set #q35 xq_ctx 1
execute if score #b35 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 35
execute if score #b35 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 35
scoreboard players set #b36 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=36}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b36 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=36},limit=1] xq_piece
scoreboard players set #q36 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=36},limit=1] xq_covered matches 1 run scoreboard players set #q36 xq_ctx 1
execute if score #b36 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 36
execute if score #b36 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 36
scoreboard players set #b37 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=37}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b37 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=37},limit=1] xq_piece
scoreboard players set #q37 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=37},limit=1] xq_covered matches 1 run scoreboard players set #q37 xq_ctx 1
execute if score #b37 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 37
execute if score #b37 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 37
scoreboard players set #b38 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=38}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b38 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=38},limit=1] xq_piece
scoreboard players set #q38 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=38},limit=1] xq_covered matches 1 run scoreboard players set #q38 xq_ctx 1
execute if score #b38 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 38
execute if score #b38 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 38
scoreboard players set #b39 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=39}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b39 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=39},limit=1] xq_piece
scoreboard players set #q39 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=39},limit=1] xq_covered matches 1 run scoreboard players set #q39 xq_ctx 1
execute if score #b39 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 39
execute if score #b39 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 39
scoreboard players set #b40 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=40}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b40 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=40},limit=1] xq_piece
scoreboard players set #q40 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=40},limit=1] xq_covered matches 1 run scoreboard players set #q40 xq_ctx 1
execute if score #b40 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 40
execute if score #b40 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 40
scoreboard players set #b41 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=41}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b41 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=41},limit=1] xq_piece
scoreboard players set #q41 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=41},limit=1] xq_covered matches 1 run scoreboard players set #q41 xq_ctx 1
execute if score #b41 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 41
execute if score #b41 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 41
scoreboard players set #b42 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=42}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b42 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=42},limit=1] xq_piece
scoreboard players set #q42 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=42},limit=1] xq_covered matches 1 run scoreboard players set #q42 xq_ctx 1
execute if score #b42 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 42
execute if score #b42 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 42
scoreboard players set #b43 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=43}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b43 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=43},limit=1] xq_piece
scoreboard players set #q43 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=43},limit=1] xq_covered matches 1 run scoreboard players set #q43 xq_ctx 1
execute if score #b43 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 43
execute if score #b43 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 43
scoreboard players set #b44 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=44}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b44 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=44},limit=1] xq_piece
scoreboard players set #q44 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=44},limit=1] xq_covered matches 1 run scoreboard players set #q44 xq_ctx 1
execute if score #b44 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 44
execute if score #b44 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 44
scoreboard players set #b45 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=45}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b45 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=45},limit=1] xq_piece
scoreboard players set #q45 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=45},limit=1] xq_covered matches 1 run scoreboard players set #q45 xq_ctx 1
execute if score #b45 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 45
execute if score #b45 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 45
scoreboard players set #b46 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=46}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b46 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=46},limit=1] xq_piece
scoreboard players set #q46 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=46},limit=1] xq_covered matches 1 run scoreboard players set #q46 xq_ctx 1
execute if score #b46 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 46
execute if score #b46 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 46
scoreboard players set #b47 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=47}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b47 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=47},limit=1] xq_piece
scoreboard players set #q47 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=47},limit=1] xq_covered matches 1 run scoreboard players set #q47 xq_ctx 1
execute if score #b47 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 47
execute if score #b47 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 47
scoreboard players set #b48 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=48}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b48 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=48},limit=1] xq_piece
scoreboard players set #q48 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=48},limit=1] xq_covered matches 1 run scoreboard players set #q48 xq_ctx 1
execute if score #b48 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 48
execute if score #b48 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 48
scoreboard players set #b49 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=49}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b49 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=49},limit=1] xq_piece
scoreboard players set #q49 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=49},limit=1] xq_covered matches 1 run scoreboard players set #q49 xq_ctx 1
execute if score #b49 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 49
execute if score #b49 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 49
scoreboard players set #b50 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=50}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b50 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=50},limit=1] xq_piece
scoreboard players set #q50 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=50},limit=1] xq_covered matches 1 run scoreboard players set #q50 xq_ctx 1
execute if score #b50 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 50
execute if score #b50 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 50
scoreboard players set #b51 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=51}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b51 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=51},limit=1] xq_piece
scoreboard players set #q51 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=51},limit=1] xq_covered matches 1 run scoreboard players set #q51 xq_ctx 1
execute if score #b51 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 51
execute if score #b51 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 51
scoreboard players set #b52 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=52}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b52 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=52},limit=1] xq_piece
scoreboard players set #q52 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=52},limit=1] xq_covered matches 1 run scoreboard players set #q52 xq_ctx 1
execute if score #b52 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 52
execute if score #b52 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 52
scoreboard players set #b53 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=53}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b53 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=53},limit=1] xq_piece
scoreboard players set #q53 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=53},limit=1] xq_covered matches 1 run scoreboard players set #q53 xq_ctx 1
execute if score #b53 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 53
execute if score #b53 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 53
scoreboard players set #b54 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=54}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b54 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=54},limit=1] xq_piece
scoreboard players set #q54 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=54},limit=1] xq_covered matches 1 run scoreboard players set #q54 xq_ctx 1
execute if score #b54 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 54
execute if score #b54 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 54
scoreboard players set #b55 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=55}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b55 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=55},limit=1] xq_piece
scoreboard players set #q55 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=55},limit=1] xq_covered matches 1 run scoreboard players set #q55 xq_ctx 1
execute if score #b55 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 55
execute if score #b55 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 55
scoreboard players set #b56 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=56}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b56 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=56},limit=1] xq_piece
scoreboard players set #q56 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=56},limit=1] xq_covered matches 1 run scoreboard players set #q56 xq_ctx 1
execute if score #b56 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 56
execute if score #b56 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 56
scoreboard players set #b57 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=57}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b57 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=57},limit=1] xq_piece
scoreboard players set #q57 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=57},limit=1] xq_covered matches 1 run scoreboard players set #q57 xq_ctx 1
execute if score #b57 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 57
execute if score #b57 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 57
scoreboard players set #b58 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=58}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b58 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=58},limit=1] xq_piece
scoreboard players set #q58 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=58},limit=1] xq_covered matches 1 run scoreboard players set #q58 xq_ctx 1
execute if score #b58 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 58
execute if score #b58 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 58
scoreboard players set #b59 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=59}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b59 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=59},limit=1] xq_piece
scoreboard players set #q59 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=59},limit=1] xq_covered matches 1 run scoreboard players set #q59 xq_ctx 1
execute if score #b59 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 59
execute if score #b59 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 59
scoreboard players set #b60 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=60}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b60 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=60},limit=1] xq_piece
scoreboard players set #q60 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=60},limit=1] xq_covered matches 1 run scoreboard players set #q60 xq_ctx 1
execute if score #b60 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 60
execute if score #b60 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 60
scoreboard players set #b61 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=61}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b61 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=61},limit=1] xq_piece
scoreboard players set #q61 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=61},limit=1] xq_covered matches 1 run scoreboard players set #q61 xq_ctx 1
execute if score #b61 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 61
execute if score #b61 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 61
scoreboard players set #b62 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=62}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b62 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=62},limit=1] xq_piece
scoreboard players set #q62 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=62},limit=1] xq_covered matches 1 run scoreboard players set #q62 xq_ctx 1
execute if score #b62 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 62
execute if score #b62 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 62
scoreboard players set #b63 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=63}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b63 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=63},limit=1] xq_piece
scoreboard players set #q63 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=63},limit=1] xq_covered matches 1 run scoreboard players set #q63 xq_ctx 1
execute if score #b63 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 63
execute if score #b63 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 63
scoreboard players set #b64 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=64}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b64 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=64},limit=1] xq_piece
scoreboard players set #q64 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=64},limit=1] xq_covered matches 1 run scoreboard players set #q64 xq_ctx 1
execute if score #b64 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 64
execute if score #b64 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 64
scoreboard players set #b65 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=65}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b65 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=65},limit=1] xq_piece
scoreboard players set #q65 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=65},limit=1] xq_covered matches 1 run scoreboard players set #q65 xq_ctx 1
execute if score #b65 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 65
execute if score #b65 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 65
scoreboard players set #b66 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=66}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b66 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=66},limit=1] xq_piece
scoreboard players set #q66 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=66},limit=1] xq_covered matches 1 run scoreboard players set #q66 xq_ctx 1
execute if score #b66 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 66
execute if score #b66 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 66
scoreboard players set #b67 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=67}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b67 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=67},limit=1] xq_piece
scoreboard players set #q67 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=67},limit=1] xq_covered matches 1 run scoreboard players set #q67 xq_ctx 1
execute if score #b67 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 67
execute if score #b67 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 67
scoreboard players set #b68 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=68}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b68 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=68},limit=1] xq_piece
scoreboard players set #q68 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=68},limit=1] xq_covered matches 1 run scoreboard players set #q68 xq_ctx 1
execute if score #b68 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 68
execute if score #b68 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 68
scoreboard players set #b69 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=69}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b69 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=69},limit=1] xq_piece
scoreboard players set #q69 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=69},limit=1] xq_covered matches 1 run scoreboard players set #q69 xq_ctx 1
execute if score #b69 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 69
execute if score #b69 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 69
scoreboard players set #b70 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=70}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b70 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=70},limit=1] xq_piece
scoreboard players set #q70 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=70},limit=1] xq_covered matches 1 run scoreboard players set #q70 xq_ctx 1
execute if score #b70 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 70
execute if score #b70 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 70
scoreboard players set #b71 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=71}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b71 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=71},limit=1] xq_piece
scoreboard players set #q71 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=71},limit=1] xq_covered matches 1 run scoreboard players set #q71 xq_ctx 1
execute if score #b71 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 71
execute if score #b71 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 71
scoreboard players set #b72 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=72}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b72 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=72},limit=1] xq_piece
scoreboard players set #q72 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=72},limit=1] xq_covered matches 1 run scoreboard players set #q72 xq_ctx 1
execute if score #b72 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 72
execute if score #b72 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 72
scoreboard players set #b73 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=73}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b73 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=73},limit=1] xq_piece
scoreboard players set #q73 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=73},limit=1] xq_covered matches 1 run scoreboard players set #q73 xq_ctx 1
execute if score #b73 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 73
execute if score #b73 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 73
scoreboard players set #b74 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=74}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b74 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=74},limit=1] xq_piece
scoreboard players set #q74 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=74},limit=1] xq_covered matches 1 run scoreboard players set #q74 xq_ctx 1
execute if score #b74 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 74
execute if score #b74 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 74
scoreboard players set #b75 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=75}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b75 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=75},limit=1] xq_piece
scoreboard players set #q75 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=75},limit=1] xq_covered matches 1 run scoreboard players set #q75 xq_ctx 1
execute if score #b75 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 75
execute if score #b75 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 75
scoreboard players set #b76 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=76}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b76 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=76},limit=1] xq_piece
scoreboard players set #q76 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=76},limit=1] xq_covered matches 1 run scoreboard players set #q76 xq_ctx 1
execute if score #b76 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 76
execute if score #b76 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 76
scoreboard players set #b77 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=77}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b77 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=77},limit=1] xq_piece
scoreboard players set #q77 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=77},limit=1] xq_covered matches 1 run scoreboard players set #q77 xq_ctx 1
execute if score #b77 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 77
execute if score #b77 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 77
scoreboard players set #b78 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=78}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b78 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=78},limit=1] xq_piece
scoreboard players set #q78 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=78},limit=1] xq_covered matches 1 run scoreboard players set #q78 xq_ctx 1
execute if score #b78 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 78
execute if score #b78 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 78
scoreboard players set #b79 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=79}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b79 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=79},limit=1] xq_piece
scoreboard players set #q79 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=79},limit=1] xq_covered matches 1 run scoreboard players set #q79 xq_ctx 1
execute if score #b79 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 79
execute if score #b79 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 79
scoreboard players set #b80 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=80}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b80 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=80},limit=1] xq_piece
scoreboard players set #q80 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=80},limit=1] xq_covered matches 1 run scoreboard players set #q80 xq_ctx 1
execute if score #b80 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 80
execute if score #b80 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 80
scoreboard players set #b81 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=81}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b81 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=81},limit=1] xq_piece
scoreboard players set #q81 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=81},limit=1] xq_covered matches 1 run scoreboard players set #q81 xq_ctx 1
execute if score #b81 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 81
execute if score #b81 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 81
scoreboard players set #b82 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=82}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b82 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=82},limit=1] xq_piece
scoreboard players set #q82 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=82},limit=1] xq_covered matches 1 run scoreboard players set #q82 xq_ctx 1
execute if score #b82 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 82
execute if score #b82 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 82
scoreboard players set #b83 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=83}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b83 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=83},limit=1] xq_piece
scoreboard players set #q83 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=83},limit=1] xq_covered matches 1 run scoreboard players set #q83 xq_ctx 1
execute if score #b83 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 83
execute if score #b83 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 83
scoreboard players set #b84 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=84}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b84 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=84},limit=1] xq_piece
scoreboard players set #q84 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=84},limit=1] xq_covered matches 1 run scoreboard players set #q84 xq_ctx 1
execute if score #b84 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 84
execute if score #b84 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 84
scoreboard players set #b85 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=85}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b85 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=85},limit=1] xq_piece
scoreboard players set #q85 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=85},limit=1] xq_covered matches 1 run scoreboard players set #q85 xq_ctx 1
execute if score #b85 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 85
execute if score #b85 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 85
scoreboard players set #b86 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=86}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b86 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=86},limit=1] xq_piece
scoreboard players set #q86 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=86},limit=1] xq_covered matches 1 run scoreboard players set #q86 xq_ctx 1
execute if score #b86 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 86
execute if score #b86 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 86
scoreboard players set #b87 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=87}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b87 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=87},limit=1] xq_piece
scoreboard players set #q87 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=87},limit=1] xq_covered matches 1 run scoreboard players set #q87 xq_ctx 1
execute if score #b87 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 87
execute if score #b87 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 87
scoreboard players set #b88 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=88}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b88 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=88},limit=1] xq_piece
scoreboard players set #q88 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=88},limit=1] xq_covered matches 1 run scoreboard players set #q88 xq_ctx 1
execute if score #b88 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 88
execute if score #b88 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 88
scoreboard players set #b89 xq_ctx 0
execute store result score #cell_count xq_ctx if entity @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=89}]
execute unless score #cell_count xq_ctx matches 1 run scoreboard players set #cache_ok xq_ctx 0
scoreboard players operation #b89 xq_ctx = @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=89},limit=1] xq_piece
scoreboard players set #q89 xq_ctx 0
execute if score #variant xq_ctx matches 1 if score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=89},limit=1] xq_covered matches 1 run scoreboard players set #q89 xq_ctx 1
execute if score #b89 xq_ctx matches 6 run scoreboard players set #wking xq_ctx 89
execute if score #b89 xq_ctx matches -6 run scoreboard players set #bking xq_ctx 89
