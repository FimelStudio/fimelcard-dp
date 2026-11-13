scoreboard players operation #setting_input ct_ctx = @s ct_setting
scoreboard players reset @s ct_setting
execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_st_load = #setting_load ct_ctx run return run function cardtable:settings/invalid
execute unless score @s ct_st_table = @s ct_id run return run function cardtable:settings/invalid
execute unless score @s ct_st_seat = @s ct_seat run return run function cardtable:settings/invalid
execute unless score #setting_input ct_ctx matches 100000..999999999 run return run function cardtable:settings/invalid
scoreboard players operation #setting_nonce ct_ctx = #setting_input ct_ctx
scoreboard players operation #setting_nonce ct_ctx /= #setting_scale ct_ctx
execute unless score #setting_nonce ct_ctx = @s ct_st_nonce run return run function cardtable:settings/invalid
scoreboard players operation #setting_field ct_ctx = #setting_input ct_ctx
scoreboard players operation #setting_field ct_ctx %= #setting_scale ct_ctx
scoreboard players operation #setting_value ct_ctx = #setting_field ct_ctx
scoreboard players operation #setting_field ct_ctx /= #setting_thousand ct_ctx
scoreboard players operation #setting_value ct_ctx %= #setting_thousand ct_ctx
scoreboard players operation #setting_table ct_ctx = @s ct_st_table
tag @e[tag=ct.setting_controller] remove ct.setting_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0}] if score @s ct_id = #setting_table ct_ctx run tag @s add ct.setting_controller
execute unless entity @e[tag=ct.setting_controller,limit=1] run return run function cardtable:settings/invalid
execute unless score @s ct_st_game = @e[tag=ct.setting_controller,limit=1] ct_game run return run function cardtable:settings/invalid
execute unless score @s ct_st_seen = @e[tag=ct.setting_controller,limit=1] ct_ch_epoch run return run function cardtable:settings/invalid
scoreboard players reset @s ct_st_nonce
execute if score #setting_field ct_ctx matches 0 if score #setting_value ct_ctx matches 0 run return run function cardtable:settings/close
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
execute as @e[tag=ct.setting_controller,limit=1] at @s run function cardtable:settings/apply
tag @s remove ct.settings_actor
tag @e[tag=ct.setting_controller] remove ct.setting_controller
