function guandan:game/init_table
execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 18 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #setting_table gd_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,limit=1] ct_id = #setting_table gd_ctx run return 0
scoreboard players add #setting_serial gd_ctx 1
execute if score #setting_serial gd_ctx matches 20001.. run scoreboard players add #ui_load gd_ctx 1
execute if score #setting_serial gd_ctx matches 20001.. run scoreboard players set #setting_serial gd_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] gd_setnonce = #setting_serial gd_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] gd_setload = #ui_load gd_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] gd_settable = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] gd_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] gd_settings
scoreboard players set #setting_factor gd_ctx 100000
scoreboard players operation #setting_base gd_ctx = #setting_serial gd_ctx
scoreboard players operation #setting_base gd_ctx *= #setting_factor gd_ctx
execute store result storage guandan:settings close int 1 run scoreboard players get #setting_base gd_ctx
execute store result storage guandan:settings pair int 1 run scoreboard players get @s gd_pair
execute store result storage guandan:settings startlevel int 1 run scoreboard players get @s gd_startlevel
execute store result storage guandan:settings mode int 1 run scoreboard players get @s gd_mode
execute store result storage guandan:settings rounds int 1 run scoreboard players get @s gd_rounds
execute store result storage guandan:settings show int 1 run scoreboard players get @s gd_show
execute store result storage guandan:settings limit int 1 run scoreboard players get @s gd_limit
function guandan:settings/root
