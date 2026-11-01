function weiqi:visual/context
data modify storage weiqi:visual duration set value 5
execute as @e[tag=go.falling] if score @s ct_id = #vis_table go_ctx if data entity @s data.weiqi_visual{started:0b} run function weiqi:visual/fall
