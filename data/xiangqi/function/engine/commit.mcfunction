# 只有真实提交可以读取暗子身份；合法判定、提示和人机模拟只处理公开模板。
function xiangqi:engine/covered/reveal with storage xiangqi:engine scratch
data modify entity @s data.xiangqi.last set value {from:0,to:0,piece:0,captured:0,capture_sq:-1,rook_from:-1,rook_to:-1,promotion:0,was_covered:0,captured_covered:0,moved_template:0}
scoreboard players operation #captured xq_ctx = #target xq_ctx
execute store result entity @s data.xiangqi.last.from int 1 run scoreboard players get #from xq_ctx
execute store result entity @s data.xiangqi.last.to int 1 run scoreboard players get #to xq_ctx
execute store result entity @s data.xiangqi.last.piece int 1 run scoreboard players get #placed xq_ctx
execute store result entity @s data.xiangqi.last.captured int 1 run scoreboard players get #captured xq_ctx
execute store result entity @s data.xiangqi.last.capture_sq int 1 run scoreboard players get #capture_sq xq_ctx
execute store result entity @s data.xiangqi.last.was_covered int 1 run scoreboard players get #covered xq_ctx
execute store result entity @s data.xiangqi.last.captured_covered int 1 run scoreboard players get #target_covered xq_ctx
execute store result entity @s data.xiangqi.last.moved_template int 1 run scoreboard players get #piece xq_ctx
function xiangqi:engine/apply_cache with storage xiangqi:engine scratch
function xiangqi:engine/covered/apply_real with storage xiangqi:engine scratch
scoreboard players add @s xq_half 1
execute unless score #captured xq_ctx matches 0 run scoreboard players set @s xq_half 0
execute if score #side xq_ctx matches -1 run scoreboard players add @s xq_full 1
scoreboard players operation @s xq_turn *= #minus xq_ctx
scoreboard players operation #side xq_ctx = @s xq_turn
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=0},limit=1] xq_piece = #b0 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=1},limit=1] xq_piece = #b1 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=2},limit=1] xq_piece = #b2 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=3},limit=1] xq_piece = #b3 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=4},limit=1] xq_piece = #b4 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=5},limit=1] xq_piece = #b5 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=6},limit=1] xq_piece = #b6 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=7},limit=1] xq_piece = #b7 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=8},limit=1] xq_piece = #b8 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=9},limit=1] xq_piece = #b9 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=10},limit=1] xq_piece = #b10 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=11},limit=1] xq_piece = #b11 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=12},limit=1] xq_piece = #b12 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=13},limit=1] xq_piece = #b13 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=14},limit=1] xq_piece = #b14 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=15},limit=1] xq_piece = #b15 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=16},limit=1] xq_piece = #b16 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=17},limit=1] xq_piece = #b17 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=18},limit=1] xq_piece = #b18 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=19},limit=1] xq_piece = #b19 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=20},limit=1] xq_piece = #b20 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=21},limit=1] xq_piece = #b21 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=22},limit=1] xq_piece = #b22 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=23},limit=1] xq_piece = #b23 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=24},limit=1] xq_piece = #b24 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=25},limit=1] xq_piece = #b25 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=26},limit=1] xq_piece = #b26 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=27},limit=1] xq_piece = #b27 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=28},limit=1] xq_piece = #b28 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=29},limit=1] xq_piece = #b29 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=30},limit=1] xq_piece = #b30 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=31},limit=1] xq_piece = #b31 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=32},limit=1] xq_piece = #b32 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=33},limit=1] xq_piece = #b33 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=34},limit=1] xq_piece = #b34 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=35},limit=1] xq_piece = #b35 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=36},limit=1] xq_piece = #b36 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=37},limit=1] xq_piece = #b37 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=38},limit=1] xq_piece = #b38 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=39},limit=1] xq_piece = #b39 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=40},limit=1] xq_piece = #b40 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=41},limit=1] xq_piece = #b41 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=42},limit=1] xq_piece = #b42 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=43},limit=1] xq_piece = #b43 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=44},limit=1] xq_piece = #b44 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=45},limit=1] xq_piece = #b45 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=46},limit=1] xq_piece = #b46 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=47},limit=1] xq_piece = #b47 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=48},limit=1] xq_piece = #b48 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=49},limit=1] xq_piece = #b49 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=50},limit=1] xq_piece = #b50 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=51},limit=1] xq_piece = #b51 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=52},limit=1] xq_piece = #b52 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=53},limit=1] xq_piece = #b53 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=54},limit=1] xq_piece = #b54 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=55},limit=1] xq_piece = #b55 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=56},limit=1] xq_piece = #b56 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=57},limit=1] xq_piece = #b57 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=58},limit=1] xq_piece = #b58 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=59},limit=1] xq_piece = #b59 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=60},limit=1] xq_piece = #b60 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=61},limit=1] xq_piece = #b61 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=62},limit=1] xq_piece = #b62 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=63},limit=1] xq_piece = #b63 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=64},limit=1] xq_piece = #b64 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=65},limit=1] xq_piece = #b65 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=66},limit=1] xq_piece = #b66 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=67},limit=1] xq_piece = #b67 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=68},limit=1] xq_piece = #b68 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=69},limit=1] xq_piece = #b69 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=70},limit=1] xq_piece = #b70 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=71},limit=1] xq_piece = #b71 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=72},limit=1] xq_piece = #b72 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=73},limit=1] xq_piece = #b73 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=74},limit=1] xq_piece = #b74 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=75},limit=1] xq_piece = #b75 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=76},limit=1] xq_piece = #b76 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=77},limit=1] xq_piece = #b77 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=78},limit=1] xq_piece = #b78 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=79},limit=1] xq_piece = #b79 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=80},limit=1] xq_piece = #b80 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=81},limit=1] xq_piece = #b81 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=82},limit=1] xq_piece = #b82 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=83},limit=1] xq_piece = #b83 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=84},limit=1] xq_piece = #b84 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=85},limit=1] xq_piece = #b85 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=86},limit=1] xq_piece = #b86 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=87},limit=1] xq_piece = #b87 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=88},limit=1] xq_piece = #b88 xq_ctx
scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=89},limit=1] xq_piece = #b89 xq_ctx
function xiangqi:engine/cache
function xiangqi:engine/history/record
scoreboard players set #legal xq_ctx 1
function xiangqi:game/after_move
