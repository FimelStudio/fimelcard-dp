execute store result storage weiqi:visual sq int 1 run scoreboard players get #v_start go_ctx
execute store result storage weiqi:visual length int 1 run scoreboard players get #v_length go_ctx
data modify storage weiqi:visual owner set value "black"
execute if score #v_owner go_ctx matches -1 run data modify storage weiqi:visual owner set value "white"
function weiqi:visual/coord with storage weiqi:visual
function weiqi:visual/strip_geometry with storage weiqi:visual
