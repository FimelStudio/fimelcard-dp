function weiqi:visual/territory_flush
scoreboard players set #v_col go_ctx 0
scoreboard players add #v_row go_ctx 1
scoreboard players operation #v_sq go_ctx = #v_row go_ctx
scoreboard players set #v_stride go_ctx 19
scoreboard players operation #v_sq go_ctx *= #v_stride go_ctx
