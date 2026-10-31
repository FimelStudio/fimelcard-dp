function gomoku:system/context
function gomoku:visual/context
execute as @e[tag=gm.man] if score @s ct_id = #vis_table gm_ctx run function gomoku:visual/undo_probe
function gomoku:visual/select
