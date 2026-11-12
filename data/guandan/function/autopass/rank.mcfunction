$scoreboard players set #probe_rank gd_ctx $(rank)
$scoreboard players operation #probe_total gd_ctx = #r$(rank) gd_ctx
scoreboard players operation #probe_natural gd_ctx = #probe_total gd_ctx
scoreboard players operation #high gd_ctx = #probe_rank gd_ctx
execute if score #probe_rank gd_ctx matches 15.. run scoreboard players add #high gd_ctx 1
execute if score #probe_rank gd_ctx = #level gd_ctx run scoreboard players set #high gd_ctx 15
execute if score #probe_rank gd_ctx matches ..14 run scoreboard players operation #probe_total gd_ctx += #wild gd_ctx
execute if score #probe_hint gd_ctx matches 1 if score @s gd_lastkind matches 0 run function guandan:hint/lead_rank
execute if score @s gd_lastkind matches 1..3 if score #probe_total gd_ctx >= @s gd_lastsize run function guandan:autopass/same
execute if score #probe_available gd_ctx matches 1 run return 0
execute if score #probe_rank gd_ctx matches ..14 if score #probe_total gd_ctx matches 4.. run function guandan:autopass/bomb
execute if score #probe_available gd_ctx matches 1 run return 0
$execute if score @s gd_lastkind matches 4 if score #probe_rank gd_ctx matches ..14 if score #probe_total gd_ctx matches 3.. run function guandan:autopass/full {rank:$(rank)}
$execute if score #probe_hint gd_ctx matches 1 if score @s gd_lastkind matches 0 if score #probe_rank gd_ctx matches ..14 if score #probe_total gd_ctx matches 3.. run function guandan:autopass/full {rank:$(rank)}
