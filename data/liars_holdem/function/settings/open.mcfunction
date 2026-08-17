# 校正当前牌桌设置，并把初始值交给Dialog宏
function liars_holdem:game/init_table
execute store result storage liars_holdem:settings gun_time int 1 run scoreboard players get @s lh_gun_time

scoreboard players operation @a[tag=ct.settings_actor,limit=1] lh_set_table = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] lh_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] lh_settings
function liars_holdem:settings/open_dialog with storage liars_holdem:settings
