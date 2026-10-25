function abraca:settings/init
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ab_set_table = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] ab_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] ab_settings
execute store result storage abraca:settings initial int 1 run scoreboard players get @s ab_goal
data modify storage abraca:settings goal set value "$(goal)"
function abraca:settings/show with storage abraca:settings
