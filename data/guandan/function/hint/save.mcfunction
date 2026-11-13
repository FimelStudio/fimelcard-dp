$scoreboard players operation #hint_$(slot) gd_ctx = #hint_key gd_ctx
$data modify storage guandan:hint $(slot) set value {}
$execute store result storage guandan:hint $(slot).kind int 1 run scoreboard players get #kind gd_ctx
$execute store result storage guandan:hint $(slot).size int 1 run scoreboard players get #size gd_ctx
$execute store result storage guandan:hint $(slot).rank int 1 run scoreboard players get #probe_rank gd_ctx
$execute store result storage guandan:hint $(slot).pair int 1 run scoreboard players get #probe_pair_rank gd_ctx
$execute store result storage guandan:hint $(slot).first int 1 run scoreboard players get #probe_first gd_ctx
$execute store result storage guandan:hint $(slot).last int 1 run scoreboard players get #probe_end gd_ctx
$execute store result storage guandan:hint $(slot).copies int 1 run scoreboard players get #probe_copies gd_ctx
$execute store result storage guandan:hint $(slot).suit int 1 run scoreboard players get #probe_suit gd_ctx
