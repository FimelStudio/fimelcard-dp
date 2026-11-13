scoreboard players set #shape gm_ctx 0
scoreboard players set #fork gm_ctx 0
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b98 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b98 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b98 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b97 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b97 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b97 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b96 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b96 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b96 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b95 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b95 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b95 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b100 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b100 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b100 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b101 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b101 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b101 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b102 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b102 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b102 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b103 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b103 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b103 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b80 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b80 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b80 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b61 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b61 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b61 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b42 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b42 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b42 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b23 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b23 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b23 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b118 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b118 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b118 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b137 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b137 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b137 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b156 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b156 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b156 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b175 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b175 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b175 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b79 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b79 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b79 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b59 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b59 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b59 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b39 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b39 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b39 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b19 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b19 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b19 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b119 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b119 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b119 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b139 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b139 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b139 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b159 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b159 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b159 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b179 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b179 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b179 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b117 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b117 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b117 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b135 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b135 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b135 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b153 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b153 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b153 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b171 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b171 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b171 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b81 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b81 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b81 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b63 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b63 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b63 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b45 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b45 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b45 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b27 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b27 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b27 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
