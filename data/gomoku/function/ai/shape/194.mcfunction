scoreboard players set #shape gm_ctx 0
scoreboard players set #fork gm_ctx 0
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b193 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b193 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b193 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b192 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b192 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b192 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b191 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b191 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b191 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b190 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b190 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b190 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b195 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b195 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b195 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b196 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b196 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b196 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b197 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b197 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b197 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b198 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b198 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b198 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b175 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b175 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b175 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b156 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b156 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b156 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b137 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b137 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b137 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b118 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b118 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b118 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b213 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b213 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b213 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b232 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b232 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b232 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b251 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b251 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b251 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b270 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b270 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b270 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b174 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b174 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b174 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b154 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b154 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b154 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b134 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b134 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b134 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b114 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b114 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b114 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b214 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b214 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b214 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b234 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b234 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b234 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b254 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b254 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b254 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b274 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b274 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b274 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b212 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b212 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b212 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b230 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b230 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b230 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b248 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b248 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b248 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b266 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b266 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b266 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b176 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b176 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b176 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b158 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b158 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b158 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b140 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b140 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b140 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b122 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b122 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b122 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
