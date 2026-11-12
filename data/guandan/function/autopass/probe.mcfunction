# 只统计行动者手牌。按现有牌型的点数需求检查是否存在子集，保留选牌和牌型窗口。
scoreboard players set #probe_available gd_ctx 0
execute if score @s gd_lastkind matches 10 run return 0
function guandan:cards/reset_counts
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run function guandan:cards/count
execute if score #bad gd_ctx matches 1.. run return run scoreboard players set #probe_available gd_ctx 1
execute if score #r15 gd_ctx matches 2 if score #r16 gd_ctx matches 2 unless score #probe_hint gd_ctx matches 1 run return run scoreboard players set #probe_available gd_ctx 1
execute if score #r15 gd_ctx matches 2 if score #r16 gd_ctx matches 2 if score #probe_hint gd_ctx matches 1 run function guandan:hint/jokers
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/rank {rank:2}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/rank {rank:3}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/rank {rank:4}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/rank {rank:5}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/rank {rank:6}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/rank {rank:7}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/rank {rank:8}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/rank {rank:9}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/rank {rank:10}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/rank {rank:11}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/rank {rank:12}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/rank {rank:13}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/rank {rank:14}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/rank {rank:15}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/rank {rank:16}
execute unless score #probe_available gd_ctx matches 1 run function guandan:autopass/runs
