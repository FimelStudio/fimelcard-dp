function weiqi:settings/clear_session
dialog clear @s
tag @s remove ct.settings_actor
tag @e[tag=go.setting_table] remove go.setting_table
