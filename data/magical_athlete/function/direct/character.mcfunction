$data modify storage magical_athlete:direct card set from storage magical_athlete:characters chars[$(target)]
$data modify storage magical_athlete:direct card.slot set value $(slot)
$scoreboard players set #card_code ma_ctx $(target)
execute if data storage magical_athlete:direct {kind:"draft"} run scoreboard players add #card_code ma_ctx 100
execute if data storage magical_athlete:direct {kind:"lineup"} run scoreboard players add #card_code ma_ctx 200
execute store result storage magical_athlete:direct card.code int 1 run scoreboard players get #card_code ma_ctx
data modify storage magical_athlete:direct card.table set from storage magical_athlete:direct table
data modify storage magical_athlete:direct card.epoch set from storage magical_athlete:direct epoch
function magical_athlete:direct/character_item with storage magical_athlete:direct card
