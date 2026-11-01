scoreboard players operation @s gd_setinput = @s gd_settings
scoreboard players reset @s gd_settings
execute unless entity @s[tag=ct.player] run return run function guandan:settings/invalid
execute unless score @s gd_setload = #ui_load gd_ctx run return run function guandan:settings/invalid
execute unless score @s ct_id = @s gd_settable run return run function guandan:settings/invalid
scoreboard players set #setting_factor gd_ctx 100000
scoreboard players operation #setting_nonce gd_ctx = @s gd_setinput
scoreboard players operation #setting_nonce gd_ctx /= #setting_factor gd_ctx
execute unless score #setting_nonce gd_ctx = @s gd_setnonce run return run function guandan:settings/invalid
scoreboard players set @s gd_setnonce 0
scoreboard players operation #setting_input gd_ctx = @s gd_setinput
scoreboard players operation #setting_input gd_ctx %= #setting_factor gd_ctx
scoreboard players set #setting_factor gd_ctx 1000
scoreboard players operation #setting_field gd_ctx = #setting_input gd_ctx
scoreboard players operation #setting_field gd_ctx /= #setting_factor gd_ctx
scoreboard players operation #setting_value gd_ctx = #setting_input gd_ctx
scoreboard players operation #setting_value gd_ctx %= #setting_factor gd_ctx
execute unless score #setting_field gd_ctx matches 0..6 run return run function guandan:settings/invalid
execute if score #setting_field gd_ctx matches 0 unless score #setting_value gd_ctx matches 0 run return run function guandan:settings/invalid
execute if score #setting_field gd_ctx matches 1 unless score #setting_value gd_ctx matches 0 unless score #setting_value gd_ctx matches 1 run return run function guandan:settings/invalid
execute if score #setting_field gd_ctx matches 2 unless score #setting_value gd_ctx matches 2 unless score #setting_value gd_ctx matches 3 unless score #setting_value gd_ctx matches 4 unless score #setting_value gd_ctx matches 5 unless score #setting_value gd_ctx matches 6 unless score #setting_value gd_ctx matches 7 unless score #setting_value gd_ctx matches 8 unless score #setting_value gd_ctx matches 9 unless score #setting_value gd_ctx matches 10 unless score #setting_value gd_ctx matches 11 unless score #setting_value gd_ctx matches 12 unless score #setting_value gd_ctx matches 13 unless score #setting_value gd_ctx matches 14 run return run function guandan:settings/invalid
execute if score #setting_field gd_ctx matches 3 unless score #setting_value gd_ctx matches 0 unless score #setting_value gd_ctx matches 1 run return run function guandan:settings/invalid
execute if score #setting_field gd_ctx matches 4 unless score #setting_value gd_ctx matches 1 unless score #setting_value gd_ctx matches 2 unless score #setting_value gd_ctx matches 3 unless score #setting_value gd_ctx matches 5 unless score #setting_value gd_ctx matches 8 unless score #setting_value gd_ctx matches 10 unless score #setting_value gd_ctx matches 16 unless score #setting_value gd_ctx matches 32 run return run function guandan:settings/invalid
execute if score #setting_field gd_ctx matches 5 unless score #setting_value gd_ctx matches 1 unless score #setting_value gd_ctx matches 0 run return run function guandan:settings/invalid
execute if score #setting_field gd_ctx matches 6 unless score #setting_value gd_ctx matches 0 unless score #setting_value gd_ctx matches 30 unless score #setting_value gd_ctx matches 60 unless score #setting_value gd_ctx matches 90 unless score #setting_value gd_ctx matches 120 run return run function guandan:settings/invalid
tag @e[tag=gd.setting_table] remove gd.setting_table
scoreboard players operation #setting_table gd_ctx = @s gd_settable
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=18,ct_state=0}] if score @s ct_id = #setting_table gd_ctx run tag @s add gd.setting_table
execute unless entity @e[tag=gd.setting_table,limit=1] run return run function guandan:settings/invalid
execute if score #setting_field gd_ctx matches 0 run return run function guandan:settings/close
execute if score #setting_field gd_ctx matches 1 run scoreboard players operation @e[tag=gd.setting_table,limit=1] gd_pair = #setting_value gd_ctx
execute if score #setting_field gd_ctx matches 2 run scoreboard players operation @e[tag=gd.setting_table,limit=1] gd_startlevel = #setting_value gd_ctx
execute if score #setting_field gd_ctx matches 3 run scoreboard players operation @e[tag=gd.setting_table,limit=1] gd_mode = #setting_value gd_ctx
execute if score #setting_field gd_ctx matches 4 run scoreboard players operation @e[tag=gd.setting_table,limit=1] gd_rounds = #setting_value gd_ctx
execute if score #setting_field gd_ctx matches 5 run scoreboard players operation @e[tag=gd.setting_table,limit=1] gd_show = #setting_value gd_ctx
execute if score #setting_field gd_ctx matches 6 run scoreboard players operation @e[tag=gd.setting_table,limit=1] gd_limit = #setting_value gd_ctx
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
execute as @e[tag=gd.setting_table,limit=1] at @s run function guandan:settings/open
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @e[tag=gd.setting_table] remove gd.setting_table
