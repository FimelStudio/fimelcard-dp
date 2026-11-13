function weiqi:system/context
function weiqi:visual/context
execute as @e[tag=go.man] if score @s ct_id = #vis_table go_ctx run function weiqi:visual/undo_probe
function weiqi:visual/select
