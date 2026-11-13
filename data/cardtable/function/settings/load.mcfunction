scoreboard objectives add ct_st_nonce dummy
scoreboard objectives add ct_st_table dummy
scoreboard objectives add ct_st_game dummy
scoreboard objectives add ct_st_load dummy
scoreboard objectives add ct_st_seen dummy
scoreboard objectives add ct_st_seat dummy
scoreboard objectives add ct_setting trigger
scoreboard players add #setting_load ct_ctx 1
execute unless score #setting_serial ct_ctx matches 1..9999 run scoreboard players set #setting_serial ct_ctx 1
scoreboard players set #setting_scale ct_ctx 100000
scoreboard players set #setting_thousand ct_ctx 1000
scoreboard players reset * ct_setting
scoreboard players reset * ct_st_nonce
scoreboard objectives add fc_settings trigger
scoreboard players reset * fc_settings
scoreboard objectives add hb_settings trigger
scoreboard players reset * hb_settings
scoreboard objectives add ab_settings trigger
scoreboard players reset * ab_settings
scoreboard objectives add dc_settings trigger
scoreboard players reset * dc_settings
scoreboard objectives add wq_settings trigger
scoreboard players reset * wq_settings
scoreboard objectives add dd_settings trigger
scoreboard players reset * dd_settings
scoreboard objectives add it_settings trigger
scoreboard players reset * it_settings
