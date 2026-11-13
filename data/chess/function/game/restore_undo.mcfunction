function chess:ai/reset
execute store result score @s ch_turn run data get entity @s data.chess.undo.turn
execute store result score @s ch_castle run data get entity @s data.chess.undo.castle
execute store result score @s ch_ep run data get entity @s data.chess.undo.ep
execute store result score @s ch_half run data get entity @s data.chess.undo.half
execute store result score @s ch_full run data get entity @s data.chess.undo.full
execute store result score @s ch_wtime run data get entity @s data.chess.undo.wtime
execute store result score @s ch_btime run data get entity @s data.chess.undo.btime
execute store result score @s ch_wcapt run data get entity @s data.chess.undo.wcapt
execute store result score @s ch_bcapt run data get entity @s data.chess.undo.bcapt
execute store result score @s ch_check run data get entity @s data.chess.undo.check
execute store result score @s ch_repetition run data get entity @s data.chess.undo.repetition
data modify entity @s data.chess.history set from entity @s data.chess.undo.history
data modify entity @s data.chess.captured set from entity @s data.chess.undo.captured
data modify storage chess:undo saved set from entity @s data.chess.undo
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[0]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=0},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[1]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=1},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[2]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=2},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[3]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=3},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[4]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=4},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[5]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=5},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[6]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=6},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[7]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=7},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[8]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=8},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[9]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=9},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[10]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=10},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[11]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=11},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[12]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=12},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[13]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=13},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[14]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=14},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[15]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=15},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[16]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=16},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[17]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=17},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[18]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=18},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[19]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=19},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[20]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=20},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[21]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=21},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[22]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=22},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[23]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=23},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[24]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=24},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[25]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=25},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[26]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=26},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[27]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=27},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[28]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=28},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[29]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=29},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[30]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=30},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[31]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=31},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[32]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=32},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[33]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=33},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[34]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=34},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[35]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=35},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[36]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=36},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[37]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=37},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[38]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=38},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[39]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=39},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[40]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=40},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[41]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=41},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[42]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=42},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[43]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=43},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[44]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=44},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[45]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=45},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[46]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=46},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[47]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=47},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[48]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=48},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[49]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=49},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[50]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=50},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[51]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=51},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[52]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=52},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[53]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=53},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[54]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=54},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[55]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=55},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[56]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=56},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[57]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=57},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[58]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=58},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[59]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=59},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[60]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=60},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[61]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=61},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[62]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=62},limit=1] ch_piece = #restore ch_ctx
execute store result score #restore ch_ctx run data get storage chess:undo saved.board[63]
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=63},limit=1] ch_piece = #restore ch_ctx
data remove entity @s data.chess.undo
data remove entity @s data.chess.pending_undo
data remove entity @s data.chess.ai_undo
data remove entity @s data.chess.last
data remove storage chess:undo saved
scoreboard players set @s ch_undo 0
scoreboard players set @s ch_draw 0
scoreboard players set @s ch_sel -1
scoreboard players set @s ch_result 0
scoreboard players set @s ch_reason 0
scoreboard players add @s ch_epoch 1
function chess:visual/refresh
function chess:clock/update
function chess:ui/refresh
execute if score @s ch_bot matches 0 run tellraw @a[tag=ch.audience] {"text": "[国际象棋] 对手同意悔棋，已撤回最后一步，并恢复该步之前的局面与时钟。", "color": "yellow"}
execute unless score @s ch_bot matches 0 run tellraw @a[tag=ch.audience] {"text": "[国际象棋] 人机同意悔棋，已恢复到你上次走子之前的局面与时钟。", "color": "yellow"}
