function magical_athlete:settings/clear_session
dialog clear @s
tag @s remove ct.settings_actor
tag @e[tag=ma.setting_table] remove ma.setting_table
