scoreboard players set #legal ch_ctx 0
execute unless score #cache_ok ch_ctx matches 1 run return 0
scoreboard players set #shape ch_ctx 0
scoreboard players set #promotion ch_ctx 0
scoreboard players set #capture_sq ch_ctx -1
scoreboard players set #rook_from ch_ctx -1
scoreboard players set #rook_to ch_ctx -1
execute if score #from ch_ctx = #to ch_ctx run return 0
execute store result storage chess:engine scratch.from int 1 run scoreboard players get #from ch_ctx
execute store result storage chess:engine scratch.to int 1 run scoreboard players get #to ch_ctx
function chess:engine/get_pieces with storage chess:engine scratch
execute if score #side ch_ctx matches 1 unless score #piece ch_ctx matches 1..6 run return 0
execute if score #side ch_ctx matches -1 unless score #piece ch_ctx matches -6..-1 run return 0
execute if score #side ch_ctx matches 1 if score #target ch_ctx matches 1..6 run return 0
execute if score #side ch_ctx matches -1 if score #target ch_ctx matches -6..-1 run return 0
execute if score #target ch_ctx matches 6 run return 0
execute if score #target ch_ctx matches -6 run return 0
scoreboard players operation #kind ch_ctx = #piece ch_ctx
execute if score #kind ch_ctx matches ..-1 run scoreboard players operation #kind ch_ctx *= #minus ch_ctx
execute store result storage chess:engine scratch.kind int 1 run scoreboard players get #kind ch_ctx
function chess:engine/dispatch_shape with storage chess:engine scratch
execute unless score #shape ch_ctx matches 1 run return 0
execute if score #kind ch_ctx matches 1 if score #to ch_ctx matches 0..7 run scoreboard players set #promotion ch_ctx 1
execute if score #kind ch_ctx matches 1 if score #to ch_ctx matches 56..63 run scoreboard players set #promotion ch_ctx 1
# 升变类型不会改变己王安全；待选时用后模拟，真实棋子保持不动。
scoreboard players operation #placed ch_ctx = #piece ch_ctx
execute if score #promotion ch_ctx matches 1 run scoreboard players set #placed ch_ctx 5
execute if score #promotion ch_ctx matches 1 if score #promo ch_ctx matches 2..5 run scoreboard players operation #placed ch_ctx = #promo ch_ctx
execute if score #promotion ch_ctx matches 1 run scoreboard players operation #placed ch_ctx *= #side ch_ctx
execute if score #target ch_ctx matches ..-1 run scoreboard players operation #capture_sq ch_ctx = #to ch_ctx
execute if score #target ch_ctx matches 1.. run scoreboard players operation #capture_sq ch_ctx = #to ch_ctx
function chess:engine/simulate
execute if score #attacked ch_ctx matches 0 run scoreboard players set #legal ch_ctx 1
return run scoreboard players get #legal ch_ctx
