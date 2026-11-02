function xiangqi:ai/reset
execute store result score @s xq_turn run data get entity @s data.xiangqi.undo.turn
execute store result score @s xq_half run data get entity @s data.xiangqi.undo.half
execute store result score @s xq_full run data get entity @s data.xiangqi.undo.full
execute store result score @s xq_rtime run data get entity @s data.xiangqi.undo.rtime
execute store result score @s xq_btime run data get entity @s data.xiangqi.undo.btime
execute store result score @s xq_rcapt run data get entity @s data.xiangqi.undo.rcapt
execute store result score @s xq_bcapt run data get entity @s data.xiangqi.undo.bcapt
execute store result score @s xq_check run data get entity @s data.xiangqi.undo.check
execute store result score @s xq_repetition run data get entity @s data.xiangqi.undo.repetition
data modify entity @s data.xiangqi.history set from entity @s data.xiangqi.undo.history
data modify entity @s data.xiangqi.captured set from entity @s data.xiangqi.undo.captured
data modify storage xiangqi:undo saved set from entity @s data.xiangqi.undo
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[0]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=0},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[1]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=1},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[2]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=2},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[3]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=3},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[4]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=4},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[5]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=5},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[6]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=6},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[7]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=7},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[8]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=8},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[9]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=9},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[10]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=10},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[11]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=11},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[12]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=12},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[13]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=13},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[14]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=14},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[15]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=15},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[16]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=16},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[17]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=17},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[18]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=18},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[19]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=19},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[20]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=20},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[21]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=21},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[22]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=22},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[23]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=23},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[24]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=24},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[25]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=25},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[26]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=26},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[27]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=27},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[28]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=28},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[29]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=29},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[30]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=30},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[31]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=31},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[32]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=32},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[33]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=33},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[34]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=34},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[35]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=35},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[36]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=36},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[37]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=37},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[38]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=38},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[39]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=39},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[40]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=40},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[41]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=41},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[42]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=42},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[43]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=43},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[44]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=44},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[45]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=45},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[46]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=46},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[47]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=47},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[48]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=48},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[49]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=49},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[50]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=50},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[51]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=51},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[52]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=52},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[53]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=53},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[54]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=54},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[55]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=55},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[56]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=56},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[57]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=57},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[58]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=58},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[59]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=59},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[60]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=60},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[61]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=61},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[62]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=62},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[63]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=63},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[64]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=64},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[65]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=65},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[66]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=66},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[67]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=67},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[68]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=68},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[69]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=69},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[70]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=70},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[71]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=71},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[72]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=72},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[73]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=73},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[74]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=74},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[75]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=75},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[76]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=76},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[77]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=77},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[78]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=78},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[79]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=79},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[80]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=80},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[81]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=81},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[82]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=82},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[83]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=83},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[84]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=84},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[85]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=85},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[86]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=86},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[87]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=87},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[88]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=88},limit=1] xq_piece = #restore xq_ctx
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[89]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=89},limit=1] xq_piece = #restore xq_ctx
data remove entity @s data.xiangqi.undo
data remove entity @s data.xiangqi.pending_undo
data remove entity @s data.xiangqi.ai_undo
data remove entity @s data.xiangqi.last
data remove storage xiangqi:undo saved
scoreboard players set @s xq_undo 0
scoreboard players set @s xq_draw 0
scoreboard players set @s xq_sel -1
scoreboard players set @s xq_result 0
scoreboard players set @s xq_reason 0
scoreboard players add @s xq_epoch 1
function xiangqi:visual/refresh
function xiangqi:clock/update
function xiangqi:ui/refresh
execute if score @s xq_bot matches 0 run tellraw @a[tag=xq.audience] {"text": "[中国象棋] 对手同意悔棋，已撤回最后一步，并恢复该步之前的局面与时钟。", "color": "yellow"}
execute unless score @s xq_bot matches 0 run tellraw @a[tag=xq.audience] {"text": "[中国象棋] 人机同意悔棋，已恢复到你上次走子之前的局面与时钟。", "color": "yellow"}
