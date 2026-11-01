scoreboard players operation #ui_setting_input xq_ctx = @s xq_settings
scoreboard players reset @s xq_settings
execute unless entity @s[tag=ct.player] run return run function xiangqi:settings/invalid
execute unless score @s xq_nonce = #ui_load xq_ctx run return run function xiangqi:settings/invalid
execute unless score @s ct_id = @s xq_set_table run return run function xiangqi:settings/invalid
execute unless score #ui_setting_input xq_ctx matches 10000000..999999999 run return run function xiangqi:settings/invalid
scoreboard players set #ui_10 xq_ctx 10
scoreboard players set #ui_100 xq_ctx 100
scoreboard players operation #ui_setting_nonce xq_ctx = #ui_setting_input xq_ctx
execute if score #ui_setting_input xq_ctx matches ..99999999 run scoreboard players operation #ui_setting_nonce xq_ctx /= #ui_10 xq_ctx
execute if score #ui_setting_input xq_ctx matches 100000000.. run scoreboard players operation #ui_setting_nonce xq_ctx /= #ui_100 xq_ctx
scoreboard players operation #ui_setting_field xq_ctx = #ui_setting_nonce xq_ctx
scoreboard players operation #ui_setting_field xq_ctx %= #ui_10 xq_ctx
scoreboard players operation #ui_setting_nonce xq_ctx /= #ui_10 xq_ctx
execute unless score #ui_setting_nonce xq_ctx = @s xq_setnonce run return run function xiangqi:settings/invalid
scoreboard players operation #ui_setting_value xq_ctx = #ui_setting_input xq_ctx
execute if score #ui_setting_input xq_ctx matches ..99999999 run scoreboard players operation #ui_setting_value xq_ctx %= #ui_10 xq_ctx
execute if score #ui_setting_input xq_ctx matches 100000000.. run scoreboard players operation #ui_setting_value xq_ctx %= #ui_100 xq_ctx
tag @e[tag=xq.setting_table] remove xq.setting_table
scoreboard players operation #ui_setting_table xq_ctx = @s xq_set_table
scoreboard players operation #ui_setting_epoch xq_ctx = @s xq_setepoch
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=13,ct_state=0}] if score @s ct_id = #ui_setting_table xq_ctx if score @s xq_epoch = #ui_setting_epoch xq_ctx run tag @s add xq.setting_table
execute unless entity @e[tag=xq.setting_table,limit=1] run return run function xiangqi:settings/invalid
execute unless score #ui_setting_field xq_ctx matches 0..8 run return run function xiangqi:settings/invalid
execute if score #ui_setting_field xq_ctx matches 0 unless score #ui_setting_value xq_ctx matches 0 run return run function xiangqi:settings/invalid
execute if score #ui_setting_field xq_ctx matches 1..2 unless score #ui_setting_value xq_ctx matches 0..1 run return run function xiangqi:settings/invalid
execute if score #ui_setting_field xq_ctx matches 3..4 unless score #ui_setting_value xq_ctx matches 0..1 run return run function xiangqi:settings/invalid
execute if score #ui_setting_field xq_ctx matches 5 unless score #ui_setting_value xq_ctx matches 0..30 run return run function xiangqi:settings/invalid
execute if score #ui_setting_field xq_ctx matches 6 unless score #ui_setting_value xq_ctx matches 1..3 run return run function xiangqi:settings/invalid
execute if score #ui_setting_field xq_ctx matches 7 unless score #ui_setting_value xq_ctx matches 0..1 run return run function xiangqi:settings/invalid
execute if score #ui_setting_field xq_ctx matches 8 unless score #ui_setting_value xq_ctx matches 0..1 run return run function xiangqi:settings/invalid
scoreboard players operation #ui_setting_mod xq_ctx = #ui_setting_value xq_ctx
scoreboard players set #ui_5 xq_ctx 5
scoreboard players operation #ui_setting_mod xq_ctx %= #ui_5 xq_ctx
execute if score #ui_setting_field xq_ctx matches 5 unless score #ui_setting_mod xq_ctx matches 0 run return run function xiangqi:settings/invalid
scoreboard players set @s xq_setnonce 0
execute if score #ui_setting_field xq_ctx matches 0 run return run function xiangqi:settings/close
execute if score #ui_setting_field xq_ctx matches 1 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_board = #ui_setting_value xq_ctx
execute if score #ui_setting_field xq_ctx matches 2 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_palette = #ui_setting_value xq_ctx
execute if score #ui_setting_field xq_ctx matches 3 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_orient = #ui_setting_value xq_ctx
execute if score #ui_setting_field xq_ctx matches 4 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_first = #ui_setting_value xq_ctx
execute if score #ui_setting_field xq_ctx matches 5 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_time = #ui_setting_value xq_ctx
execute if score #ui_setting_field xq_ctx matches 6 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_level = #ui_setting_value xq_ctx
execute if score #ui_setting_field xq_ctx matches 7 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_hints = #ui_setting_value xq_ctx
execute if score #ui_setting_field xq_ctx matches 8 run scoreboard players operation @e[tag=xq.setting_table,limit=1] xq_variant = #ui_setting_value xq_ctx
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
# 外观立即重建本桌预览；一次刷新后绑定新epoch，其他旧窗口也随之失效。
execute if score #ui_setting_field xq_ctx matches 1..3 as @e[tag=xq.setting_table,limit=1] at @s run function xiangqi:game/preview
# 切换玩法要重摆初始棋面；外观设置仍可查看保留的终局。
execute if score #ui_setting_field xq_ctx matches 8 run data remove entity @e[tag=xq.setting_table,limit=1] data.xiangqi.review
execute if score #ui_setting_field xq_ctx matches 8 as @e[tag=xq.setting_table,limit=1] at @s run function xiangqi:game/preview
execute as @e[tag=xq.setting_table,limit=1] at @s run function xiangqi:settings/open
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @e[tag=xq.setting_table] remove xq.setting_table
