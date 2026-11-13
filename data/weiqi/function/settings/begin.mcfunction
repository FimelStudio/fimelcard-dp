# 五位nonce×10000加字段和值，最大999991180，低于有符号整数上限。
execute if score #setting_serial go_ctx matches 99999.. run scoreboard players add #ui_load go_ctx 1
execute unless score #setting_serial go_ctx matches 9999..99998 run scoreboard players set #setting_serial go_ctx 9999
scoreboard players add #setting_serial go_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] go_setnonce = #setting_serial go_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] go_nonce = #ui_load go_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] go_set_table = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,limit=1] go_setepoch = @s go_epoch
scoreboard players set @a[tag=ct.settings_actor,limit=1] go_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] go_settings
function weiqi:settings/prepare
