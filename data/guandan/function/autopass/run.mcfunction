$scoreboard players set #kind gd_ctx $(kind)
$scoreboard players set #size gd_ctx $(size)
$scoreboard players set #power gd_ctx $(power)
$scoreboard players set #high gd_ctx $(end)
function guandan:cards/compare_candidate
execute unless score #beats gd_ctx matches 1 run return 0
$scoreboard players set #probe_first gd_ctx $(start)
$scoreboard players set #probe_end gd_ctx $(end)
$scoreboard players set #probe_copies gd_ctx $(copies)
execute unless score #kind gd_ctx matches 9 run return run function guandan:autopass/run_start
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/suit {suit:0}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/suit {suit:1}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/suit {suit:2}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/suit {suit:3}
