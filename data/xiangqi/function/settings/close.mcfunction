function xiangqi:settings/clear_session
dialog clear @s
tag @s remove ct.settings_actor
tag @e[tag=xq.setting_table] remove xq.setting_table
