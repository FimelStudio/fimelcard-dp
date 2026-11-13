execute store result storage guandan:probe run.rank int 1 run scoreboard players get #probe_step gd_ctx
execute if score #probe_step gd_ctx matches 1 run data modify storage guandan:probe run.rank set value 14
function guandan:autopass/run_count with storage guandan:probe run
execute if score #probe_missing gd_ctx > #wild gd_ctx run return 0
execute if score #probe_step gd_ctx >= #probe_end gd_ctx run return 0
scoreboard players add #probe_step gd_ctx 1
function guandan:autopass/run_rank
