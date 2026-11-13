scoreboard players operation @s ma_seen = @e[tag=ma.current,limit=1] ma_epoch
scoreboard players set @s ma_confirm -999
scoreboard players operation @s ma_dcode = #code ma_ctx
execute if score @s ma_dcode matches 200..235 run function magical_athlete:direct/lineup_order
function magical_athlete:ui/dispatch
execute if score #ok ma_ctx matches 1 if score @s ma_dcode matches 200..235 run function magical_athlete:direct/lineup_receipt
scoreboard players set @s ma_depoch -1
function magical_athlete:direct/sync
