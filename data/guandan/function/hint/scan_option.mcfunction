execute unless score #hint_index gd_ctx < #options gd_ctx run return 0
execute store result storage guandan:hint index int 1 run scoreboard players get #hint_index gd_ctx
function guandan:hint/read_option with storage guandan:hint
execute if score #hint_choice gd_ctx matches 0.. run return 0
scoreboard players add #hint_index gd_ctx 1
function guandan:hint/scan_option
