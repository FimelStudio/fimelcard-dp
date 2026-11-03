scoreboard players operation #v_frame ma_ctx = @s ma_vframe
execute if score @s ma_speed matches 1 run scoreboard players operation #v_frame ma_ctx += @s ma_vframe
execute if score #v_frame ma_ctx matches 13.. run scoreboard players set #v_frame ma_ctx 12
execute store result storage magical_athlete:visual frame int 1 run scoreboard players get #v_frame ma_ctx
$data modify storage magical_athlete:visual die set value $(die)
function magical_athlete:visual/die_get with storage magical_athlete:visual
