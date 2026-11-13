scoreboard players operation #ai_kind xq_ctx = #placed xq_ctx
execute if score #ai_kind xq_ctx matches ..-1 run scoreboard players operation #ai_kind xq_ctx *= #minus xq_ctx
function xiangqi:ai/value
scoreboard players set #ai_six xq_ctx 6
scoreboard players operation #ai_value xq_ctx *= #ai_six xq_ctx
scoreboard players operation #ai_score xq_ctx -= #ai_value xq_ctx
