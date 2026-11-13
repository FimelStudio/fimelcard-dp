data modify storage weiqi:runtime position set value {hash:0,board:[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}
scoreboard players set #hash go_ctx 0
scoreboard players set #row0 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=0,go_piece=1}] run scoreboard players operation #row0 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=0,go_piece=-1}] run scoreboard players operation #row0 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[0] int 1 run scoreboard players get #row0 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row0 go_ctx
scoreboard players set #row1 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=1,go_piece=1}] run scoreboard players operation #row1 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=1,go_piece=-1}] run scoreboard players operation #row1 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[1] int 1 run scoreboard players get #row1 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row1 go_ctx
scoreboard players set #row2 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=2,go_piece=1}] run scoreboard players operation #row2 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=2,go_piece=-1}] run scoreboard players operation #row2 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[2] int 1 run scoreboard players get #row2 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row2 go_ctx
scoreboard players set #row3 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=3,go_piece=1}] run scoreboard players operation #row3 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=3,go_piece=-1}] run scoreboard players operation #row3 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[3] int 1 run scoreboard players get #row3 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row3 go_ctx
scoreboard players set #row4 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=4,go_piece=1}] run scoreboard players operation #row4 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=4,go_piece=-1}] run scoreboard players operation #row4 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[4] int 1 run scoreboard players get #row4 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row4 go_ctx
scoreboard players set #row5 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=5,go_piece=1}] run scoreboard players operation #row5 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=5,go_piece=-1}] run scoreboard players operation #row5 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[5] int 1 run scoreboard players get #row5 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row5 go_ctx
scoreboard players set #row6 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=6,go_piece=1}] run scoreboard players operation #row6 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=6,go_piece=-1}] run scoreboard players operation #row6 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[6] int 1 run scoreboard players get #row6 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row6 go_ctx
scoreboard players set #row7 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=7,go_piece=1}] run scoreboard players operation #row7 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=7,go_piece=-1}] run scoreboard players operation #row7 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[7] int 1 run scoreboard players get #row7 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row7 go_ctx
scoreboard players set #row8 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=8,go_piece=1}] run scoreboard players operation #row8 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=8,go_piece=-1}] run scoreboard players operation #row8 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[8] int 1 run scoreboard players get #row8 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row8 go_ctx
scoreboard players set #row9 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=9,go_piece=1}] run scoreboard players operation #row9 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=9,go_piece=-1}] run scoreboard players operation #row9 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[9] int 1 run scoreboard players get #row9 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row9 go_ctx
scoreboard players set #row10 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=10,go_piece=1}] run scoreboard players operation #row10 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=10,go_piece=-1}] run scoreboard players operation #row10 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[10] int 1 run scoreboard players get #row10 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row10 go_ctx
scoreboard players set #row11 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=11,go_piece=1}] run scoreboard players operation #row11 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=11,go_piece=-1}] run scoreboard players operation #row11 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[11] int 1 run scoreboard players get #row11 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row11 go_ctx
scoreboard players set #row12 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=12,go_piece=1}] run scoreboard players operation #row12 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=12,go_piece=-1}] run scoreboard players operation #row12 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[12] int 1 run scoreboard players get #row12 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row12 go_ctx
scoreboard players set #row13 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=13,go_piece=1}] run scoreboard players operation #row13 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=13,go_piece=-1}] run scoreboard players operation #row13 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[13] int 1 run scoreboard players get #row13 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row13 go_ctx
scoreboard players set #row14 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=14,go_piece=1}] run scoreboard players operation #row14 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=14,go_piece=-1}] run scoreboard players operation #row14 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[14] int 1 run scoreboard players get #row14 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row14 go_ctx
scoreboard players set #row15 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=15,go_piece=1}] run scoreboard players operation #row15 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=15,go_piece=-1}] run scoreboard players operation #row15 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[15] int 1 run scoreboard players get #row15 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row15 go_ctx
scoreboard players set #row16 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=16,go_piece=1}] run scoreboard players operation #row16 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=16,go_piece=-1}] run scoreboard players operation #row16 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[16] int 1 run scoreboard players get #row16 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row16 go_ctx
scoreboard players set #row17 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=17,go_piece=1}] run scoreboard players operation #row17 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=17,go_piece=-1}] run scoreboard players operation #row17 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[17] int 1 run scoreboard players get #row17 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row17 go_ctx
scoreboard players set #row18 go_ctx 0
execute as @e[tag=go.board,scores={go_rank=18,go_piece=1}] run scoreboard players operation #row18 go_ctx += @s go_pow
execute as @e[tag=go.board,scores={go_rank=18,go_piece=-1}] run scoreboard players operation #row18 go_ctx += @s go_pow2
execute store result storage weiqi:runtime position.board[18] int 1 run scoreboard players get #row18 go_ctx
scoreboard players operation #hash go_ctx *= #thirtyone go_ctx
scoreboard players operation #hash go_ctx += #row18 go_ctx
execute store result storage weiqi:runtime position.hash int 1 run scoreboard players get #hash go_ctx
