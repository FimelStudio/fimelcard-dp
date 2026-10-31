function chess:settings/clear_session
dialog clear @s
tag @s remove ct.settings_actor
tag @e[tag=ch.setting_table] remove ch.setting_table
