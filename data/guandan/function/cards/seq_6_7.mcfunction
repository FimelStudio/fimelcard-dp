scoreboard players set #inside gd_ctx 0
scoreboard players operation #inside gd_ctx += #r7 gd_ctx
scoreboard players operation #inside gd_ctx += #r8 gd_ctx
execute if score #inside gd_ctx = #nonwild gd_ctx if score #r7 gd_ctx matches ..3 if score #r8 gd_ctx matches ..3 run function guandan:cards/seq_append_6_7
