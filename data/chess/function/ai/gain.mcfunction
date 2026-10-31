scoreboard players operation #ai_kind ch_ctx = #target ch_ctx
execute if score #ai_kind ch_ctx matches ..-1 run scoreboard players operation #ai_kind ch_ctx *= #minus ch_ctx
execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run scoreboard players set #ai_kind ch_ctx 1
function chess:ai/value
scoreboard players set #ai_ten ch_ctx 10
scoreboard players operation #ai_score ch_ctx = #ai_value ch_ctx
scoreboard players operation #ai_score ch_ctx *= #ai_ten ch_ctx
execute if score #promotion ch_ctx matches 1 run scoreboard players add #ai_score ch_ctx 8000
