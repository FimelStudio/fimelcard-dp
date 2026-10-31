function gomoku:ai/reset
execute store result score @s gm_turn run data get entity @s data.gomoku.undo.turn
execute store result score @s gm_moves run data get entity @s data.gomoku.undo.moves
execute store result score @s gm_last run data get entity @s data.gomoku.undo.last
execute store result score @s gm_btime run data get entity @s data.gomoku.undo.btime
execute store result score @s gm_wtime run data get entity @s data.gomoku.undo.wtime
data modify entity @s data.gomoku.history set from entity @s data.gomoku.undo.history
data modify entity @s data.gomoku.captublack set from entity @s data.gomoku.undo.captublack
data modify storage gomoku:undo saved set from entity @s data.gomoku.undo
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[0]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=0},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[1]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=1},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[2]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=2},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[3]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=3},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[4]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=4},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[5]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=5},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[6]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=6},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[7]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=7},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[8]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=8},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[9]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=9},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[10]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=10},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[11]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=11},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[12]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=12},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[13]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=13},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[14]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=14},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[15]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=15},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[16]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=16},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[17]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=17},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[18]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=18},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[19]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=19},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[20]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=20},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[21]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=21},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[22]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=22},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[23]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=23},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[24]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=24},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[25]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=25},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[26]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=26},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[27]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=27},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[28]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=28},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[29]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=29},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[30]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=30},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[31]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=31},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[32]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=32},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[33]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=33},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[34]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=34},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[35]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=35},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[36]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=36},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[37]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=37},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[38]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=38},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[39]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=39},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[40]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=40},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[41]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=41},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[42]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=42},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[43]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=43},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[44]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=44},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[45]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=45},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[46]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=46},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[47]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=47},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[48]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=48},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[49]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=49},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[50]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=50},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[51]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=51},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[52]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=52},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[53]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=53},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[54]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=54},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[55]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=55},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[56]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=56},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[57]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=57},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[58]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=58},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[59]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=59},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[60]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=60},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[61]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=61},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[62]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=62},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[63]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=63},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[64]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=64},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[65]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=65},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[66]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=66},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[67]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=67},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[68]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=68},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[69]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=69},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[70]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=70},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[71]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=71},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[72]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=72},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[73]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=73},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[74]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=74},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[75]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=75},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[76]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=76},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[77]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=77},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[78]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=78},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[79]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=79},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[80]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=80},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[81]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=81},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[82]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=82},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[83]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=83},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[84]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=84},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[85]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=85},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[86]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=86},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[87]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=87},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[88]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=88},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[89]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=89},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[90]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=90},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[91]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=91},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[92]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=92},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[93]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=93},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[94]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=94},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[95]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=95},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[96]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=96},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[97]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=97},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[98]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=98},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[99]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=99},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[100]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=100},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[101]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=101},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[102]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=102},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[103]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=103},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[104]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=104},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[105]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=105},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[106]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=106},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[107]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=107},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[108]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=108},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[109]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=109},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[110]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=110},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[111]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=111},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[112]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=112},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[113]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=113},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[114]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=114},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[115]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=115},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[116]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=116},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[117]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=117},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[118]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=118},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[119]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=119},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[120]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=120},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[121]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=121},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[122]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=122},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[123]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=123},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[124]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=124},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[125]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=125},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[126]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=126},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[127]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=127},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[128]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=128},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[129]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=129},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[130]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=130},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[131]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=131},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[132]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=132},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[133]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=133},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[134]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=134},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[135]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=135},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[136]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=136},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[137]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=137},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[138]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=138},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[139]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=139},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[140]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=140},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[141]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=141},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[142]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=142},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[143]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=143},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[144]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=144},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[145]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=145},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[146]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=146},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[147]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=147},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[148]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=148},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[149]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=149},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[150]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=150},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[151]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=151},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[152]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=152},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[153]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=153},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[154]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=154},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[155]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=155},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[156]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=156},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[157]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=157},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[158]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=158},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[159]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=159},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[160]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=160},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[161]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=161},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[162]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=162},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[163]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=163},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[164]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=164},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[165]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=165},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[166]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=166},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[167]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=167},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[168]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=168},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[169]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=169},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[170]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=170},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[171]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=171},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[172]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=172},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[173]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=173},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[174]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=174},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[175]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=175},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[176]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=176},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[177]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=177},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[178]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=178},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[179]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=179},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[180]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=180},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[181]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=181},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[182]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=182},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[183]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=183},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[184]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=184},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[185]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=185},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[186]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=186},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[187]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=187},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[188]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=188},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[189]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=189},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[190]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=190},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[191]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=191},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[192]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=192},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[193]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=193},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[194]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=194},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[195]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=195},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[196]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=196},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[197]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=197},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[198]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=198},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[199]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=199},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[200]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=200},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[201]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=201},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[202]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=202},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[203]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=203},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[204]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=204},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[205]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=205},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[206]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=206},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[207]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=207},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[208]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=208},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[209]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=209},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[210]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=210},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[211]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=211},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[212]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=212},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[213]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=213},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[214]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=214},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[215]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=215},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[216]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=216},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[217]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=217},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[218]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=218},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[219]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=219},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[220]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=220},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[221]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=221},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[222]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=222},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[223]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=223},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[224]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=224},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[225]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=225},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[226]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=226},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[227]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=227},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[228]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=228},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[229]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=229},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[230]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=230},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[231]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=231},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[232]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=232},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[233]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=233},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[234]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=234},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[235]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=235},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[236]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=236},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[237]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=237},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[238]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=238},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[239]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=239},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[240]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=240},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[241]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=241},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[242]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=242},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[243]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=243},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[244]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=244},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[245]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=245},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[246]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=246},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[247]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=247},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[248]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=248},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[249]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=249},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[250]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=250},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[251]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=251},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[252]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=252},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[253]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=253},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[254]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=254},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[255]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=255},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[256]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=256},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[257]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=257},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[258]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=258},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[259]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=259},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[260]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=260},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[261]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=261},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[262]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=262},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[263]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=263},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[264]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=264},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[265]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=265},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[266]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=266},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[267]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=267},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[268]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=268},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[269]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=269},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[270]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=270},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[271]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=271},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[272]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=272},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[273]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=273},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[274]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=274},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[275]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=275},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[276]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=276},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[277]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=277},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[278]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=278},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[279]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=279},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[280]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=280},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[281]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=281},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[282]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=282},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[283]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=283},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[284]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=284},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[285]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=285},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[286]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=286},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[287]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=287},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[288]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=288},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[289]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=289},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[290]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=290},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[291]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=291},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[292]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=292},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[293]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=293},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[294]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=294},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[295]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=295},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[296]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=296},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[297]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=297},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[298]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=298},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[299]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=299},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[300]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=300},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[301]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=301},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[302]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=302},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[303]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=303},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[304]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=304},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[305]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=305},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[306]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=306},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[307]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=307},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[308]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=308},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[309]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=309},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[310]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=310},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[311]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=311},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[312]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=312},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[313]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=313},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[314]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=314},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[315]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=315},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[316]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=316},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[317]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=317},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[318]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=318},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[319]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=319},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[320]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=320},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[321]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=321},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[322]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=322},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[323]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=323},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[324]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=324},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[325]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=325},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[326]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=326},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[327]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=327},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[328]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=328},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[329]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=329},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[330]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=330},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[331]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=331},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[332]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=332},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[333]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=333},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[334]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=334},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[335]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=335},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[336]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=336},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[337]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=337},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[338]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=338},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[339]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=339},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[340]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=340},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[341]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=341},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[342]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=342},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[343]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=343},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[344]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=344},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[345]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=345},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[346]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=346},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[347]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=347},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[348]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=348},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[349]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=349},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[350]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=350},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[351]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=351},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[352]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=352},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[353]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=353},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[354]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=354},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[355]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=355},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[356]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=356},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[357]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=357},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[358]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=358},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[359]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=359},limit=1] gm_piece = #restore gm_ctx
execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[360]
scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=360},limit=1] gm_piece = #restore gm_ctx
data remove entity @s data.gomoku.undo
data remove entity @s data.gomoku.pending_undo
data remove entity @s data.gomoku.ai_undo
data remove storage gomoku:undo saved
scoreboard players set @s gm_undo 0
scoreboard players set @s gm_draw 0
scoreboard players set @s gm_sel -1
scoreboard players set @s gm_result 0
scoreboard players set @s gm_reason 0
scoreboard players add @s gm_epoch 1
function gomoku:visual/undo
function gomoku:sound/undo
scoreboard players set @s gm_animundo 1
scoreboard players set @s gm_state 2
scoreboard players set @s gm_timer 6
function gomoku:clock/update
function gomoku:ui/refresh
execute if score @s gm_bot matches 0 run tellraw @a[tag=gm.audience] {"text": "[五子棋] 对手同意悔棋，已撤回最后一步，并恢复该步之前的局面与时钟。", "color": "yellow"}
execute unless score @s gm_bot matches 0 run tellraw @a[tag=gm.audience] {"text": "[五子棋] 人机同意悔棋，已恢复到你上次落子之前的局面与时钟。", "color": "yellow"}
