function gomoku:visual/context
data modify storage gomoku:visual duration set value 5
execute as @e[tag=gm.falling] if score @s ct_id = #vis_table gm_ctx if data entity @s data.gomoku_visual{started:0b} run function gomoku:visual/fall
