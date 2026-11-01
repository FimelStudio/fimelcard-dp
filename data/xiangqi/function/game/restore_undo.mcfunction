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
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=0},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=0},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[0] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=0},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[0]
execute if data storage xiangqi:undo saved.covered[0] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=0},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[0]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[1]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=1},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=1},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=1},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[1] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=1},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[1]
execute if data storage xiangqi:undo saved.covered[1] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=1},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[1]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[2]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=2},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=2},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=2},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[2] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=2},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[2]
execute if data storage xiangqi:undo saved.covered[2] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=2},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[2]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[3]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=3},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=3},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=3},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[3] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=3},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[3]
execute if data storage xiangqi:undo saved.covered[3] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=3},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[3]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[4]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=4},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=4},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=4},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[4] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=4},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[4]
execute if data storage xiangqi:undo saved.covered[4] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=4},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[4]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[5]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=5},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=5},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=5},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[5] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=5},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[5]
execute if data storage xiangqi:undo saved.covered[5] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=5},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[5]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[6]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=6},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=6},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=6},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[6] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=6},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[6]
execute if data storage xiangqi:undo saved.covered[6] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=6},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[6]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[7]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=7},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=7},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=7},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[7] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=7},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[7]
execute if data storage xiangqi:undo saved.covered[7] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=7},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[7]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[8]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=8},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=8},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=8},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[8] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=8},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[8]
execute if data storage xiangqi:undo saved.covered[8] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=8},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[8]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[9]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=9},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=9},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=9},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[9] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=9},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[9]
execute if data storage xiangqi:undo saved.covered[9] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=9},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[9]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[10]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=10},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=10},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=10},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[10] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=10},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[10]
execute if data storage xiangqi:undo saved.covered[10] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=10},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[10]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[11]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=11},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=11},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=11},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[11] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=11},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[11]
execute if data storage xiangqi:undo saved.covered[11] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=11},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[11]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[12]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=12},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=12},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=12},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[12] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=12},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[12]
execute if data storage xiangqi:undo saved.covered[12] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=12},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[12]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[13]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=13},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=13},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=13},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[13] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=13},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[13]
execute if data storage xiangqi:undo saved.covered[13] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=13},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[13]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[14]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=14},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=14},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=14},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[14] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=14},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[14]
execute if data storage xiangqi:undo saved.covered[14] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=14},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[14]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[15]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=15},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=15},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=15},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[15] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=15},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[15]
execute if data storage xiangqi:undo saved.covered[15] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=15},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[15]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[16]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=16},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=16},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=16},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[16] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=16},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[16]
execute if data storage xiangqi:undo saved.covered[16] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=16},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[16]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[17]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=17},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=17},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=17},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[17] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=17},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[17]
execute if data storage xiangqi:undo saved.covered[17] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=17},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[17]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[18]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=18},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=18},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=18},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[18] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=18},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[18]
execute if data storage xiangqi:undo saved.covered[18] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=18},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[18]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[19]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=19},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=19},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=19},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[19] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=19},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[19]
execute if data storage xiangqi:undo saved.covered[19] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=19},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[19]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[20]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=20},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=20},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=20},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[20] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=20},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[20]
execute if data storage xiangqi:undo saved.covered[20] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=20},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[20]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[21]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=21},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=21},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=21},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[21] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=21},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[21]
execute if data storage xiangqi:undo saved.covered[21] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=21},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[21]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[22]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=22},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=22},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=22},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[22] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=22},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[22]
execute if data storage xiangqi:undo saved.covered[22] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=22},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[22]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[23]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=23},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=23},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=23},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[23] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=23},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[23]
execute if data storage xiangqi:undo saved.covered[23] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=23},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[23]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[24]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=24},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=24},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=24},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[24] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=24},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[24]
execute if data storage xiangqi:undo saved.covered[24] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=24},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[24]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[25]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=25},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=25},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=25},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[25] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=25},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[25]
execute if data storage xiangqi:undo saved.covered[25] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=25},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[25]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[26]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=26},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=26},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=26},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[26] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=26},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[26]
execute if data storage xiangqi:undo saved.covered[26] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=26},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[26]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[27]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=27},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=27},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=27},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[27] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=27},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[27]
execute if data storage xiangqi:undo saved.covered[27] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=27},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[27]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[28]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=28},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=28},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=28},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[28] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=28},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[28]
execute if data storage xiangqi:undo saved.covered[28] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=28},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[28]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[29]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=29},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=29},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=29},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[29] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=29},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[29]
execute if data storage xiangqi:undo saved.covered[29] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=29},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[29]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[30]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=30},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=30},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=30},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[30] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=30},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[30]
execute if data storage xiangqi:undo saved.covered[30] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=30},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[30]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[31]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=31},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=31},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=31},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[31] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=31},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[31]
execute if data storage xiangqi:undo saved.covered[31] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=31},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[31]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[32]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=32},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=32},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=32},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[32] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=32},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[32]
execute if data storage xiangqi:undo saved.covered[32] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=32},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[32]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[33]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=33},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=33},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=33},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[33] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=33},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[33]
execute if data storage xiangqi:undo saved.covered[33] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=33},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[33]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[34]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=34},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=34},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=34},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[34] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=34},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[34]
execute if data storage xiangqi:undo saved.covered[34] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=34},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[34]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[35]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=35},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=35},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=35},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[35] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=35},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[35]
execute if data storage xiangqi:undo saved.covered[35] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=35},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[35]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[36]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=36},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=36},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=36},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[36] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=36},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[36]
execute if data storage xiangqi:undo saved.covered[36] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=36},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[36]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[37]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=37},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=37},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=37},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[37] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=37},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[37]
execute if data storage xiangqi:undo saved.covered[37] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=37},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[37]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[38]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=38},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=38},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=38},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[38] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=38},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[38]
execute if data storage xiangqi:undo saved.covered[38] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=38},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[38]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[39]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=39},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=39},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=39},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[39] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=39},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[39]
execute if data storage xiangqi:undo saved.covered[39] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=39},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[39]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[40]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=40},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=40},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=40},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[40] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=40},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[40]
execute if data storage xiangqi:undo saved.covered[40] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=40},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[40]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[41]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=41},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=41},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=41},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[41] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=41},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[41]
execute if data storage xiangqi:undo saved.covered[41] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=41},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[41]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[42]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=42},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=42},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=42},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[42] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=42},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[42]
execute if data storage xiangqi:undo saved.covered[42] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=42},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[42]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[43]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=43},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=43},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=43},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[43] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=43},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[43]
execute if data storage xiangqi:undo saved.covered[43] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=43},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[43]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[44]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=44},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=44},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=44},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[44] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=44},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[44]
execute if data storage xiangqi:undo saved.covered[44] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=44},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[44]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[45]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=45},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=45},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=45},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[45] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=45},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[45]
execute if data storage xiangqi:undo saved.covered[45] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=45},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[45]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[46]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=46},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=46},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=46},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[46] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=46},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[46]
execute if data storage xiangqi:undo saved.covered[46] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=46},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[46]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[47]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=47},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=47},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=47},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[47] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=47},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[47]
execute if data storage xiangqi:undo saved.covered[47] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=47},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[47]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[48]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=48},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=48},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=48},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[48] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=48},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[48]
execute if data storage xiangqi:undo saved.covered[48] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=48},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[48]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[49]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=49},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=49},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=49},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[49] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=49},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[49]
execute if data storage xiangqi:undo saved.covered[49] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=49},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[49]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[50]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=50},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=50},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=50},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[50] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=50},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[50]
execute if data storage xiangqi:undo saved.covered[50] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=50},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[50]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[51]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=51},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=51},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=51},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[51] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=51},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[51]
execute if data storage xiangqi:undo saved.covered[51] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=51},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[51]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[52]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=52},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=52},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=52},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[52] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=52},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[52]
execute if data storage xiangqi:undo saved.covered[52] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=52},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[52]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[53]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=53},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=53},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=53},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[53] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=53},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[53]
execute if data storage xiangqi:undo saved.covered[53] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=53},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[53]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[54]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=54},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=54},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=54},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[54] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=54},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[54]
execute if data storage xiangqi:undo saved.covered[54] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=54},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[54]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[55]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=55},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=55},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=55},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[55] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=55},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[55]
execute if data storage xiangqi:undo saved.covered[55] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=55},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[55]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[56]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=56},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=56},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=56},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[56] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=56},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[56]
execute if data storage xiangqi:undo saved.covered[56] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=56},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[56]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[57]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=57},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=57},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=57},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[57] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=57},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[57]
execute if data storage xiangqi:undo saved.covered[57] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=57},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[57]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[58]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=58},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=58},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=58},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[58] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=58},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[58]
execute if data storage xiangqi:undo saved.covered[58] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=58},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[58]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[59]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=59},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=59},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=59},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[59] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=59},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[59]
execute if data storage xiangqi:undo saved.covered[59] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=59},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[59]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[60]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=60},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=60},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=60},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[60] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=60},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[60]
execute if data storage xiangqi:undo saved.covered[60] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=60},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[60]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[61]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=61},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=61},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=61},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[61] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=61},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[61]
execute if data storage xiangqi:undo saved.covered[61] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=61},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[61]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[62]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=62},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=62},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=62},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[62] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=62},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[62]
execute if data storage xiangqi:undo saved.covered[62] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=62},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[62]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[63]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=63},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=63},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=63},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[63] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=63},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[63]
execute if data storage xiangqi:undo saved.covered[63] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=63},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[63]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[64]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=64},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=64},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=64},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[64] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=64},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[64]
execute if data storage xiangqi:undo saved.covered[64] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=64},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[64]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[65]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=65},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=65},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=65},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[65] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=65},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[65]
execute if data storage xiangqi:undo saved.covered[65] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=65},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[65]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[66]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=66},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=66},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=66},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[66] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=66},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[66]
execute if data storage xiangqi:undo saved.covered[66] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=66},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[66]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[67]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=67},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=67},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=67},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[67] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=67},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[67]
execute if data storage xiangqi:undo saved.covered[67] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=67},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[67]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[68]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=68},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=68},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=68},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[68] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=68},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[68]
execute if data storage xiangqi:undo saved.covered[68] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=68},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[68]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[69]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=69},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=69},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=69},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[69] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=69},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[69]
execute if data storage xiangqi:undo saved.covered[69] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=69},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[69]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[70]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=70},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=70},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=70},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[70] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=70},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[70]
execute if data storage xiangqi:undo saved.covered[70] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=70},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[70]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[71]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=71},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=71},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=71},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[71] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=71},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[71]
execute if data storage xiangqi:undo saved.covered[71] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=71},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[71]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[72]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=72},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=72},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=72},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[72] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=72},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[72]
execute if data storage xiangqi:undo saved.covered[72] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=72},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[72]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[73]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=73},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=73},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=73},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[73] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=73},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[73]
execute if data storage xiangqi:undo saved.covered[73] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=73},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[73]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[74]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=74},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=74},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=74},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[74] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=74},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[74]
execute if data storage xiangqi:undo saved.covered[74] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=74},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[74]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[75]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=75},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=75},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=75},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[75] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=75},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[75]
execute if data storage xiangqi:undo saved.covered[75] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=75},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[75]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[76]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=76},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=76},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=76},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[76] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=76},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[76]
execute if data storage xiangqi:undo saved.covered[76] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=76},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[76]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[77]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=77},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=77},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=77},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[77] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=77},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[77]
execute if data storage xiangqi:undo saved.covered[77] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=77},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[77]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[78]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=78},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=78},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=78},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[78] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=78},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[78]
execute if data storage xiangqi:undo saved.covered[78] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=78},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[78]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[79]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=79},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=79},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=79},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[79] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=79},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[79]
execute if data storage xiangqi:undo saved.covered[79] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=79},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[79]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[80]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=80},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=80},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=80},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[80] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=80},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[80]
execute if data storage xiangqi:undo saved.covered[80] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=80},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[80]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[81]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=81},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=81},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=81},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[81] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=81},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[81]
execute if data storage xiangqi:undo saved.covered[81] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=81},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[81]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[82]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=82},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=82},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=82},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[82] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=82},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[82]
execute if data storage xiangqi:undo saved.covered[82] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=82},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[82]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[83]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=83},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=83},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=83},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[83] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=83},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[83]
execute if data storage xiangqi:undo saved.covered[83] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=83},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[83]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[84]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=84},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=84},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=84},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[84] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=84},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[84]
execute if data storage xiangqi:undo saved.covered[84] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=84},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[84]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[85]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=85},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=85},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=85},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[85] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=85},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[85]
execute if data storage xiangqi:undo saved.covered[85] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=85},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[85]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[86]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=86},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=86},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=86},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[86] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=86},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[86]
execute if data storage xiangqi:undo saved.covered[86] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=86},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[86]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[87]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=87},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=87},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=87},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[87] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=87},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[87]
execute if data storage xiangqi:undo saved.covered[87] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=87},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[87]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[88]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=88},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=88},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=88},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[88] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=88},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[88]
execute if data storage xiangqi:undo saved.covered[88] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=88},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[88]
execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[89]
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=89},limit=1] xq_piece = #restore xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=89},limit=1] xq_hidden = #restore xq_ctx
scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=89},limit=1] xq_covered 0
execute if data storage xiangqi:undo saved.hidden[89] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=89},limit=1] xq_hidden run data get storage xiangqi:undo saved.hidden[89]
execute if data storage xiangqi:undo saved.covered[89] store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=89},limit=1] xq_covered run data get storage xiangqi:undo saved.covered[89]
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
