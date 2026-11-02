# 六位nonce、字段一位、数值两位，最大999999801，小于有符号整数上限。
execute if score #setting_serial xq_ctx matches 999999.. run scoreboard players add #ui_load xq_ctx 1
execute unless score #setting_serial xq_ctx matches 99999..999998 run scoreboard players set #setting_serial xq_ctx 99999
scoreboard players add #setting_serial xq_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] xq_setnonce = #setting_serial xq_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] xq_nonce = #ui_load xq_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] xq_set_table = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,limit=1] xq_setepoch = @s xq_epoch
scoreboard players set @a[tag=ct.settings_actor,limit=1] xq_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] xq_settings
function xiangqi:settings/prepare
