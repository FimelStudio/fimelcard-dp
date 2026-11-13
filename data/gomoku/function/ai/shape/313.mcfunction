scoreboard players set #shape gm_ctx 0
scoreboard players set #fork gm_ctx 0
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b312 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b312 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b312 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b311 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b311 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b311 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b310 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b310 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b310 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b309 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b309 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b309 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b314 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b314 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b314 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b315 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b315 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b315 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b316 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b316 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b316 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b317 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b317 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b317 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b294 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b294 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b294 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b275 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b275 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b275 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b256 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b256 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b256 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b237 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b237 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b237 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b332 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b332 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b332 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b351 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b351 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b351 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b293 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b293 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b293 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b273 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b273 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b273 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b253 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b253 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b253 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b233 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b233 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b233 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b333 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b333 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b333 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b353 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b353 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b353 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b331 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b331 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b331 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b349 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b349 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b349 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b295 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b295 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b295 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b277 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b277 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b277 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b259 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b259 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b259 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b241 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b241 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b241 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
