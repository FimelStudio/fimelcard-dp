function splendor:settings/clear_session
dialog clear @s
tag @s remove ct.settings_actor
tag @e[tag=sp.setting_table] remove sp.setting_table
