scoreboard players operation #ui_setting_input go_ctx = @s go_settings
scoreboard players reset @s go_settings
execute unless entity @s[tag=ct.player] run return run function weiqi:settings/invalid
execute unless score @s go_nonce = #ui_load go_ctx run return run function weiqi:settings/invalid
execute unless score @s ct_id = @s go_set_table run return run function weiqi:settings/invalid
execute unless score #ui_setting_input go_ctx matches 100000000..999999999 run return run function weiqi:settings/invalid
scoreboard players set #ui_100 go_ctx 100
scoreboard players set #ui_10000 go_ctx 10000
scoreboard players operation #ui_setting_nonce go_ctx = #ui_setting_input go_ctx
scoreboard players operation #ui_setting_nonce go_ctx /= #ui_10000 go_ctx
execute unless score #ui_setting_nonce go_ctx = @s go_setnonce run return run function weiqi:settings/invalid
scoreboard players operation #ui_setting_field go_ctx = #ui_setting_input go_ctx
scoreboard players operation #ui_setting_field go_ctx /= #ui_100 go_ctx
scoreboard players operation #ui_setting_field go_ctx %= #ui_100 go_ctx
scoreboard players operation #ui_setting_value go_ctx = #ui_setting_input go_ctx
scoreboard players operation #ui_setting_value go_ctx %= #ui_100 go_ctx
tag @e[tag=go.setting_table] remove go.setting_table
scoreboard players operation #ui_setting_table go_ctx = @s go_set_table
scoreboard players operation #ui_setting_epoch go_ctx = @s go_setepoch
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=20,ct_state=0}] if score @s ct_id = #ui_setting_table go_ctx if score @s go_epoch = #ui_setting_epoch go_ctx unless score @s go_state matches 5 run tag @s add go.setting_table
execute unless entity @e[tag=go.setting_table,limit=1] run return run function weiqi:settings/invalid
execute unless score #ui_setting_field go_ctx matches 0..11 run return run function weiqi:settings/invalid
execute if score #ui_setting_field go_ctx matches 0 unless score #ui_setting_value go_ctx matches 0 run return run function weiqi:settings/invalid
execute if score #ui_setting_field go_ctx matches 1 unless score #ui_setting_value go_ctx matches 13 unless score #ui_setting_value go_ctx matches 15 unless score #ui_setting_value go_ctx matches 19 run return run function weiqi:settings/invalid
execute if score #ui_setting_field go_ctx matches 2 unless score #ui_setting_value go_ctx matches 0 unless score #ui_setting_value go_ctx matches 1 run return run function weiqi:settings/invalid
execute if score #ui_setting_field go_ctx matches 3 unless score #ui_setting_value go_ctx matches 0 unless score #ui_setting_value go_ctx matches 1 run return run function weiqi:settings/invalid
execute if score #ui_setting_field go_ctx matches 4 unless score #ui_setting_value go_ctx matches 1 unless score #ui_setting_value go_ctx matches 0 run return run function weiqi:settings/invalid
execute if score #ui_setting_field go_ctx matches 5 unless score #ui_setting_value go_ctx matches 0 unless score #ui_setting_value go_ctx matches 5 unless score #ui_setting_value go_ctx matches 10 unless score #ui_setting_value go_ctx matches 15 unless score #ui_setting_value go_ctx matches 20 unless score #ui_setting_value go_ctx matches 25 unless score #ui_setting_value go_ctx matches 30 run return run function weiqi:settings/invalid
execute if score #ui_setting_field go_ctx matches 6 unless score #ui_setting_value go_ctx matches 0 unless score #ui_setting_value go_ctx matches 11 unless score #ui_setting_value go_ctx matches 13 unless score #ui_setting_value go_ctx matches 15 unless score #ui_setting_value go_ctx matches 17 run return run function weiqi:settings/invalid
execute if score #ui_setting_field go_ctx matches 7 unless score #ui_setting_value go_ctx matches 1 unless score #ui_setting_value go_ctx matches 2 unless score #ui_setting_value go_ctx matches 3 run return run function weiqi:settings/invalid
execute if score #ui_setting_field go_ctx matches 8 unless score #ui_setting_value go_ctx matches 0 unless score #ui_setting_value go_ctx matches 1 run return run function weiqi:settings/invalid
execute if score #ui_setting_field go_ctx matches 9 unless score #ui_setting_value go_ctx matches 0 unless score #ui_setting_value go_ctx matches 1 run return run function weiqi:settings/invalid
execute if score #ui_setting_field go_ctx matches 10 unless score #ui_setting_value go_ctx matches 0 unless score #ui_setting_value go_ctx matches 1 run return run function weiqi:settings/invalid
execute if score #ui_setting_field go_ctx matches 11 unless score #ui_setting_value go_ctx matches 0 unless score #ui_setting_value go_ctx matches 1 run return run function weiqi:settings/invalid
scoreboard players set @s go_setnonce 0
execute if score #ui_setting_field go_ctx matches 0 run return run function weiqi:settings/close
execute if score #ui_setting_field go_ctx matches 1 run scoreboard players operation @e[tag=go.setting_table,limit=1] go_size = #ui_setting_value go_ctx
execute if score #ui_setting_field go_ctx matches 2 run scoreboard players operation @e[tag=go.setting_table,limit=1] go_board = #ui_setting_value go_ctx
execute if score #ui_setting_field go_ctx matches 3 run scoreboard players operation @e[tag=go.setting_table,limit=1] go_orient = #ui_setting_value go_ctx
execute if score #ui_setting_field go_ctx matches 4 run scoreboard players operation @e[tag=go.setting_table,limit=1] go_first = #ui_setting_value go_ctx
execute if score #ui_setting_field go_ctx matches 5 run scoreboard players operation @e[tag=go.setting_table,limit=1] go_time = #ui_setting_value go_ctx
execute if score #ui_setting_field go_ctx matches 6 run scoreboard players operation @e[tag=go.setting_table,limit=1] go_komi = #ui_setting_value go_ctx
execute if score #ui_setting_field go_ctx matches 7 run scoreboard players operation @e[tag=go.setting_table,limit=1] go_level = #ui_setting_value go_ctx
execute if score #ui_setting_field go_ctx matches 8 run scoreboard players operation @e[tag=go.setting_table,limit=1] go_coords = #ui_setting_value go_ctx
execute if score #ui_setting_field go_ctx matches 9 run scoreboard players operation @e[tag=go.setting_table,limit=1] go_mark = #ui_setting_value go_ctx
execute if score #ui_setting_field go_ctx matches 10 run scoreboard players operation @e[tag=go.setting_table,limit=1] go_confirm = #ui_setting_value go_ctx
execute if score #ui_setting_field go_ctx matches 11 run scoreboard players operation @e[tag=go.setting_table,limit=1] go_estimate = #ui_setting_value go_ctx
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
execute if score #ui_setting_field go_ctx matches 1 as @e[tag=go.setting_table,limit=1] run data remove entity @s data.weiqi.review
execute if score #ui_setting_field go_ctx matches 1..3 as @e[tag=go.setting_table,limit=1] at @s run function weiqi:game/preview
execute if score #ui_setting_field go_ctx matches 8..9 as @e[tag=go.setting_table,limit=1] at @s run function weiqi:game/preview
execute as @e[tag=go.setting_table,limit=1] at @s run function weiqi:settings/open
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @e[tag=go.setting_table] remove go.setting_table
