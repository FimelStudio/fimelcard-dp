execute if score #setting_field ct_ctx matches 1 unless score #setting_value ct_ctx matches 0..1 run return 0
execute if score #setting_field ct_ctx matches 2 unless score #setting_value ct_ctx matches 1..32 run return 0
execute if score #setting_field ct_ctx matches 3 unless score #setting_value ct_ctx matches 0..1 run return 0
execute unless score #setting_field ct_ctx matches 1..3 run return 0
execute if score #setting_field ct_ctx matches 1 run scoreboard players operation @s dc_team_mode = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 2 run scoreboard players operation @s dc_round_limit = #setting_value ct_ctx
execute if score #setting_field ct_ctx matches 3 run scoreboard players operation @s dc_input = #setting_value ct_ctx
scoreboard players add @s ct_ch_epoch 1
function cardtable:settings/open
