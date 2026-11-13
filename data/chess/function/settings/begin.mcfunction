# 六位nonce、字段一位、数值两位，最大999999701，小于有符号整数上限。
execute if score #setting_serial ch_ctx matches 999999.. run scoreboard players add #ui_load ch_ctx 1
execute unless score #setting_serial ch_ctx matches 99999..999998 run scoreboard players set #setting_serial ch_ctx 99999
scoreboard players add #setting_serial ch_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ch_setnonce = #setting_serial ch_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ch_nonce = #ui_load ch_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ch_set_table = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ch_setepoch = @s ch_epoch
scoreboard players set @a[tag=ct.settings_actor,limit=1] ch_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] ch_settings
function chess:settings/prepare
