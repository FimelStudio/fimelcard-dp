# 最后一步元数据先落在控制器，后续局面历史探测不会破坏动画/聊天输入。
data modify entity @s data.chess.last set value {from:0,to:0,piece:0,captured:0,capture_sq:-1,rook_from:-1,rook_to:-1,promotion:0}
scoreboard players operation #captured ch_ctx = #target ch_ctx
execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run scoreboard players operation #captured ch_ctx = #side ch_ctx
execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run scoreboard players operation #captured ch_ctx *= #minus ch_ctx
execute store result entity @s data.chess.last.from int 1 run scoreboard players get #from ch_ctx
execute store result entity @s data.chess.last.to int 1 run scoreboard players get #to ch_ctx
execute store result entity @s data.chess.last.piece int 1 run scoreboard players get #piece ch_ctx
execute store result entity @s data.chess.last.captured int 1 run scoreboard players get #captured ch_ctx
execute store result entity @s data.chess.last.capture_sq int 1 run scoreboard players get #capture_sq ch_ctx
execute store result entity @s data.chess.last.rook_from int 1 run scoreboard players get #rook_from ch_ctx
execute store result entity @s data.chess.last.rook_to int 1 run scoreboard players get #rook_to ch_ctx
execute if score #promotion ch_ctx matches 1 store result entity @s data.chess.last.promotion int 1 run scoreboard players get #promo ch_ctx
function chess:engine/apply_cache with storage chess:engine scratch
execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run function chess:engine/ep_remove with storage chess:engine scratch
execute if score #rook_from ch_ctx matches 0..63 run function chess:engine/rook_apply with storage chess:engine scratch
# 初始王/车移动、车在初始格被吃都会永久收回易位权。
scoreboard players operation #old_castle ch_ctx = #castle ch_ctx
function chess:engine/update_rights
function chess:engine/history/prune
scoreboard players set @s ch_ep -1
scoreboard players set #ep ch_ctx -1
scoreboard players operation #distance ch_ctx = #to ch_ctx
scoreboard players operation #distance ch_ctx -= #from ch_ctx
execute if score #kind ch_ctx matches 1 if score #distance ch_ctx matches 16 run function chess:engine/set_ep_white
execute if score #kind ch_ctx matches 1 if score #distance ch_ctx matches -16 run function chess:engine/set_ep_black
scoreboard players add @s ch_half 1
execute if score #kind ch_ctx matches 1 run scoreboard players set @s ch_half 0
execute unless score #captured ch_ctx matches 0 run scoreboard players set @s ch_half 0
execute if score #side ch_ctx matches -1 run scoreboard players add @s ch_full 1
scoreboard players operation @s ch_turn *= #minus ch_ctx
scoreboard players operation #side ch_ctx = @s ch_turn
# 只写本桌标记，缓存索引与ct_id隔离由context保证。
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=0},limit=1] ch_piece = #b0 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=1},limit=1] ch_piece = #b1 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=2},limit=1] ch_piece = #b2 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=3},limit=1] ch_piece = #b3 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=4},limit=1] ch_piece = #b4 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=5},limit=1] ch_piece = #b5 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=6},limit=1] ch_piece = #b6 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=7},limit=1] ch_piece = #b7 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=8},limit=1] ch_piece = #b8 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=9},limit=1] ch_piece = #b9 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=10},limit=1] ch_piece = #b10 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=11},limit=1] ch_piece = #b11 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=12},limit=1] ch_piece = #b12 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=13},limit=1] ch_piece = #b13 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=14},limit=1] ch_piece = #b14 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=15},limit=1] ch_piece = #b15 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=16},limit=1] ch_piece = #b16 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=17},limit=1] ch_piece = #b17 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=18},limit=1] ch_piece = #b18 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=19},limit=1] ch_piece = #b19 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=20},limit=1] ch_piece = #b20 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=21},limit=1] ch_piece = #b21 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=22},limit=1] ch_piece = #b22 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=23},limit=1] ch_piece = #b23 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=24},limit=1] ch_piece = #b24 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=25},limit=1] ch_piece = #b25 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=26},limit=1] ch_piece = #b26 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=27},limit=1] ch_piece = #b27 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=28},limit=1] ch_piece = #b28 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=29},limit=1] ch_piece = #b29 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=30},limit=1] ch_piece = #b30 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=31},limit=1] ch_piece = #b31 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=32},limit=1] ch_piece = #b32 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=33},limit=1] ch_piece = #b33 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=34},limit=1] ch_piece = #b34 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=35},limit=1] ch_piece = #b35 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=36},limit=1] ch_piece = #b36 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=37},limit=1] ch_piece = #b37 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=38},limit=1] ch_piece = #b38 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=39},limit=1] ch_piece = #b39 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=40},limit=1] ch_piece = #b40 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=41},limit=1] ch_piece = #b41 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=42},limit=1] ch_piece = #b42 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=43},limit=1] ch_piece = #b43 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=44},limit=1] ch_piece = #b44 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=45},limit=1] ch_piece = #b45 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=46},limit=1] ch_piece = #b46 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=47},limit=1] ch_piece = #b47 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=48},limit=1] ch_piece = #b48 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=49},limit=1] ch_piece = #b49 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=50},limit=1] ch_piece = #b50 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=51},limit=1] ch_piece = #b51 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=52},limit=1] ch_piece = #b52 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=53},limit=1] ch_piece = #b53 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=54},limit=1] ch_piece = #b54 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=55},limit=1] ch_piece = #b55 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=56},limit=1] ch_piece = #b56 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=57},limit=1] ch_piece = #b57 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=58},limit=1] ch_piece = #b58 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=59},limit=1] ch_piece = #b59 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=60},limit=1] ch_piece = #b60 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=61},limit=1] ch_piece = #b61 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=62},limit=1] ch_piece = #b62 ch_ctx
scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={ch_sq=63},limit=1] ch_piece = #b63 ch_ctx
function chess:engine/cache
function chess:engine/history/record
scoreboard players set #legal ch_ctx 1
function chess:game/after_move
