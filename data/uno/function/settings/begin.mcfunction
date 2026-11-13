# nonce*100000 + 字段*1000 + 数值；字段0退出、1模式、2局数、3目标分/100、4自动喊、5质疑、6秒数。
# nonce轮回时同时推进重载代数，避免极旧窗口在序列循环后重新有效。
scoreboard players add #setting_serial un_ctx 1
execute if score #setting_serial un_ctx matches 20001.. run scoreboard players add #ui_load un_ctx 1
execute if score #setting_serial un_ctx matches 20001.. run scoreboard players set #setting_serial un_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] un_setnonce = #setting_serial un_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] un_nonce = #ui_load un_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] un_set_table = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] un_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] un_settings
function uno:settings/prepare
