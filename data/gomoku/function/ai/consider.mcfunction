execute unless score #stage gm_ctx matches 1 run return 0
execute if score #score gm_ctx > #top0 gm_ctx run return run function gomoku:ai/top/0
execute if score #score gm_ctx > #top1 gm_ctx run return run function gomoku:ai/top/1
execute if score #score gm_ctx > #top2 gm_ctx run return run function gomoku:ai/top/2
