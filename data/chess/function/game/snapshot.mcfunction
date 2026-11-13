function chess:system/context
data modify entity @s data.chess.pending_undo set value {board:[]}
data modify entity @s data.chess.pending_undo.history set from entity @s data.chess.history
data modify entity @s data.chess.pending_undo.captured set from entity @s data.chess.captured
execute store result entity @s data.chess.pending_undo.turn int 1 run scoreboard players get @s ch_turn
execute store result entity @s data.chess.pending_undo.castle int 1 run scoreboard players get @s ch_castle
execute store result entity @s data.chess.pending_undo.ep int 1 run scoreboard players get @s ch_ep
execute store result entity @s data.chess.pending_undo.half int 1 run scoreboard players get @s ch_half
execute store result entity @s data.chess.pending_undo.full int 1 run scoreboard players get @s ch_full
execute store result entity @s data.chess.pending_undo.wtime int 1 run scoreboard players get @s ch_wtime
execute store result entity @s data.chess.pending_undo.btime int 1 run scoreboard players get @s ch_btime
execute store result entity @s data.chess.pending_undo.wcapt int 1 run scoreboard players get @s ch_wcapt
execute store result entity @s data.chess.pending_undo.bcapt int 1 run scoreboard players get @s ch_bcapt
execute store result entity @s data.chess.pending_undo.check int 1 run scoreboard players get @s ch_check
execute store result entity @s data.chess.pending_undo.repetition int 1 run scoreboard players get @s ch_repetition
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[0] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=0},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[1] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=1},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[2] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=2},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[3] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=3},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[4] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=4},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[5] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=5},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[6] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=6},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[7] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=7},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[8] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=8},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[9] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=9},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[10] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=10},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[11] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=11},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[12] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=12},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[13] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=13},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[14] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=14},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[15] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=15},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[16] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=16},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[17] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=17},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[18] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=18},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[19] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=19},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[20] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=20},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[21] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=21},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[22] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=22},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[23] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=23},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[24] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=24},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[25] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=25},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[26] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=26},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[27] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=27},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[28] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=28},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[29] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=29},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[30] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=30},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[31] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=31},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[32] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=32},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[33] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=33},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[34] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=34},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[35] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=35},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[36] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=36},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[37] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=37},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[38] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=38},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[39] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=39},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[40] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=40},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[41] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=41},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[42] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=42},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[43] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=43},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[44] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=44},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[45] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=45},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[46] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=46},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[47] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=47},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[48] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=48},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[49] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=49},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[50] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=50},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[51] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=51},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[52] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=52},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[53] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=53},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[54] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=54},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[55] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=55},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[56] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=56},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[57] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=57},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[58] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=58},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[59] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=59},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[60] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=60},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[61] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=61},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[62] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=62},limit=1] ch_piece
data modify entity @s data.chess.pending_undo.board append value 0
execute store result entity @s data.chess.pending_undo.board[63] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=63},limit=1] ch_piece
