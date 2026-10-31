execute unless score #b257 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b217 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b217 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b218 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b218 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b219 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b219 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b220 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b220 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b221 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b221 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b236 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b236 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b237 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b237 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b238 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b238 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b239 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b239 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b240 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b240 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b255 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b255 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b256 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b256 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b258 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b258 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b259 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b259 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b274 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b274 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b275 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b275 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b276 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b276 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b277 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b277 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b278 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b278 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b293 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b293 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b294 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b294 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b295 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b295 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b296 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b296 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b297 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b297 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 257
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/257
function gomoku:ai/score/257
function gomoku:ai/consider
