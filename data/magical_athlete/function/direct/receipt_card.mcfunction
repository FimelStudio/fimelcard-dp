$data modify storage magical_athlete:direct receipt set from storage magical_athlete:characters chars[$(id)]
execute store result storage magical_athlete:direct receipt.order int 1 run scoreboard players get @s ma_dround
function magical_athlete:direct/receipt_message with storage magical_athlete:direct receipt
