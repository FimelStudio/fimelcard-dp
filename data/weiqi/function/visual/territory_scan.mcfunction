execute store result storage weiqi:visual sq int 1 run scoreboard players get #v_sq go_ctx
function weiqi:visual/territory_read with storage weiqi:visual
execute unless score #v_cell_owner go_ctx = #v_owner go_ctx run function weiqi:visual/territory_flush
execute if score #v_length go_ctx matches 0 run scoreboard players operation #v_start go_ctx = #v_sq go_ctx
scoreboard players operation #v_owner go_ctx = #v_cell_owner go_ctx
scoreboard players add #v_length go_ctx 1
scoreboard players add #v_col go_ctx 1
scoreboard players add #v_sq go_ctx 1
execute if score #v_col go_ctx >= #v_size go_ctx run function weiqi:visual/territory_row_end
execute if score #v_row go_ctx < #v_size go_ctx run function weiqi:visual/territory_scan
