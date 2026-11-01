execute if score #pub_low gd_ctx > #pub_end gd_ctx run return 0
scoreboard players operation #pub_point gd_ctx = #pub_low gd_ctx
execute if score #pub_point gd_ctx matches 1 run scoreboard players set #pub_point gd_ctx 14
scoreboard players set #pub_count gd_ctx 0
function guandan:game/public_natural
execute if score #pub_multi gd_ctx matches 1.. run function guandan:game/public_wild
scoreboard players add #pub_low gd_ctx 1
function guandan:game/public_rank_loop
