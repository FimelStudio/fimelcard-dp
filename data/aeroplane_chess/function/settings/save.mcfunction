scoreboard players operation #setting_input ac_ctx = @s ac_settings
scoreboard players reset @s ac_settings
execute unless entity @s[tag=ct.player] run return run function aeroplane_chess:settings/invalid
execute unless score @s ac_nonce = #ui_load ac_ctx run return run function aeroplane_chess:settings/invalid
execute unless score @s ct_id = @s ac_set_table run return run function aeroplane_chess:settings/invalid
execute unless score #setting_input ac_ctx matches 100000000..999991401 run return run function aeroplane_chess:settings/invalid
scoreboard players set #setting_scale ac_ctx 10000
scoreboard players operation #setting_nonce ac_ctx = #setting_input ac_ctx
scoreboard players operation #setting_nonce ac_ctx /= #setting_scale ac_ctx
execute unless score #setting_nonce ac_ctx = @s ac_setnonce run return run function aeroplane_chess:settings/invalid
scoreboard players operation #setting_field ac_ctx = #setting_input ac_ctx
scoreboard players operation #setting_field ac_ctx %= #setting_scale ac_ctx
scoreboard players operation #setting_field ac_ctx /= #hundred ac_ctx
scoreboard players operation #setting_value ac_ctx = #setting_input ac_ctx
scoreboard players operation #setting_value ac_ctx %= #hundred ac_ctx
scoreboard players operation #setting_table ac_ctx = @s ac_set_table
scoreboard players operation #setting_epoch ac_ctx = @s ac_setepoch
tag @e[tag=ac.setting_table] remove ac.setting_table
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=15,ct_state=0}] if score @s ct_id = #setting_table ac_ctx if score @s ac_epoch = #setting_epoch ac_ctx run tag @s add ac.setting_table
execute unless entity @e[tag=ac.setting_table,limit=1] run return run function aeroplane_chess:settings/invalid
execute unless score #setting_field ac_ctx matches 0..14 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 0 unless score #setting_value ac_ctx matches 0 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 1 unless score #setting_value ac_ctx matches 0..2 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 2 unless score #setting_value ac_ctx matches 0..1 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 3 unless score #setting_value ac_ctx matches 0..1 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 4 unless score #setting_value ac_ctx matches 0..1 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 5 unless score #setting_value ac_ctx matches 0..1 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 6 unless score #setting_value ac_ctx matches 0..1 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 7 unless score #setting_value ac_ctx matches 0..0 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 8 unless score #setting_value ac_ctx matches 0..1 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 9 unless score #setting_value ac_ctx matches 0..4 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 10 unless score #setting_value ac_ctx matches 0..1 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 11 unless score #setting_value ac_ctx matches 0..1 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 12 unless score #setting_value ac_ctx matches 0..2 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 13 unless score #setting_value ac_ctx matches 0..1 run return run function aeroplane_chess:settings/invalid
execute if score #setting_field ac_ctx matches 14 unless score #setting_value ac_ctx matches 0..1 run return run function aeroplane_chess:settings/invalid
scoreboard players set @s ac_setnonce 0
execute if score #setting_field ac_ctx matches 0 run return run function aeroplane_chess:settings/close
execute if score #setting_field ac_ctx matches 1 run scoreboard players operation @e[tag=ac.setting_table,limit=1] ac_takeoff = #setting_value ac_ctx
execute if score #setting_field ac_ctx matches 2 run scoreboard players operation @e[tag=ac.setting_table,limit=1] ac_extra = #setting_value ac_ctx
execute if score #setting_field ac_ctx matches 3 run scoreboard players operation @e[tag=ac.setting_table,limit=1] ac_triple = #setting_value ac_ctx
execute if score #setting_field ac_ctx matches 4 run scoreboard players operation @e[tag=ac.setting_table,limit=1] ac_jump = #setting_value ac_ctx
execute if score #setting_field ac_ctx matches 5 run scoreboard players operation @e[tag=ac.setting_table,limit=1] ac_fly = #setting_value ac_ctx
execute if score #setting_field ac_ctx matches 6 run scoreboard players operation @e[tag=ac.setting_table,limit=1] ac_finish = #setting_value ac_ctx
execute if score #setting_field ac_ctx matches 7 run scoreboard players operation @e[tag=ac.setting_table,limit=1] ac_palette = #setting_value ac_ctx
execute if score #setting_field ac_ctx matches 8 run scoreboard players operation @e[tag=ac.setting_table,limit=1] ac_orient = #setting_value ac_ctx
execute if score #setting_field ac_ctx matches 9 run scoreboard players operation @e[tag=ac.setting_table,limit=1] ac_first = #setting_value ac_ctx
execute if score #setting_field ac_ctx matches 10 run scoreboard players operation @e[tag=ac.setting_table,limit=1] ac_speed = #setting_value ac_ctx
execute if score #setting_field ac_ctx matches 11 run scoreboard players operation @e[tag=ac.setting_table,limit=1] ac_hints = #setting_value ac_ctx
execute if score #setting_field ac_ctx matches 12 run scoreboard players operation @e[tag=ac.setting_table,limit=1] ac_fill = #setting_value ac_ctx
execute if score #setting_field ac_ctx matches 13 run scoreboard players operation @e[tag=ac.setting_table,limit=1] ac_ranking = #setting_value ac_ctx
execute if score #setting_field ac_ctx matches 14 run scoreboard players operation @e[tag=ac.setting_table,limit=1] ac_assign = #setting_value ac_ctx
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
execute if score #setting_field ac_ctx matches 7..8 as @e[tag=ac.setting_table,limit=1] at @s run function aeroplane_chess:game/preview
execute as @e[tag=ac.setting_table,limit=1] at @s run function aeroplane_chess:settings/open
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @e[tag=ac.setting_table] remove ac.setting_table
