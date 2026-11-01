scoreboard players operation #pub_low gd_ctx = #pub_high gd_ctx
scoreboard players operation #pub_end gd_ctx = #pub_high gd_ctx
execute if score #pub_kind gd_ctx matches 5 run scoreboard players remove #pub_low gd_ctx 2
execute if score #pub_kind gd_ctx matches 5 run scoreboard players set #pub_multi gd_ctx 2
execute if score #pub_kind gd_ctx matches 6 run scoreboard players remove #pub_low gd_ctx 1
execute if score #pub_kind gd_ctx matches 6 run scoreboard players set #pub_multi gd_ctx 3
execute if score #pub_kind gd_ctx matches 7 run scoreboard players remove #pub_low gd_ctx 4
execute if score #pub_kind gd_ctx matches 9 run scoreboard players remove #pub_low gd_ctx 4
execute if score #pub_kind gd_ctx matches 7 run scoreboard players set #pub_multi gd_ctx 1
execute if score #pub_kind gd_ctx matches 9 run scoreboard players set #pub_multi gd_ctx 1
