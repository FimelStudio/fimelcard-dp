scoreboard players set #set_input ca_ctx 0
scoreboard players operation #set_input ca_ctx = @s ca_settings
scoreboard players reset @s ca_settings
execute unless entity @s[tag=ct.player] run return run function catan:settings/invalid
execute unless score @s ca_setload = #settings_load ca_ctx run return run function catan:settings/invalid
execute unless score @s ct_id = @s ca_settable run return run function catan:settings/invalid
execute unless score #set_input ca_ctx matches 100000000..999990401 run return run function catan:settings/invalid
scoreboard players set #set_scale ca_ctx 10000
scoreboard players set #set_hundred ca_ctx 100
scoreboard players operation #set_nonce ca_ctx = #set_input ca_ctx
scoreboard players operation #set_nonce ca_ctx /= #set_scale ca_ctx
execute unless score #set_nonce ca_ctx = @s ca_setnonce run return run function catan:settings/invalid
scoreboard players operation #set_field ca_ctx = #set_input ca_ctx
scoreboard players operation #set_field ca_ctx %= #set_scale ca_ctx
scoreboard players operation #set_field ca_ctx /= #set_hundred ca_ctx
scoreboard players operation #set_value ca_ctx = #set_input ca_ctx
scoreboard players operation #set_value ca_ctx %= #set_hundred ca_ctx
scoreboard players operation #set_table ca_ctx = @s ca_settable
scoreboard players operation #set_epoch ca_ctx = @s ca_setepoch
tag @e[tag=ca.setting_table] remove ca.setting_table
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=21,ct_state=0}] if score @s ct_id = #set_table ca_ctx if score @s ca_epoch = #set_epoch ca_ctx run tag @s add ca.setting_table
execute unless entity @e[tag=ca.setting_table,limit=1] run return run function catan:settings/invalid
execute unless score #set_field ca_ctx matches 0..4 run return run function catan:settings/invalid
execute if score #set_field ca_ctx matches 0 unless score #set_value ca_ctx matches 0 run return run function catan:settings/invalid
execute if score #set_field ca_ctx matches 1..4 unless score #set_value ca_ctx matches 0..1 run return run function catan:settings/invalid
scoreboard players reset @s ca_setnonce
execute if score #set_field ca_ctx matches 0 run return run function catan:settings/close
execute if score #set_field ca_ctx matches 1 run scoreboard players operation @e[tag=ca.setting_table,limit=1] ca_layout = #set_value ca_ctx
execute if score #set_field ca_ctx matches 2 run scoreboard players operation @e[tag=ca.setting_table,limit=1] ca_orient = #set_value ca_ctx
execute if score #set_field ca_ctx matches 3 run scoreboard players operation @e[tag=ca.setting_table,limit=1] ca_first = #set_value ca_ctx
execute if score #set_field ca_ctx matches 4 run scoreboard players operation @e[tag=ca.setting_table,limit=1] ca_music = #set_value ca_ctx
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
execute if score #set_field ca_ctx matches 1..2 as @e[tag=ca.setting_table,limit=1] at @s run function catan:game/preview
execute as @e[tag=ca.setting_table,limit=1] at @s run function catan:settings/open
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @e[tag=ca.setting_table] remove ca.setting_table
