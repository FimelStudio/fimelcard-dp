function weiqi:visual/context
execute as @e[tag=go.highlight] if score @s ct_id = #vis_table go_ctx run kill @s
execute if score @s go_sel matches 0..360 run function weiqi:visual/selection
execute if score @s go_mark matches 1 if data entity @s data.weiqi.last.sq if data entity @s data.weiqi.last{pass:0b} run function weiqi:visual/last
