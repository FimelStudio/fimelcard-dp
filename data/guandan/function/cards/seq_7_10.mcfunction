scoreboard players set #inside gd_ctx 0
scoreboard players operation #inside gd_ctx += #r10 gd_ctx
scoreboard players operation #inside gd_ctx += #r11 gd_ctx
scoreboard players operation #inside gd_ctx += #r12 gd_ctx
scoreboard players operation #inside gd_ctx += #r13 gd_ctx
scoreboard players operation #inside gd_ctx += #r14 gd_ctx
scoreboard players set #natural_flush gd_ctx 0
execute if score #wild gd_ctx matches 0 if score #s0 gd_ctx matches 5 run scoreboard players set #natural_flush gd_ctx 1
execute if score #wild gd_ctx matches 0 if score #s1 gd_ctx matches 5 run scoreboard players set #natural_flush gd_ctx 1
execute if score #wild gd_ctx matches 0 if score #s2 gd_ctx matches 5 run scoreboard players set #natural_flush gd_ctx 1
execute if score #wild gd_ctx matches 0 if score #s3 gd_ctx matches 5 run scoreboard players set #natural_flush gd_ctx 1
execute if score #inside gd_ctx = #nonwild gd_ctx if score #r10 gd_ctx matches ..1 if score #r11 gd_ctx matches ..1 if score #r12 gd_ctx matches ..1 if score #r13 gd_ctx matches ..1 if score #r14 gd_ctx matches ..1 if score #natural_flush gd_ctx matches 0 run function guandan:cards/seq_append_7_10
execute if score #inside gd_ctx = #nonwild gd_ctx if score #r10 gd_ctx matches ..1 if score #r11 gd_ctx matches ..1 if score #r12 gd_ctx matches ..1 if score #r13 gd_ctx matches ..1 if score #r14 gd_ctx matches ..1 if score #s0 gd_ctx = #nonwild gd_ctx run function guandan:cards/seq_flush_10_0
execute if score #inside gd_ctx = #nonwild gd_ctx if score #r10 gd_ctx matches ..1 if score #r11 gd_ctx matches ..1 if score #r12 gd_ctx matches ..1 if score #r13 gd_ctx matches ..1 if score #r14 gd_ctx matches ..1 if score #s1 gd_ctx = #nonwild gd_ctx run function guandan:cards/seq_flush_10_1
execute if score #inside gd_ctx = #nonwild gd_ctx if score #r10 gd_ctx matches ..1 if score #r11 gd_ctx matches ..1 if score #r12 gd_ctx matches ..1 if score #r13 gd_ctx matches ..1 if score #r14 gd_ctx matches ..1 if score #s2 gd_ctx = #nonwild gd_ctx run function guandan:cards/seq_flush_10_2
execute if score #inside gd_ctx = #nonwild gd_ctx if score #r10 gd_ctx matches ..1 if score #r11 gd_ctx matches ..1 if score #r12 gd_ctx matches ..1 if score #r13 gd_ctx matches ..1 if score #r14 gd_ctx matches ..1 if score #s3 gd_ctx = #nonwild gd_ctx run function guandan:cards/seq_flush_10_3
