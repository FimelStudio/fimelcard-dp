execute unless score #b154 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b114 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b114 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b115 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b115 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b116 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b116 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b117 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b117 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b118 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b118 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b133 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b133 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b134 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b134 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b135 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b135 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b136 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b136 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b137 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b137 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b152 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b152 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b153 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b153 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b155 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b155 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b156 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b156 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b171 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b171 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b172 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b172 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b173 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b173 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b174 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b174 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b175 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b175 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b190 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b190 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b191 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b191 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b192 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b192 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b193 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b193 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b194 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b194 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 154
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/154
function gomoku:ai/score/154
function gomoku:ai/consider
