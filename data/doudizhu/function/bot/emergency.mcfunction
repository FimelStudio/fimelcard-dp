scoreboard players operation #bot_gain dd_ctx = #high dd_ctx
scoreboard players set #bot_weight dd_ctx 10
scoreboard players operation #bot_gain dd_ctx *= #bot_weight dd_ctx
scoreboard players operation #bot_cost dd_ctx -= #bot_gain dd_ctx
