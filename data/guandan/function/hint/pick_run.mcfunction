execute store result storage guandan:hint pick.rank int 1 run scoreboard players get #hint_step gd_ctx
execute if score #hint_step gd_ctx matches 1 run data modify storage guandan:hint pick.rank set value 14
function guandan:hint/pick_cards with storage guandan:hint pick
execute if score #hint_step gd_ctx >= #hint_end gd_ctx run return 0
scoreboard players add #hint_step gd_ctx 1
function guandan:hint/pick_run
