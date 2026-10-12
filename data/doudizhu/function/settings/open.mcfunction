function doudizhu:game/init_table
execute store result storage doudizhu:settings initial int 1 run scoreboard players get @s dd_max
scoreboard players operation @a[tag=ct.settings_actor,limit=1] dd_set_table = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] dd_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] dd_settings
# 保留给对话框提交时展开的输入占位符。
data modify storage doudizhu:settings rounds set value "$(rounds)"
function doudizhu:settings/show with storage doudizhu:settings
