scoreboard players set #inside gd_ctx 0
scoreboard players operation #inside gd_ctx += #r8 gd_ctx
scoreboard players operation #inside gd_ctx += #r9 gd_ctx
scoreboard players operation #inside gd_ctx += #r10 gd_ctx
execute if score #inside gd_ctx = #nonwild gd_ctx if score #r8 gd_ctx matches ..2 if score #r9 gd_ctx matches ..2 if score #r10 gd_ctx matches ..2 run function guandan:cards/seq_append_5_8
