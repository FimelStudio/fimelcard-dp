execute if score #stage gm_ctx matches 3 run return run function gomoku:ai/submit
execute if score #stage gm_ctx matches 1 run return run function gomoku:ai/first_done
execute if score #stage gm_ctx matches 2 run function gomoku:ai/reply_done
