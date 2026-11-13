# 六位nonce、字段一位、数值两位，最大999999701，小于有符号整数上限。
execute if score #setting_serial gm_ctx matches 99999.. run scoreboard players add #ui_load gm_ctx 1
execute unless score #setting_serial gm_ctx matches 9999..99998 run scoreboard players set #setting_serial gm_ctx 9999
scoreboard players add #setting_serial gm_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] gm_setnonce = #setting_serial gm_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] gm_nonce = #ui_load gm_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] gm_set_table = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,limit=1] gm_setepoch = @s gm_epoch
scoreboard players set @a[tag=ct.settings_actor,limit=1] gm_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] gm_settings
function gomoku:settings/prepare
