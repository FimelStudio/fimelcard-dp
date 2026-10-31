# 单次同步64格；之后走法/受攻击判断只访问分数缓存，不反复搜索实体。
scoreboard players operation #side ch_ctx = @s ch_turn
scoreboard players operation #castle ch_ctx = @s ch_castle
scoreboard players operation #ep ch_ctx = @s ch_ep
scoreboard players set #wking ch_ctx -1
scoreboard players set #bking ch_ctx -1
scoreboard players set #cache_ok ch_ctx 1
execute store result score #cache_size ch_ctx if entity @e[type=minecraft:marker,tag=ch.board]
execute unless score #cache_size ch_ctx matches 64 run scoreboard players set #cache_ok ch_ctx 0
execute as @e[type=minecraft:marker,tag=ch.board] unless score @s ch_piece matches -6..6 run scoreboard players set #cache_ok ch_ctx 0
execute store result score #king_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_piece=6}]
execute unless score #king_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
execute store result score #king_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_piece=-6}]
execute unless score #king_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players set #b0 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=0}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b0 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=0},limit=1] ch_piece
execute if score #b0 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 0
execute if score #b0 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 0
scoreboard players set #b1 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=1}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b1 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=1},limit=1] ch_piece
execute if score #b1 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 1
execute if score #b1 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 1
scoreboard players set #b2 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=2}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b2 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=2},limit=1] ch_piece
execute if score #b2 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 2
execute if score #b2 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 2
scoreboard players set #b3 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=3}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b3 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=3},limit=1] ch_piece
execute if score #b3 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 3
execute if score #b3 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 3
scoreboard players set #b4 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=4}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b4 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=4},limit=1] ch_piece
execute if score #b4 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 4
execute if score #b4 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 4
scoreboard players set #b5 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=5}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b5 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=5},limit=1] ch_piece
execute if score #b5 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 5
execute if score #b5 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 5
scoreboard players set #b6 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=6}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b6 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=6},limit=1] ch_piece
execute if score #b6 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 6
execute if score #b6 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 6
scoreboard players set #b7 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=7}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b7 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=7},limit=1] ch_piece
execute if score #b7 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 7
execute if score #b7 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 7
scoreboard players set #b8 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=8}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b8 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=8},limit=1] ch_piece
execute if score #b8 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 8
execute if score #b8 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 8
scoreboard players set #b9 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=9}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b9 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=9},limit=1] ch_piece
execute if score #b9 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 9
execute if score #b9 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 9
scoreboard players set #b10 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=10}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b10 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=10},limit=1] ch_piece
execute if score #b10 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 10
execute if score #b10 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 10
scoreboard players set #b11 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=11}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b11 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=11},limit=1] ch_piece
execute if score #b11 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 11
execute if score #b11 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 11
scoreboard players set #b12 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=12}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b12 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=12},limit=1] ch_piece
execute if score #b12 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 12
execute if score #b12 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 12
scoreboard players set #b13 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=13}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b13 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=13},limit=1] ch_piece
execute if score #b13 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 13
execute if score #b13 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 13
scoreboard players set #b14 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=14}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b14 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=14},limit=1] ch_piece
execute if score #b14 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 14
execute if score #b14 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 14
scoreboard players set #b15 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=15}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b15 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=15},limit=1] ch_piece
execute if score #b15 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 15
execute if score #b15 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 15
scoreboard players set #b16 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=16}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b16 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=16},limit=1] ch_piece
execute if score #b16 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 16
execute if score #b16 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 16
scoreboard players set #b17 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=17}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b17 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=17},limit=1] ch_piece
execute if score #b17 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 17
execute if score #b17 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 17
scoreboard players set #b18 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=18}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b18 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=18},limit=1] ch_piece
execute if score #b18 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 18
execute if score #b18 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 18
scoreboard players set #b19 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=19}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b19 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=19},limit=1] ch_piece
execute if score #b19 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 19
execute if score #b19 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 19
scoreboard players set #b20 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=20}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b20 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=20},limit=1] ch_piece
execute if score #b20 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 20
execute if score #b20 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 20
scoreboard players set #b21 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=21}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b21 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=21},limit=1] ch_piece
execute if score #b21 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 21
execute if score #b21 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 21
scoreboard players set #b22 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=22}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b22 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=22},limit=1] ch_piece
execute if score #b22 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 22
execute if score #b22 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 22
scoreboard players set #b23 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=23}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b23 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=23},limit=1] ch_piece
execute if score #b23 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 23
execute if score #b23 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 23
scoreboard players set #b24 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=24}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b24 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=24},limit=1] ch_piece
execute if score #b24 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 24
execute if score #b24 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 24
scoreboard players set #b25 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=25}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b25 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=25},limit=1] ch_piece
execute if score #b25 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 25
execute if score #b25 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 25
scoreboard players set #b26 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=26}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b26 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=26},limit=1] ch_piece
execute if score #b26 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 26
execute if score #b26 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 26
scoreboard players set #b27 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=27}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b27 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=27},limit=1] ch_piece
execute if score #b27 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 27
execute if score #b27 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 27
scoreboard players set #b28 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=28}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b28 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=28},limit=1] ch_piece
execute if score #b28 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 28
execute if score #b28 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 28
scoreboard players set #b29 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=29}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b29 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=29},limit=1] ch_piece
execute if score #b29 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 29
execute if score #b29 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 29
scoreboard players set #b30 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=30}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b30 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=30},limit=1] ch_piece
execute if score #b30 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 30
execute if score #b30 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 30
scoreboard players set #b31 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=31}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b31 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=31},limit=1] ch_piece
execute if score #b31 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 31
execute if score #b31 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 31
scoreboard players set #b32 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=32}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b32 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=32},limit=1] ch_piece
execute if score #b32 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 32
execute if score #b32 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 32
scoreboard players set #b33 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=33}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b33 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=33},limit=1] ch_piece
execute if score #b33 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 33
execute if score #b33 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 33
scoreboard players set #b34 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=34}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b34 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=34},limit=1] ch_piece
execute if score #b34 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 34
execute if score #b34 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 34
scoreboard players set #b35 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=35}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b35 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=35},limit=1] ch_piece
execute if score #b35 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 35
execute if score #b35 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 35
scoreboard players set #b36 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=36}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b36 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=36},limit=1] ch_piece
execute if score #b36 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 36
execute if score #b36 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 36
scoreboard players set #b37 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=37}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b37 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=37},limit=1] ch_piece
execute if score #b37 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 37
execute if score #b37 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 37
scoreboard players set #b38 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=38}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b38 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=38},limit=1] ch_piece
execute if score #b38 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 38
execute if score #b38 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 38
scoreboard players set #b39 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=39}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b39 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=39},limit=1] ch_piece
execute if score #b39 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 39
execute if score #b39 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 39
scoreboard players set #b40 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=40}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b40 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=40},limit=1] ch_piece
execute if score #b40 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 40
execute if score #b40 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 40
scoreboard players set #b41 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=41}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b41 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=41},limit=1] ch_piece
execute if score #b41 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 41
execute if score #b41 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 41
scoreboard players set #b42 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=42}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b42 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=42},limit=1] ch_piece
execute if score #b42 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 42
execute if score #b42 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 42
scoreboard players set #b43 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=43}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b43 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=43},limit=1] ch_piece
execute if score #b43 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 43
execute if score #b43 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 43
scoreboard players set #b44 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=44}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b44 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=44},limit=1] ch_piece
execute if score #b44 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 44
execute if score #b44 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 44
scoreboard players set #b45 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=45}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b45 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=45},limit=1] ch_piece
execute if score #b45 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 45
execute if score #b45 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 45
scoreboard players set #b46 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=46}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b46 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=46},limit=1] ch_piece
execute if score #b46 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 46
execute if score #b46 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 46
scoreboard players set #b47 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=47}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b47 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=47},limit=1] ch_piece
execute if score #b47 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 47
execute if score #b47 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 47
scoreboard players set #b48 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=48}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b48 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=48},limit=1] ch_piece
execute if score #b48 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 48
execute if score #b48 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 48
scoreboard players set #b49 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=49}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b49 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=49},limit=1] ch_piece
execute if score #b49 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 49
execute if score #b49 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 49
scoreboard players set #b50 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=50}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b50 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=50},limit=1] ch_piece
execute if score #b50 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 50
execute if score #b50 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 50
scoreboard players set #b51 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=51}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b51 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=51},limit=1] ch_piece
execute if score #b51 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 51
execute if score #b51 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 51
scoreboard players set #b52 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=52}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b52 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=52},limit=1] ch_piece
execute if score #b52 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 52
execute if score #b52 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 52
scoreboard players set #b53 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=53}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b53 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=53},limit=1] ch_piece
execute if score #b53 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 53
execute if score #b53 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 53
scoreboard players set #b54 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=54}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b54 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=54},limit=1] ch_piece
execute if score #b54 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 54
execute if score #b54 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 54
scoreboard players set #b55 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=55}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b55 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=55},limit=1] ch_piece
execute if score #b55 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 55
execute if score #b55 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 55
scoreboard players set #b56 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=56}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b56 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=56},limit=1] ch_piece
execute if score #b56 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 56
execute if score #b56 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 56
scoreboard players set #b57 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=57}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b57 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=57},limit=1] ch_piece
execute if score #b57 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 57
execute if score #b57 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 57
scoreboard players set #b58 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=58}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b58 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=58},limit=1] ch_piece
execute if score #b58 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 58
execute if score #b58 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 58
scoreboard players set #b59 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=59}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b59 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=59},limit=1] ch_piece
execute if score #b59 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 59
execute if score #b59 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 59
scoreboard players set #b60 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=60}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b60 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=60},limit=1] ch_piece
execute if score #b60 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 60
execute if score #b60 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 60
scoreboard players set #b61 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=61}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b61 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=61},limit=1] ch_piece
execute if score #b61 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 61
execute if score #b61 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 61
scoreboard players set #b62 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=62}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b62 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=62},limit=1] ch_piece
execute if score #b62 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 62
execute if score #b62 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 62
scoreboard players set #b63 ch_ctx 0
execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=63}]
execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
scoreboard players operation #b63 ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=63},limit=1] ch_piece
execute if score #b63 ch_ctx matches 6 run scoreboard players set #wking ch_ctx 63
execute if score #b63 ch_ctx matches -6 run scoreboard players set #bking ch_ctx 63
