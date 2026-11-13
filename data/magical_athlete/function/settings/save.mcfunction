scoreboard players operation #set_input ma_ctx = @s ma_settings
scoreboard players reset @s ma_settings
execute unless entity @s[tag=ct.player] run return run function magical_athlete:settings/invalid
execute unless score @s ma_setload = #settings_load ma_ctx run return run function magical_athlete:settings/invalid
execute unless score @s ct_id = @s ma_settable run return run function magical_athlete:settings/invalid
execute unless score @s ct_seat = @s ma_setseat run return run function magical_athlete:settings/invalid
execute unless score #set_input ma_ctx matches 100000000..999990501 run return run function magical_athlete:settings/invalid
scoreboard players operation #set_nonce ma_ctx = #set_input ma_ctx
scoreboard players operation #set_nonce ma_ctx /= #factor ma_ctx
execute unless score #set_nonce ma_ctx = @s ma_setnonce run return run function magical_athlete:settings/invalid
scoreboard players operation #set_field ma_ctx = #set_input ma_ctx
scoreboard players operation #set_field ma_ctx %= #factor ma_ctx
scoreboard players operation #set_field ma_ctx /= #hundred ma_ctx
scoreboard players operation #set_value ma_ctx = #set_input ma_ctx
scoreboard players operation #set_value ma_ctx %= #hundred ma_ctx
scoreboard players operation #set_table ma_ctx = @s ma_settable
scoreboard players operation #set_epoch ma_ctx = @s ma_setepoch
scoreboard players operation #set_layout ma_ctx = @s ma_setlayout
tag @e[tag=ma.setting_table] remove ma.setting_table
execute as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_game=23,ct_state=0}] if score @s ct_id = #set_table ma_ctx if score @s ma_epoch = #set_epoch ma_ctx if score @s ct_ch_epoch = #set_layout ma_ctx run tag @s add ma.setting_table
execute unless entity @e[tag=ma.setting_table,limit=1] run return run function magical_athlete:settings/invalid
execute unless score #set_field ma_ctx matches 0..5 run return run function magical_athlete:settings/invalid
execute if score #set_field ma_ctx matches 0 unless score #set_value ma_ctx matches 0 run return run function magical_athlete:settings/invalid
execute if score #set_field ma_ctx matches 1 unless score #set_value ma_ctx matches 0..1 run return run function magical_athlete:settings/invalid
execute if score #set_field ma_ctx matches 2 unless score #set_value ma_ctx matches 0..2 run return run function magical_athlete:settings/invalid
execute if score #set_field ma_ctx matches 3 unless score #set_value ma_ctx matches 0..1 run return run function magical_athlete:settings/invalid
execute if score #set_field ma_ctx matches 4 unless score #set_value ma_ctx matches 0..1 run return run function magical_athlete:settings/invalid
execute if score #set_field ma_ctx matches 5 unless score #set_value ma_ctx matches 0..1 run return run function magical_athlete:settings/invalid
scoreboard players reset @s ma_setnonce
execute if score #set_field ma_ctx matches 0 run return run function magical_athlete:settings/close
execute if score #set_field ma_ctx matches 1 run scoreboard players operation @e[tag=ma.setting_table,limit=1] ma_draft = #set_value ma_ctx
execute if score #set_field ma_ctx matches 2 run scoreboard players operation @e[tag=ma.setting_table,limit=1] ma_track = #set_value ma_ctx
execute if score #set_field ma_ctx matches 3 run scoreboard players operation @e[tag=ma.setting_table,limit=1] ma_music = #set_value ma_ctx
execute if score #set_field ma_ctx matches 4 run scoreboard players operation @e[tag=ma.setting_table,limit=1] ma_speed = #set_value ma_ctx
execute if score #set_field ma_ctx matches 5 run scoreboard players operation @e[tag=ma.setting_table,limit=1] ma_orient = #set_value ma_ctx
scoreboard players add @e[tag=ma.setting_table,limit=1] ma_epoch 1
execute if score #set_field ma_ctx matches 2 as @e[tag=ma.setting_table,limit=1] at @s run function magical_athlete:game/preview
execute if score #set_field ma_ctx matches 5 as @e[tag=ma.setting_table,limit=1] at @s run function magical_athlete:game/preview
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
execute as @e[tag=ma.setting_table,limit=1] at @s run function magical_athlete:settings/open
tag @s remove ct.settings_actor
tag @e[tag=ma.setting_table] remove ma.setting_table
