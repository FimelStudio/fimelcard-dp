scoreboard players set #shape gm_ctx 0
scoreboard players set #fork gm_ctx 0
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b268 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b268 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b268 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b267 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b267 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b267 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b266 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b266 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b266 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b270 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b270 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b270 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b271 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b271 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b271 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b272 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b272 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b272 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b273 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b273 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b273 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b250 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b250 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b250 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b231 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b231 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b231 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b212 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b212 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b212 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b193 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b193 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b193 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b288 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b288 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b288 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b307 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b307 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b307 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b326 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b326 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b326 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b345 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b345 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b345 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b249 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b249 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b249 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b229 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b229 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b229 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b209 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b209 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b209 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b289 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b289 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b289 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b309 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b309 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b309 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b329 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b329 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b329 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b349 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b349 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b349 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b287 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b287 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b287 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b305 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b305 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b305 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b323 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b323 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b323 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b251 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b251 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b251 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b233 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b233 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b233 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b215 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b215 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b215 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b197 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b197 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b197 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
