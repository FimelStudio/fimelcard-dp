scoreboard players operation #ui_setting_input un_ctx = @s un_settings
scoreboard players reset @s un_settings
execute unless entity @s[tag=ct.player] run return run function uno:settings/invalid
execute unless score @s un_nonce = #ui_load un_ctx run return run function uno:settings/invalid
execute unless score @s ct_id = @s un_set_table run return run function uno:settings/invalid
scoreboard players set #ui_100000 un_ctx 100000
scoreboard players operation #ui_setting_nonce un_ctx = #ui_setting_input un_ctx
scoreboard players operation #ui_setting_nonce un_ctx /= #ui_100000 un_ctx
execute unless score #ui_setting_nonce un_ctx = @s un_setnonce run return run function uno:settings/invalid
scoreboard players set @s un_setnonce 0
scoreboard players operation #ui_setting_input un_ctx %= #ui_100000 un_ctx
scoreboard players set #ui_1000 un_ctx 1000
scoreboard players operation #ui_setting_field un_ctx = #ui_setting_input un_ctx
scoreboard players operation #ui_setting_field un_ctx /= #ui_1000 un_ctx
scoreboard players operation #ui_setting_value un_ctx = #ui_setting_input un_ctx
scoreboard players operation #ui_setting_value un_ctx %= #ui_1000 un_ctx
tag @e[tag=un.setting_table] remove un.setting_table
scoreboard players operation #ui_setting_table un_ctx = @s un_set_table
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=11,ct_state=0}] if score @s ct_id = #ui_setting_table un_ctx run tag @s add un.setting_table
execute unless entity @e[tag=un.setting_table,limit=1] run return run function uno:settings/invalid
execute unless score #ui_setting_field un_ctx matches 0..6 run return run function uno:settings/invalid
execute if score #ui_setting_field un_ctx matches 0 unless score #ui_setting_value un_ctx matches 0 run return run function uno:settings/invalid
execute if score #ui_setting_field un_ctx matches 1 unless score #ui_setting_value un_ctx matches 0..2 run return run function uno:settings/invalid
execute if score #ui_setting_field un_ctx matches 2 unless score #ui_setting_value un_ctx matches 1..32 run return run function uno:settings/invalid
execute if score #ui_setting_field un_ctx matches 3 unless score #ui_setting_value un_ctx matches 1..10 run return run function uno:settings/invalid
execute if score #ui_setting_field un_ctx matches 4..5 unless score #ui_setting_value un_ctx matches 0..1 run return run function uno:settings/invalid
execute if score #ui_setting_field un_ctx matches 6 unless score #ui_setting_value un_ctx matches 1..5 run return run function uno:settings/invalid
execute if score #ui_setting_field un_ctx matches 0 run return run function uno:settings/close
execute if score #ui_setting_field un_ctx matches 1 run scoreboard players operation @e[tag=un.setting_table,limit=1] un_mode = #ui_setting_value un_ctx
execute if score #ui_setting_field un_ctx matches 2 run scoreboard players operation @e[tag=un.setting_table,limit=1] un_rounds = #ui_setting_value un_ctx
execute if score #ui_setting_field un_ctx matches 3 run scoreboard players set #ui_factor un_ctx 100
execute if score #ui_setting_field un_ctx matches 3 run scoreboard players operation #ui_setting_value un_ctx *= #ui_factor un_ctx
execute if score #ui_setting_field un_ctx matches 3 run scoreboard players operation @e[tag=un.setting_table,limit=1] un_target = #ui_setting_value un_ctx
execute if score #ui_setting_field un_ctx matches 4 run scoreboard players operation @e[tag=un.setting_table,limit=1] un_auto = #ui_setting_value un_ctx
execute if score #ui_setting_field un_ctx matches 5 run scoreboard players operation @e[tag=un.setting_table,limit=1] un_challenge = #ui_setting_value un_ctx
execute if score #ui_setting_field un_ctx matches 6 run scoreboard players set #ui_factor un_ctx 20
execute if score #ui_setting_field un_ctx matches 6 run scoreboard players operation #ui_setting_value un_ctx *= #ui_factor un_ctx
execute if score #ui_setting_field un_ctx matches 6 run scoreboard players operation @e[tag=un.setting_table,limit=1] un_window = #ui_setting_value un_ctx
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
execute as @e[tag=un.setting_table,limit=1] at @s run function uno:settings/open
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @e[tag=un.setting_table] remove un.setting_table
