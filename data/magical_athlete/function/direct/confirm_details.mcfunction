scoreboard players operation #detail ma_ctx = @s ma_confirm
execute if score #detail ma_ctx matches 100..135 run scoreboard players remove #detail ma_ctx 100
execute if score #detail ma_ctx matches 200..235 run scoreboard players remove #detail ma_ctx 200
execute unless score #detail ma_ctx matches 0..35 run return 0
execute store result storage magical_athlete:direct id int 1 run scoreboard players get #detail ma_ctx
function magical_athlete:direct/card_details with storage magical_athlete:direct
