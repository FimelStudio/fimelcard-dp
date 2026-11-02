function catan:settings/clear_session
dialog clear @s
tag @s remove ct.settings_actor
tag @e[tag=ca.setting_table] remove ca.setting_table
