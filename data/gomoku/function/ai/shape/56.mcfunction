scoreboard players set #shape gm_ctx 0
scoreboard players set #fork gm_ctx 0
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b55 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b55 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b55 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b54 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b54 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b54 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b53 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b53 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b53 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b52 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b52 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b52 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
function gomoku:ai/shape_score
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b37 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b37 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b37 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b18 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b18 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b18 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b75 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b75 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b75 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b94 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b94 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b94 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b113 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b113 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b113 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b132 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b132 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b132 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
function gomoku:ai/shape_score
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b36 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b36 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b36 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b16 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b16 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b16 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
function gomoku:ai/shape_score
scoreboard players set #length gm_ctx 1
scoreboard players set #open gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b74 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b74 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b74 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b92 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b92 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b92 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b110 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b110 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b110 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b128 gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b128 gm_ctx matches 0 run scoreboard players add #open gm_ctx 1
execute unless score #b128 gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players set #run gm_ctx 1
function gomoku:ai/shape_score
