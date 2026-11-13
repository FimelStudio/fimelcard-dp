function gomoku:settings/clear_session
dialog clear @s
tag @s remove ct.settings_actor
tag @e[tag=gm.setting_table] remove gm.setting_table
