scoreboard players operation #ui_setting_input gm_ctx = @s gm_settings
scoreboard players reset @s gm_settings
execute unless entity @s[tag=ct.player] run return run function gomoku:settings/invalid
execute unless score @s gm_nonce = #ui_load gm_ctx run return run function gomoku:settings/invalid
execute unless score @s ct_id = @s gm_set_table run return run function gomoku:settings/invalid
execute unless score #ui_setting_input gm_ctx matches 100000000..999999999 run return run function gomoku:settings/invalid
scoreboard players set #ui_100 gm_ctx 100
scoreboard players set #ui_10000 gm_ctx 10000
scoreboard players operation #ui_setting_nonce gm_ctx = #ui_setting_input gm_ctx
scoreboard players operation #ui_setting_nonce gm_ctx /= #ui_10000 gm_ctx
execute unless score #ui_setting_nonce gm_ctx = @s gm_setnonce run return run function gomoku:settings/invalid
scoreboard players operation #ui_setting_field gm_ctx = #ui_setting_input gm_ctx
scoreboard players operation #ui_setting_field gm_ctx /= #ui_100 gm_ctx
scoreboard players operation #ui_setting_field gm_ctx %= #ui_100 gm_ctx
scoreboard players operation #ui_setting_value gm_ctx = #ui_setting_input gm_ctx
scoreboard players operation #ui_setting_value gm_ctx %= #ui_100 gm_ctx
tag @e[tag=gm.setting_table] remove gm.setting_table
scoreboard players operation #ui_setting_table gm_ctx = @s gm_set_table
scoreboard players operation #ui_setting_epoch gm_ctx = @s gm_setepoch
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=14,ct_state=0}] if score @s ct_id = #ui_setting_table gm_ctx if score @s gm_epoch = #ui_setting_epoch gm_ctx run tag @s add gm.setting_table
execute unless entity @e[tag=gm.setting_table,limit=1] run return run function gomoku:settings/invalid
execute unless score #ui_setting_field gm_ctx matches 0..10 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 0 unless score #ui_setting_value gm_ctx matches 0 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 1 unless score #ui_setting_value gm_ctx matches 13 unless score #ui_setting_value gm_ctx matches 15 unless score #ui_setting_value gm_ctx matches 19 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 2 unless score #ui_setting_value gm_ctx matches 0..1 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 3 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 4 unless score #ui_setting_value gm_ctx matches 0 unless score #ui_setting_value gm_ctx matches 1 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 5 unless score #ui_setting_value gm_ctx matches 0 unless score #ui_setting_value gm_ctx matches 1 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 6 unless score #ui_setting_value gm_ctx matches 0 unless score #ui_setting_value gm_ctx matches 5 unless score #ui_setting_value gm_ctx matches 10 unless score #ui_setting_value gm_ctx matches 15 unless score #ui_setting_value gm_ctx matches 20 unless score #ui_setting_value gm_ctx matches 25 unless score #ui_setting_value gm_ctx matches 30 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 7 unless score #ui_setting_value gm_ctx matches 1 unless score #ui_setting_value gm_ctx matches 2 unless score #ui_setting_value gm_ctx matches 3 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 8 unless score #ui_setting_value gm_ctx matches 0 unless score #ui_setting_value gm_ctx matches 1 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 9 unless score #ui_setting_value gm_ctx matches 0 unless score #ui_setting_value gm_ctx matches 1 run return run function gomoku:settings/invalid
execute if score #ui_setting_field gm_ctx matches 10 unless score #ui_setting_value gm_ctx matches 0 unless score #ui_setting_value gm_ctx matches 1 run return run function gomoku:settings/invalid
scoreboard players set @s gm_setnonce 0
execute if score #ui_setting_field gm_ctx matches 0 run return run function gomoku:settings/close
execute if score #ui_setting_field gm_ctx matches 1 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_size = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 2 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_board = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 3 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_palette = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 4 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_orient = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 5 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_first = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 6 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_time = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 7 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_level = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 8 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_mark = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 9 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_coords = #ui_setting_value gm_ctx
execute if score #ui_setting_field gm_ctx matches 10 run scoreboard players operation @e[tag=gm.setting_table,limit=1] gm_confirm = #ui_setting_value gm_ctx
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
# 外观立即重建本桌预览；一次刷新后绑定新epoch，其他旧窗口也随之失效。
execute if score #ui_setting_field gm_ctx matches 1 as @e[tag=gm.setting_table,limit=1] run data remove entity @s data.gomoku.review
execute if score #ui_setting_field gm_ctx matches 8..9 as @e[tag=gm.setting_table,limit=1] at @s run function gomoku:game/preview
execute if score #ui_setting_field gm_ctx matches 1..4 as @e[tag=gm.setting_table,limit=1] at @s run function gomoku:game/preview
execute as @e[tag=gm.setting_table,limit=1] at @s run function gomoku:settings/open
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @e[tag=gm.setting_table] remove gm.setting_table
