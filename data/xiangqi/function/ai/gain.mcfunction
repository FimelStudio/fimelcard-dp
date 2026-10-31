scoreboard players operation #ai_kind xq_ctx = #target xq_ctx
execute if score #ai_kind xq_ctx matches ..-1 run scoreboard players operation #ai_kind xq_ctx *= #minus xq_ctx
function xiangqi:ai/value
scoreboard players set #ai_ten xq_ctx 10
scoreboard players operation #ai_score xq_ctx = #ai_value xq_ctx
scoreboard players operation #ai_score xq_ctx *= #ai_ten xq_ctx
