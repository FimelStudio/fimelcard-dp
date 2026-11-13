function weiqi:visual/context
data modify storage weiqi:visual duration set value 0
execute as @e[tag=go.falling] if score @s ct_id = #vis_table go_ctx run function weiqi:visual/fall
execute as @e[tag=go.falling] if score @s ct_id = #vis_table go_ctx run tag @s remove go.falling
execute as @e[tag=go.retracting] if score @s ct_id = #vis_table go_ctx run kill @s
function weiqi:visual/select
