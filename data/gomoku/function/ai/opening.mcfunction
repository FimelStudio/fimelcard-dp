scoreboard players set #two gm_ctx 2
scoreboard players set #nineteen gm_ctx 19
scoreboard players operation #center gm_ctx = @s gm_size
scoreboard players operation #center gm_ctx /= #two gm_ctx
scoreboard players operation #to gm_ctx = #center gm_ctx
scoreboard players operation #to gm_ctx *= #nineteen gm_ctx
scoreboard players operation #to gm_ctx += #center gm_ctx
execute store result entity @s data.gomoku.ai.chosen int 1 run scoreboard players get #to gm_ctx
data modify entity @s data.gomoku.ai.stage set value 3
data modify entity @s data.gomoku.ai.index set value 361
