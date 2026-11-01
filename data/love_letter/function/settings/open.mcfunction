function love_letter:game/init_table
execute unless entity @a[tag=ct.settings_actor,tag=ct.player,limit=1] run return 0
execute unless score @s ct_game matches 17 run return 0
execute unless score @s ct_state matches 0 run return 0
scoreboard players operation #setting_table ll_ctx = @s ct_id
execute unless score @a[tag=ct.settings_actor,limit=1] ct_id = #setting_table ll_ctx run return 0
scoreboard players add #setting_serial ll_ctx 1
execute if score #setting_serial ll_ctx matches 20001.. run scoreboard players add #ui_load ll_ctx 1
execute if score #setting_serial ll_ctx matches 20001.. run scoreboard players set #setting_serial ll_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ll_setnonce = #setting_serial ll_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ll_setload = #ui_load ll_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ll_settable = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] ll_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] ll_settings
scoreboard players set #setting_factor ll_ctx 100000
scoreboard players operation #setting_base ll_ctx = #setting_serial ll_ctx
scoreboard players operation #setting_base ll_ctx *= #setting_factor ll_ctx
execute store result storage love_letter:settings close int 1 run scoreboard players get #setting_base ll_ctx
execute store result storage love_letter:settings first int 1 run scoreboard players get @s ll_first_setting
execute store result storage love_letter:settings goal int 1 run scoreboard players get @s ll_goal_setting
execute store result storage love_letter:settings discards int 1 run scoreboard players get @s ll_discards_setting
execute store result storage love_letter:settings time int 1 run scoreboard players get @s ll_time_setting
function love_letter:settings/root
