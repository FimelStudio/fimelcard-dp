execute unless score @s ct_state matches 0 run return 0
execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
scoreboard players operation #setting_table ct_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,limit=1] ct_id = #setting_table ct_ctx run return 0
function cardtable:chairs/layout/ensure
execute unless score @s ct_ch_epoch matches 0.. run scoreboard players set @s ct_ch_epoch 0
scoreboard players add #setting_serial ct_ctx 1
execute if score #setting_serial ct_ctx matches 10000.. run scoreboard players add #setting_load ct_ctx 1
execute if score #setting_serial ct_ctx matches 10000.. run scoreboard players set #setting_serial ct_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ct_st_nonce = #setting_serial ct_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ct_st_load = #setting_load ct_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ct_st_table = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ct_st_game = @s ct_game
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ct_st_seen = @s ct_ch_epoch
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ct_st_seat = @a[tag=ct.settings_actor,limit=1] ct_seat
scoreboard players set @a[tag=ct.settings_actor,limit=1] ct_setting 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] ct_setting
scoreboard players reset @a[tag=ct.settings_actor,limit=1] fc_settings
scoreboard players reset @a[tag=ct.settings_actor,limit=1] hb_settings
scoreboard players reset @a[tag=ct.settings_actor,limit=1] ab_settings
scoreboard players reset @a[tag=ct.settings_actor,limit=1] dc_settings
scoreboard players reset @a[tag=ct.settings_actor,limit=1] wq_settings
scoreboard players reset @a[tag=ct.settings_actor,limit=1] dd_settings
scoreboard players reset @a[tag=ct.settings_actor,limit=1] it_settings
scoreboard players operation #setting_base ct_ctx = #setting_serial ct_ctx
scoreboard players operation #setting_base ct_ctx *= #setting_scale ct_ctx
execute store result storage cardtable:settings close int 1 run scoreboard players get #setting_base ct_ctx
execute if score @s ct_game matches 1 run return run function cardtable:settings/render_1
execute if score @s ct_game matches 2 run return run function cardtable:settings/render_2
execute if score @s ct_game matches 3 run return run function cardtable:settings/render_3
execute if score @s ct_game matches 4 run return run function cardtable:settings/render_4
execute if score @s ct_game matches 5 run return run function cardtable:settings/render_5
execute if score @s ct_game matches 6 run return run function cardtable:settings/render_6
execute if score @s ct_game matches 7 run return run function cardtable:settings/render_7
execute if score @s ct_game matches 8 run return run function cardtable:settings/render_8
execute if score @s ct_game matches 9 run return run function cardtable:settings/render_9
execute if score @s ct_game matches 10 run return run function cardtable:settings/render_10
execute if score @s ct_game matches 16 run return run function cardtable:settings/render_16
execute if score @s ct_game matches 19 run return run function cardtable:settings/render_19
