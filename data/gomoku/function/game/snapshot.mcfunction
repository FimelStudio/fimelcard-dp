function gomoku:system/context
data modify entity @s data.gomoku.pending_undo set value {board:[]}
data modify entity @s data.gomoku.pending_undo.history set from entity @s data.gomoku.history
data modify entity @s data.gomoku.pending_undo.captublack set from entity @s data.gomoku.captublack
execute store result entity @s data.gomoku.pending_undo.turn int 1 run scoreboard players get @s gm_turn
execute store result entity @s data.gomoku.pending_undo.moves int 1 run scoreboard players get @s gm_moves
execute store result entity @s data.gomoku.pending_undo.last int 1 run scoreboard players get @s gm_last
execute store result entity @s data.gomoku.pending_undo.btime int 1 run scoreboard players get @s gm_btime
execute store result entity @s data.gomoku.pending_undo.wtime int 1 run scoreboard players get @s gm_wtime
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[0] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=0},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[1] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=1},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[2] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=2},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[3] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=3},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[4] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=4},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[5] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=5},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[6] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=6},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[7] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=7},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[8] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=8},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[9] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=9},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[10] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=10},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[11] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=11},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[12] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=12},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[13] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=13},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[14] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=14},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[15] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=15},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[16] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=16},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[17] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=17},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[18] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=18},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[19] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=19},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[20] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=20},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[21] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=21},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[22] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=22},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[23] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=23},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[24] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=24},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[25] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=25},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[26] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=26},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[27] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=27},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[28] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=28},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[29] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=29},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[30] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=30},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[31] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=31},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[32] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=32},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[33] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=33},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[34] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=34},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[35] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=35},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[36] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=36},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[37] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=37},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[38] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=38},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[39] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=39},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[40] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=40},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[41] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=41},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[42] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=42},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[43] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=43},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[44] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=44},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[45] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=45},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[46] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=46},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[47] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=47},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[48] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=48},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[49] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=49},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[50] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=50},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[51] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=51},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[52] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=52},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[53] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=53},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[54] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=54},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[55] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=55},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[56] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=56},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[57] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=57},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[58] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=58},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[59] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=59},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[60] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=60},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[61] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=61},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[62] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=62},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[63] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=63},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[64] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=64},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[65] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=65},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[66] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=66},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[67] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=67},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[68] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=68},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[69] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=69},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[70] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=70},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[71] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=71},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[72] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=72},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[73] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=73},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[74] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=74},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[75] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=75},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[76] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=76},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[77] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=77},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[78] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=78},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[79] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=79},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[80] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=80},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[81] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=81},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[82] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=82},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[83] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=83},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[84] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=84},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[85] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=85},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[86] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=86},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[87] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=87},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[88] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=88},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[89] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=89},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[90] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=90},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[91] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=91},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[92] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=92},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[93] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=93},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[94] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=94},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[95] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=95},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[96] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=96},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[97] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=97},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[98] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=98},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[99] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=99},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[100] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=100},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[101] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=101},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[102] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=102},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[103] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=103},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[104] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=104},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[105] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=105},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[106] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=106},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[107] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=107},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[108] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=108},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[109] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=109},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[110] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=110},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[111] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=111},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[112] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=112},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[113] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=113},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[114] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=114},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[115] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=115},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[116] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=116},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[117] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=117},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[118] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=118},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[119] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=119},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[120] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=120},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[121] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=121},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[122] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=122},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[123] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=123},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[124] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=124},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[125] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=125},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[126] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=126},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[127] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=127},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[128] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=128},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[129] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=129},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[130] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=130},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[131] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=131},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[132] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=132},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[133] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=133},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[134] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=134},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[135] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=135},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[136] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=136},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[137] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=137},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[138] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=138},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[139] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=139},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[140] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=140},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[141] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=141},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[142] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=142},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[143] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=143},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[144] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=144},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[145] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=145},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[146] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=146},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[147] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=147},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[148] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=148},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[149] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=149},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[150] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=150},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[151] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=151},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[152] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=152},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[153] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=153},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[154] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=154},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[155] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=155},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[156] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=156},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[157] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=157},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[158] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=158},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[159] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=159},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[160] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=160},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[161] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=161},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[162] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=162},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[163] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=163},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[164] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=164},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[165] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=165},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[166] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=166},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[167] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=167},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[168] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=168},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[169] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=169},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[170] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=170},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[171] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=171},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[172] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=172},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[173] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=173},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[174] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=174},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[175] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=175},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[176] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=176},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[177] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=177},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[178] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=178},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[179] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=179},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[180] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=180},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[181] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=181},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[182] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=182},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[183] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=183},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[184] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=184},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[185] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=185},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[186] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=186},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[187] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=187},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[188] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=188},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[189] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=189},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[190] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=190},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[191] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=191},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[192] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=192},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[193] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=193},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[194] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=194},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[195] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=195},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[196] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=196},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[197] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=197},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[198] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=198},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[199] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=199},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[200] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=200},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[201] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=201},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[202] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=202},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[203] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=203},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[204] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=204},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[205] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=205},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[206] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=206},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[207] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=207},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[208] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=208},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[209] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=209},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[210] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=210},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[211] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=211},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[212] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=212},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[213] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=213},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[214] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=214},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[215] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=215},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[216] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=216},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[217] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=217},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[218] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=218},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[219] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=219},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[220] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=220},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[221] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=221},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[222] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=222},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[223] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=223},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[224] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=224},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[225] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=225},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[226] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=226},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[227] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=227},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[228] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=228},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[229] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=229},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[230] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=230},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[231] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=231},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[232] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=232},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[233] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=233},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[234] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=234},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[235] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=235},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[236] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=236},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[237] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=237},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[238] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=238},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[239] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=239},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[240] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=240},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[241] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=241},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[242] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=242},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[243] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=243},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[244] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=244},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[245] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=245},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[246] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=246},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[247] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=247},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[248] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=248},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[249] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=249},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[250] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=250},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[251] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=251},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[252] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=252},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[253] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=253},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[254] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=254},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[255] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=255},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[256] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=256},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[257] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=257},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[258] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=258},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[259] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=259},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[260] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=260},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[261] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=261},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[262] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=262},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[263] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=263},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[264] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=264},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[265] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=265},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[266] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=266},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[267] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=267},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[268] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=268},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[269] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=269},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[270] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=270},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[271] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=271},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[272] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=272},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[273] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=273},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[274] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=274},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[275] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=275},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[276] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=276},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[277] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=277},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[278] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=278},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[279] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=279},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[280] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=280},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[281] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=281},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[282] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=282},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[283] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=283},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[284] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=284},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[285] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=285},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[286] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=286},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[287] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=287},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[288] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=288},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[289] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=289},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[290] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=290},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[291] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=291},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[292] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=292},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[293] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=293},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[294] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=294},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[295] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=295},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[296] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=296},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[297] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=297},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[298] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=298},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[299] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=299},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[300] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=300},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[301] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=301},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[302] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=302},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[303] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=303},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[304] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=304},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[305] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=305},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[306] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=306},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[307] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=307},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[308] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=308},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[309] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=309},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[310] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=310},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[311] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=311},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[312] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=312},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[313] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=313},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[314] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=314},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[315] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=315},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[316] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=316},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[317] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=317},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[318] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=318},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[319] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=319},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[320] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=320},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[321] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=321},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[322] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=322},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[323] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=323},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[324] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=324},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[325] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=325},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[326] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=326},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[327] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=327},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[328] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=328},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[329] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=329},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[330] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=330},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[331] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=331},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[332] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=332},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[333] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=333},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[334] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=334},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[335] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=335},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[336] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=336},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[337] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=337},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[338] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=338},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[339] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=339},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[340] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=340},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[341] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=341},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[342] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=342},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[343] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=343},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[344] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=344},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[345] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=345},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[346] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=346},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[347] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=347},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[348] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=348},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[349] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=349},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[350] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=350},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[351] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=351},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[352] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=352},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[353] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=353},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[354] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=354},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[355] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=355},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[356] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=356},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[357] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=357},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[358] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=358},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[359] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=359},limit=1] gm_piece
data modify entity @s data.gomoku.pending_undo.board append value 0
execute store result entity @s data.gomoku.pending_undo.board[360] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=360},limit=1] gm_piece
