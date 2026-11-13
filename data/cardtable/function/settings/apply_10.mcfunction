execute if score #setting_field ct_ctx matches 1 unless score #setting_value ct_ctx matches 1..32 run return 0
execute if score #setting_field ct_ctx matches 2 unless score #setting_value ct_ctx matches 0..1 run return 0
execute if score #setting_field ct_ctx matches 3 unless score #setting_value ct_ctx matches 0..2 run return 0
execute if score #setting_field ct_ctx matches 3 unless score @s dd_mode matches 0 run return 0
execute if score #setting_field ct_ctx matches 4 unless score #setting_value ct_ctx matches 0..1 run return 0
execute if score #setting_field ct_ctx matches 5 unless score #setting_value ct_ctx matches 0..1 run return 0
execute if score #setting_field ct_ctx matches 6 unless score #setting_value ct_ctx matches 0..1 run return 0
execute if score #setting_field ct_ctx matches 7 unless score #setting_value ct_ctx matches 0..1 run return 0
execute if score #setting_field ct_ctx matches 8 unless score #setting_value ct_ctx matches 0..1 run return 0
execute if score #setting_field ct_ctx matches 8 unless score @s dd_mode matches 2 run return 0
execute if score #setting_field ct_ctx matches 8 unless score @s ct_capacity matches 8 run return 0
execute if score #setting_field ct_ctx matches 9 unless score #setting_value ct_ctx matches 0..2 run return 0
execute if score #setting_field ct_ctx matches 9 if score #setting_value ct_ctx matches 2 unless score @s ct_capacity matches 8 run return 0
execute if score #setting_field ct_ctx matches 10 unless score #setting_value ct_ctx matches 0 unless score #setting_value ct_ctx matches 30 unless score #setting_value ct_ctx matches 60 unless score #setting_value ct_ctx matches 90 unless score #setting_value ct_ctx matches 120 run return 0
execute unless score #setting_field ct_ctx matches 1..10 run return 0
execute if score #setting_field ct_ctx matches 1 run scoreboard players operation @s dd_max = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 2 run scoreboard players operation @s dd_audio = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 3 run scoreboard players operation @s dd_classic_bid = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 4 run scoreboard players operation @s dd_counts = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 5 run scoreboard players operation @s dd_counter = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 6 run scoreboard players operation @s dd_noshuffle = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 7 run scoreboard players operation @s dd_scoring = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 8 run scoreboard players operation @s dd_hide_score = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 9 run scoreboard players operation @s dd_mode = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 10 run scoreboard players operation @s dd_turn_limit = #setting_value ct_ctx
scoreboard players add @s ct_ch_epoch 1
function cardtable:settings/open
