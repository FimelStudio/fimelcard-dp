scoreboard players set #probe_missing gd_ctx 0
scoreboard players operation #probe_step gd_ctx = #probe_first gd_ctx
function guandan:autopass/run_rank
execute if score #probe_missing gd_ctx <= #wild gd_ctx run function guandan:autopass/accept
