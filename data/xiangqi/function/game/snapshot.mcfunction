function xiangqi:system/context
data modify entity @s data.xiangqi.pending_undo set value {board:[]}
data modify entity @s data.xiangqi.pending_undo.history set from entity @s data.xiangqi.history
data modify entity @s data.xiangqi.pending_undo.captured set from entity @s data.xiangqi.captured
execute store result entity @s data.xiangqi.pending_undo.turn int 1 run scoreboard players get @s xq_turn
execute store result entity @s data.xiangqi.pending_undo.half int 1 run scoreboard players get @s xq_half
execute store result entity @s data.xiangqi.pending_undo.full int 1 run scoreboard players get @s xq_full
execute store result entity @s data.xiangqi.pending_undo.rtime int 1 run scoreboard players get @s xq_rtime
execute store result entity @s data.xiangqi.pending_undo.btime int 1 run scoreboard players get @s xq_btime
execute store result entity @s data.xiangqi.pending_undo.rcapt int 1 run scoreboard players get @s xq_rcapt
execute store result entity @s data.xiangqi.pending_undo.bcapt int 1 run scoreboard players get @s xq_bcapt
execute store result entity @s data.xiangqi.pending_undo.check int 1 run scoreboard players get @s xq_check
execute store result entity @s data.xiangqi.pending_undo.repetition int 1 run scoreboard players get @s xq_repetition
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[0] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=0},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[1] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=1},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[2] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=2},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[3] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=3},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[4] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=4},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[5] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=5},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[6] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=6},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[7] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=7},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[8] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=8},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[9] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=9},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[10] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=10},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[11] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=11},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[12] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=12},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[13] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=13},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[14] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=14},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[15] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=15},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[16] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=16},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[17] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=17},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[18] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=18},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[19] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=19},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[20] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=20},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[21] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=21},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[22] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=22},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[23] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=23},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[24] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=24},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[25] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=25},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[26] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=26},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[27] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=27},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[28] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=28},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[29] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=29},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[30] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=30},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[31] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=31},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[32] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=32},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[33] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=33},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[34] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=34},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[35] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=35},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[36] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=36},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[37] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=37},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[38] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=38},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[39] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=39},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[40] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=40},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[41] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=41},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[42] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=42},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[43] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=43},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[44] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=44},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[45] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=45},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[46] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=46},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[47] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=47},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[48] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=48},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[49] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=49},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[50] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=50},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[51] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=51},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[52] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=52},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[53] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=53},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[54] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=54},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[55] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=55},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[56] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=56},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[57] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=57},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[58] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=58},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[59] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=59},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[60] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=60},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[61] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=61},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[62] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=62},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[63] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=63},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[64] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=64},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[65] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=65},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[66] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=66},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[67] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=67},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[68] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=68},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[69] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=69},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[70] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=70},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[71] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=71},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[72] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=72},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[73] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=73},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[74] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=74},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[75] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=75},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[76] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=76},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[77] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=77},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[78] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=78},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[79] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=79},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[80] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=80},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[81] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=81},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[82] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=82},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[83] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=83},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[84] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=84},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[85] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=85},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[86] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=86},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[87] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=87},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[88] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=88},limit=1] xq_piece
data modify entity @s data.xiangqi.pending_undo.board append value 0
execute store result entity @s data.xiangqi.pending_undo.board[89] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=89},limit=1] xq_piece
