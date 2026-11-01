scoreboard players set #inside gd_ctx 0
scoreboard players operation #inside gd_ctx += #r5 gd_ctx
scoreboard players operation #inside gd_ctx += #r6 gd_ctx
scoreboard players operation #inside gd_ctx += #r7 gd_ctx
execute if score #inside gd_ctx = #nonwild gd_ctx if score #r5 gd_ctx matches ..2 if score #r6 gd_ctx matches ..2 if score #r7 gd_ctx matches ..2 run function guandan:cards/seq_append_5_5
