scoreboard players set #legal xq_ctx 0
execute unless score #cache_ok xq_ctx matches 1 run return 0
execute unless score #side xq_ctx matches -1 unless score #side xq_ctx matches 1 run return 0
execute unless score #from xq_ctx matches 0..89 run return 0
execute unless score #to xq_ctx matches 0..89 run return 0
execute if score #from xq_ctx = #to xq_ctx run return 0
scoreboard players set #shape xq_ctx 0
scoreboard players set #promotion xq_ctx 0
scoreboard players set #capture_sq xq_ctx -1
scoreboard players set #rook_from xq_ctx -1
scoreboard players set #rook_to xq_ctx -1
execute store result storage xiangqi:engine scratch.from int 1 run scoreboard players get #from xq_ctx
execute store result storage xiangqi:engine scratch.to int 1 run scoreboard players get #to xq_ctx
function xiangqi:engine/get_pieces with storage xiangqi:engine scratch
execute if score #side xq_ctx matches 1 unless score #piece xq_ctx matches 1..7 run return 0
execute if score #side xq_ctx matches -1 unless score #piece xq_ctx matches -7..-1 run return 0
execute if score #side xq_ctx matches 1 if score #target xq_ctx matches 1..7 run return 0
execute if score #side xq_ctx matches -1 if score #target xq_ctx matches -7..-1 run return 0
execute if score #target xq_ctx matches 6 run return 0
execute if score #target xq_ctx matches -6 run return 0
scoreboard players operation #kind xq_ctx = #piece xq_ctx
execute if score #kind xq_ctx matches ..-1 run scoreboard players operation #kind xq_ctx *= #minus xq_ctx
execute store result storage xiangqi:engine scratch.kind int 1 run scoreboard players get #kind xq_ctx
execute store result storage xiangqi:engine scratch.side int 1 run scoreboard players get #side xq_ctx
function xiangqi:engine/dispatch_shape with storage xiangqi:engine scratch
execute unless score #shape xq_ctx matches 1 run return 0
scoreboard players operation #placed xq_ctx = #piece xq_ctx
execute unless score #target xq_ctx matches 0 run scoreboard players operation #capture_sq xq_ctx = #to xq_ctx
function xiangqi:engine/simulate
execute if score #attacked xq_ctx matches 0 run scoreboard players set #legal xq_ctx 1
return run scoreboard players get #legal xq_ctx
