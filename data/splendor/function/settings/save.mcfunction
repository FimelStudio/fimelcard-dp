scoreboard players operation #set_input sp_ctx = @s sp_settings
scoreboard players reset @s sp_settings
execute unless entity @s[tag=ct.player] run return run function splendor:settings/invalid
execute unless score @s sp_setload = #settings_load sp_ctx run return run function splendor:settings/invalid
execute unless score @s ct_id = @s sp_settable run return run function splendor:settings/invalid
execute unless score @s ct_seat = @s sp_setseat run return run function splendor:settings/invalid
execute unless score #set_input sp_ctx matches 100000000..999990201 run return run function splendor:settings/invalid
scoreboard players operation #set_nonce sp_ctx = #set_input sp_ctx
scoreboard players operation #set_nonce sp_ctx /= #factor sp_ctx
execute unless score #set_nonce sp_ctx = @s sp_setnonce run return run function splendor:settings/invalid
scoreboard players operation #set_field sp_ctx = #set_input sp_ctx
scoreboard players operation #set_field sp_ctx %= #factor sp_ctx
scoreboard players operation #set_field sp_ctx /= #hundred sp_ctx
scoreboard players operation #set_value sp_ctx = #set_input sp_ctx
scoreboard players operation #set_value sp_ctx %= #hundred sp_ctx
scoreboard players operation #set_table sp_ctx = @s sp_settable
scoreboard players operation #set_epoch sp_ctx = @s sp_setepoch
scoreboard players operation #set_layout sp_ctx = @s sp_setlayout
tag @e[tag=sp.setting_table] remove sp.setting_table
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=22,ct_state=0}] if score @s ct_id = #set_table sp_ctx if score @s sp_epoch = #set_epoch sp_ctx if score @s ct_ch_epoch = #set_layout sp_ctx run tag @s add sp.setting_table
execute unless entity @e[tag=sp.setting_table,limit=1] run return run function splendor:settings/invalid
execute unless score #set_field sp_ctx matches 0..2 run return run function splendor:settings/invalid
execute if score #set_field sp_ctx matches 0 unless score #set_value sp_ctx matches 0 run return run function splendor:settings/invalid
execute if score #set_field sp_ctx matches 1..2 unless score #set_value sp_ctx matches 0..1 run return run function splendor:settings/invalid
scoreboard players reset @s sp_setnonce
execute if score #set_field sp_ctx matches 0 run return run function splendor:settings/close
execute if score #set_field sp_ctx matches 1 run scoreboard players operation @e[tag=sp.setting_table,limit=1] sp_first = #set_value sp_ctx
execute if score #set_field sp_ctx matches 2 run scoreboard players operation @e[tag=sp.setting_table,limit=1] sp_music = #set_value sp_ctx
scoreboard players add @e[tag=sp.setting_table,limit=1] sp_epoch 1
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
execute as @e[tag=sp.setting_table,limit=1] at @s run function splendor:settings/open
tag @s remove ct.settings_actor
tag @e[tag=sp.setting_table] remove sp.setting_table
