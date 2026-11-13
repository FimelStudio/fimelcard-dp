execute if score #probe_hint gd_ctx matches 1 run return run function guandan:hint/bombs
scoreboard players set #kind gd_ctx 8
scoreboard players operation #size gd_ctx = #probe_total gd_ctx
scoreboard players operation #power gd_ctx = #size gd_ctx
execute if score #size gd_ctx matches 6.. run scoreboard players add #power gd_ctx 1
function guandan:autopass/compare
