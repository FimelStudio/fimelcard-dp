scoreboard players operation #ui_setting_input ch_ctx = @s ch_settings
scoreboard players reset @s ch_settings
execute unless entity @s[tag=ct.player] run return run function chess:settings/invalid
execute unless score @s ch_nonce = #ui_load ch_ctx run return run function chess:settings/invalid
execute unless score @s ct_id = @s ch_set_table run return run function chess:settings/invalid
execute unless score #ui_setting_input ch_ctx matches 10000000..999999999 run return run function chess:settings/invalid
scoreboard players set #ui_10 ch_ctx 10
scoreboard players set #ui_100 ch_ctx 100
scoreboard players operation #ui_setting_nonce ch_ctx = #ui_setting_input ch_ctx
execute if score #ui_setting_input ch_ctx matches ..99999999 run scoreboard players operation #ui_setting_nonce ch_ctx /= #ui_10 ch_ctx
execute if score #ui_setting_input ch_ctx matches 100000000.. run scoreboard players operation #ui_setting_nonce ch_ctx /= #ui_100 ch_ctx
scoreboard players operation #ui_setting_field ch_ctx = #ui_setting_nonce ch_ctx
scoreboard players operation #ui_setting_field ch_ctx %= #ui_10 ch_ctx
scoreboard players operation #ui_setting_nonce ch_ctx /= #ui_10 ch_ctx
execute unless score #ui_setting_nonce ch_ctx = @s ch_setnonce run return run function chess:settings/invalid
scoreboard players operation #ui_setting_value ch_ctx = #ui_setting_input ch_ctx
execute if score #ui_setting_input ch_ctx matches ..99999999 run scoreboard players operation #ui_setting_value ch_ctx %= #ui_10 ch_ctx
execute if score #ui_setting_input ch_ctx matches 100000000.. run scoreboard players operation #ui_setting_value ch_ctx %= #ui_100 ch_ctx
tag @e[tag=ch.setting_table] remove ch.setting_table
scoreboard players operation #ui_setting_table ch_ctx = @s ch_set_table
scoreboard players operation #ui_setting_epoch ch_ctx = @s ch_setepoch
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=12,ct_state=0}] if score @s ct_id = #ui_setting_table ch_ctx if score @s ch_epoch = #ui_setting_epoch ch_ctx run tag @s add ch.setting_table
execute unless entity @e[tag=ch.setting_table,limit=1] run return run function chess:settings/invalid
execute unless score #ui_setting_field ch_ctx matches 0..7 run return run function chess:settings/invalid
execute if score #ui_setting_field ch_ctx matches 0 unless score #ui_setting_value ch_ctx matches 0 run return run function chess:settings/invalid
execute if score #ui_setting_field ch_ctx matches 1 unless score #ui_setting_value ch_ctx matches 0..4 run return run function chess:settings/invalid
execute if score #ui_setting_field ch_ctx matches 2 unless score #ui_setting_value ch_ctx matches 0..3 run return run function chess:settings/invalid
execute if score #ui_setting_field ch_ctx matches 3..4 unless score #ui_setting_value ch_ctx matches 0..1 run return run function chess:settings/invalid
execute if score #ui_setting_field ch_ctx matches 5 unless score #ui_setting_value ch_ctx matches 0..30 run return run function chess:settings/invalid
execute if score #ui_setting_field ch_ctx matches 6 unless score #ui_setting_value ch_ctx matches 1..3 run return run function chess:settings/invalid
execute if score #ui_setting_field ch_ctx matches 7 unless score #ui_setting_value ch_ctx matches 0..1 run return run function chess:settings/invalid
scoreboard players operation #ui_setting_mod ch_ctx = #ui_setting_value ch_ctx
scoreboard players set #ui_5 ch_ctx 5
scoreboard players operation #ui_setting_mod ch_ctx %= #ui_5 ch_ctx
execute if score #ui_setting_field ch_ctx matches 5 unless score #ui_setting_mod ch_ctx matches 0 run return run function chess:settings/invalid
scoreboard players set @s ch_setnonce 0
execute if score #ui_setting_field ch_ctx matches 0 run return run function chess:settings/close
execute if score #ui_setting_field ch_ctx matches 1 run scoreboard players operation @e[tag=ch.setting_table,limit=1] ch_board = #ui_setting_value ch_ctx
execute if score #ui_setting_field ch_ctx matches 2 run scoreboard players operation @e[tag=ch.setting_table,limit=1] ch_palette = #ui_setting_value ch_ctx
execute if score #ui_setting_field ch_ctx matches 3 run scoreboard players operation @e[tag=ch.setting_table,limit=1] ch_orient = #ui_setting_value ch_ctx
execute if score #ui_setting_field ch_ctx matches 4 run scoreboard players operation @e[tag=ch.setting_table,limit=1] ch_first = #ui_setting_value ch_ctx
execute if score #ui_setting_field ch_ctx matches 5 run scoreboard players operation @e[tag=ch.setting_table,limit=1] ch_time = #ui_setting_value ch_ctx
execute if score #ui_setting_field ch_ctx matches 6 run scoreboard players operation @e[tag=ch.setting_table,limit=1] ch_level = #ui_setting_value ch_ctx
execute if score #ui_setting_field ch_ctx matches 7 run scoreboard players operation @e[tag=ch.setting_table,limit=1] ch_hints = #ui_setting_value ch_ctx
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
# 外观立即重建本桌预览；一次刷新后绑定新epoch，其他旧窗口也随之失效。
execute if score #ui_setting_field ch_ctx matches 1..3 as @e[tag=ch.setting_table,limit=1] at @s run function chess:game/preview
execute as @e[tag=ch.setting_table,limit=1] at @s run function chess:settings/open
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @e[tag=ch.setting_table] remove ch.setting_table
