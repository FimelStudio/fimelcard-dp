$scoreboard players set #option_index ma_ctx $(slot)
scoreboard players operation #option_index ma_ctx += @s ma_dpage
execute store result storage magical_athlete:direct index int 1 run scoreboard players get #option_index ma_ctx
$data modify storage magical_athlete:direct slot set value $(slot)
function magical_athlete:direct/page_read with storage magical_athlete:direct
