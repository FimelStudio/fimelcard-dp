scoreboard players set #hint_scale dd_ctx 100
scoreboard players operation #hint_key dd_ctx = #hint_kind dd_ctx
scoreboard players operation #hint_key dd_ctx *= #hint_scale dd_ctx
scoreboard players operation #hint_key dd_ctx += #hint_size dd_ctx
scoreboard players operation #hint_key dd_ctx *= #hint_scale dd_ctx
scoreboard players operation #hint_key dd_ctx += #hint_rank dd_ctx
