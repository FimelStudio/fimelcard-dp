execute if score #setting_field ct_ctx matches 1 unless score #setting_value ct_ctx matches 1..32 run return 0
execute if score #setting_field ct_ctx matches 2 unless score #setting_value ct_ctx matches 0..1 run return 0
execute if score #setting_field ct_ctx matches 3 unless score #setting_value ct_ctx matches 0..2 run return 0
execute if score #setting_field ct_ctx matches 4 unless score #setting_value ct_ctx matches 0..1 run return 0
execute if score #setting_field ct_ctx matches 5 unless score #setting_value ct_ctx matches 0..1 run return 0
execute if score #setting_field ct_ctx matches 6 unless score #setting_value ct_ctx matches 0..1 run return 0
execute if score #setting_field ct_ctx matches 7 unless score #setting_value ct_ctx matches 0..1 run return 0
execute if score #setting_field ct_ctx matches 8 unless score #setting_value ct_ctx matches 0..1 run return 0
execute unless score #setting_field ct_ctx matches 1..8 run return 0
execute if score #setting_field ct_ctx matches 1 run scoreboard players operation @s dd_max = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 2 run scoreboard players operation @s dd_audio = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 3 run scoreboard players operation @s dd_classic_bid = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 4 run scoreboard players operation @s dd_counts = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 5 run scoreboard players operation @s dd_counter = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 6 run scoreboard players operation @s dd_noshuffle = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 7 run scoreboard players operation @s dd_scoring = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 8 run scoreboard players operation @s dd_hide_score = #setting_value ct_ctx
scoreboard players add @s ct_ch_epoch 1
function cardtable:settings/open
