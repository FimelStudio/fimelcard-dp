scoreboard players operation #ai_kind ch_ctx = #placed ch_ctx
execute if score #ai_kind ch_ctx matches ..-1 run scoreboard players operation #ai_kind ch_ctx *= #minus ch_ctx
function chess:ai/value
scoreboard players set #ai_six ch_ctx 6
scoreboard players operation #ai_value ch_ctx *= #ai_six ch_ctx
scoreboard players operation #ai_score ch_ctx -= #ai_value ch_ctx
