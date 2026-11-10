$scoreboard players set #v_from ma_ctx $(from)
$scoreboard players set #v_to ma_ctx $(to)
scoreboard players set #v_unit ma_ctx 1000
scoreboard players operation #v_progress ma_ctx = #v_to ma_ctx
scoreboard players operation #v_progress ma_ctx -= #v_from ma_ctx
scoreboard players operation #v_progress ma_ctx *= #v_unit ma_ctx
scoreboard players operation #v_progress ma_ctx *= @s ma_vframe
scoreboard players set #v_duration ma_ctx 12
execute if score @s ma_speed matches 1 run scoreboard players set #v_duration ma_ctx 6
scoreboard players operation #v_progress ma_ctx /= #v_duration ma_ctx
scoreboard players operation #v_from ma_ctx *= #v_unit ma_ctx
scoreboard players operation #v_progress ma_ctx += #v_from ma_ctx
execute if score #v_progress ma_ctx matches ..-1 run scoreboard players set #v_progress ma_ctx 0
execute if score #v_progress ma_ctx matches 30001.. run scoreboard players set #v_progress ma_ctx 30000
scoreboard players operation #v_cell ma_ctx = #v_progress ma_ctx
scoreboard players operation #v_cell ma_ctx /= #v_unit ma_ctx
scoreboard players operation #v_fraction ma_ctx = #v_progress ma_ctx
scoreboard players operation #v_fraction ma_ctx %= #v_unit ma_ctx
scoreboard players operation #v_next ma_ctx = #v_cell ma_ctx
scoreboard players add #v_next ma_ctx 1
execute if score #v_next ma_ctx matches 31.. run scoreboard players set #v_next ma_ctx 30
execute store result storage magical_athlete:visual position int 1 run scoreboard players get #v_cell ma_ctx
execute store result storage magical_athlete:visual next int 1 run scoreboard players get #v_next ma_ctx
$data modify storage magical_athlete:visual pawn set value $(pawn)
function magical_athlete:visual/move_fraction with storage magical_athlete:visual
