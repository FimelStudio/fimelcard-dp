$scoreboard players set #probe_pair_rank gd_ctx $(rank)
$execute if score #r$(rank) gd_ctx matches 2.. run return run function guandan:autopass/accept
$scoreboard players set #probe_pair gd_ctx $(rank)
execute if score #probe_pair gd_ctx matches 15.. run return 0
$scoreboard players operation #probe_pair gd_ctx = #r$(rank) gd_ctx
scoreboard players operation #probe_pair gd_ctx += #probe_left gd_ctx
execute if score #probe_pair gd_ctx matches 2.. run function guandan:autopass/accept
