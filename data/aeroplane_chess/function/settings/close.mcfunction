function aeroplane_chess:settings/clear_session
dialog clear @s
tag @s remove ct.settings_actor
tag @e[tag=ac.setting_table] remove ac.setting_table
