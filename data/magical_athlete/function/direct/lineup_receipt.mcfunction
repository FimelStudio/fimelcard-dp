scoreboard players operation #receipt_id ma_ctx = @s ma_dcode
scoreboard players remove #receipt_id ma_ctx 200
execute store result storage magical_athlete:direct id int 1 run scoreboard players get #receipt_id ma_ctx
function magical_athlete:direct/receipt_card with storage magical_athlete:direct
