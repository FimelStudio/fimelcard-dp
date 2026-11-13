scoreboard players operation #probe_need gd_ctx = #probe_copies gd_ctx
$execute unless score #kind gd_ctx matches 9 run scoreboard players operation #probe_need gd_ctx -= #r$(rank) gd_ctx
$execute if score #kind gd_ctx matches 9 if entity @e[tag=gd.cards,scores={gd_owner=$(seat),gd_point=$(rank),gd_suit=$(suit),gd_wild=0}] run scoreboard players set #probe_need gd_ctx 0
execute if score #probe_need gd_ctx matches 1.. run scoreboard players operation #probe_missing gd_ctx += #probe_need gd_ctx
