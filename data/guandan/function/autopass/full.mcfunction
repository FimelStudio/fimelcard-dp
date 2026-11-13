scoreboard players set #kind gd_ctx 4
scoreboard players set #size gd_ctx 5
scoreboard players set #power gd_ctx 0
function guandan:cards/compare_candidate
execute unless score #beats gd_ctx matches 1 run return 0
scoreboard players operation #probe_left gd_ctx = #wild gd_ctx
$execute if score #r$(rank) gd_ctx matches ..2 run scoreboard players remove #probe_left gd_ctx 3
$execute if score #r$(rank) gd_ctx matches ..2 run scoreboard players operation #probe_left gd_ctx += #r$(rank) gd_ctx
execute unless score #probe_available gd_ctx matches 1 unless score #probe_rank gd_ctx matches 2 run function guandan:autopass/full_pair {rank:2}
execute unless score #probe_available gd_ctx matches 1 unless score #probe_rank gd_ctx matches 3 run function guandan:autopass/full_pair {rank:3}
execute unless score #probe_available gd_ctx matches 1 unless score #probe_rank gd_ctx matches 4 run function guandan:autopass/full_pair {rank:4}
execute unless score #probe_available gd_ctx matches 1 unless score #probe_rank gd_ctx matches 5 run function guandan:autopass/full_pair {rank:5}
execute unless score #probe_available gd_ctx matches 1 unless score #probe_rank gd_ctx matches 6 run function guandan:autopass/full_pair {rank:6}
execute unless score #probe_available gd_ctx matches 1 unless score #probe_rank gd_ctx matches 7 run function guandan:autopass/full_pair {rank:7}
execute unless score #probe_available gd_ctx matches 1 unless score #probe_rank gd_ctx matches 8 run function guandan:autopass/full_pair {rank:8}
execute unless score #probe_available gd_ctx matches 1 unless score #probe_rank gd_ctx matches 9 run function guandan:autopass/full_pair {rank:9}
execute unless score #probe_available gd_ctx matches 1 unless score #probe_rank gd_ctx matches 10 run function guandan:autopass/full_pair {rank:10}
execute unless score #probe_available gd_ctx matches 1 unless score #probe_rank gd_ctx matches 11 run function guandan:autopass/full_pair {rank:11}
execute unless score #probe_available gd_ctx matches 1 unless score #probe_rank gd_ctx matches 12 run function guandan:autopass/full_pair {rank:12}
execute unless score #probe_available gd_ctx matches 1 unless score #probe_rank gd_ctx matches 13 run function guandan:autopass/full_pair {rank:13}
execute unless score #probe_available gd_ctx matches 1 unless score #probe_rank gd_ctx matches 14 run function guandan:autopass/full_pair {rank:14}
execute unless score #probe_available gd_ctx matches 1 unless score #probe_rank gd_ctx matches 15 run function guandan:autopass/full_pair {rank:15}
execute unless score #probe_available gd_ctx matches 1 unless score #probe_rank gd_ctx matches 16 run function guandan:autopass/full_pair {rank:16}
