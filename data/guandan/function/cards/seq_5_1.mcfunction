scoreboard players set #inside gd_ctx 0
scoreboard players operation #inside gd_ctx += #r14 gd_ctx
scoreboard players operation #inside gd_ctx += #r2 gd_ctx
scoreboard players operation #inside gd_ctx += #r3 gd_ctx
execute if score #inside gd_ctx = #nonwild gd_ctx if score #r14 gd_ctx matches ..2 if score #r2 gd_ctx matches ..2 if score #r3 gd_ctx matches ..2 run function guandan:cards/seq_append_5_1
