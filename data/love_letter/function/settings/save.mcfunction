scoreboard players operation @s ll_setinput = @s ll_settings
scoreboard players reset @s ll_settings
execute unless entity @s[tag=ct.player] run return run function love_letter:settings/invalid
execute unless score @s ll_setload = #ui_load ll_ctx run return run function love_letter:settings/invalid
execute unless score @s ct_id = @s ll_settable run return run function love_letter:settings/invalid
scoreboard players set #setting_factor ll_ctx 100000
scoreboard players operation #setting_nonce ll_ctx = @s ll_setinput
scoreboard players operation #setting_nonce ll_ctx /= #setting_factor ll_ctx
execute unless score #setting_nonce ll_ctx = @s ll_setnonce run return run function love_letter:settings/invalid
scoreboard players set @s ll_setnonce 0
scoreboard players operation #setting_input ll_ctx = @s ll_setinput
scoreboard players operation #setting_input ll_ctx %= #setting_factor ll_ctx
scoreboard players set #setting_factor ll_ctx 1000
scoreboard players operation #setting_field ll_ctx = #setting_input ll_ctx
scoreboard players operation #setting_field ll_ctx /= #setting_factor ll_ctx
scoreboard players operation #setting_value ll_ctx = #setting_input ll_ctx
scoreboard players operation #setting_value ll_ctx %= #setting_factor ll_ctx
execute unless score #setting_field ll_ctx matches 0..4 run return run function love_letter:settings/invalid
execute if score #setting_field ll_ctx matches 0 unless score #setting_value ll_ctx matches 0 run return run function love_letter:settings/invalid
execute if score #setting_field ll_ctx matches 1 unless score #setting_value ll_ctx matches 0..1 run return run function love_letter:settings/invalid
execute if score #setting_field ll_ctx matches 2 unless score #setting_value ll_ctx matches 0..10 run return run function love_letter:settings/invalid
execute if score #setting_field ll_ctx matches 3 unless score #setting_value ll_ctx matches 0..1 run return run function love_letter:settings/invalid
execute if score #setting_field ll_ctx matches 4 unless score #setting_value ll_ctx matches 0 unless score #setting_value ll_ctx matches 30 unless score #setting_value ll_ctx matches 60 unless score #setting_value ll_ctx matches 90 unless score #setting_value ll_ctx matches 120 run return run function love_letter:settings/invalid
tag @e[tag=ll.setting_table] remove ll.setting_table
scoreboard players operation #setting_table ll_ctx = @s ll_settable
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=17,ct_state=0}] if score @s ct_id = #setting_table ll_ctx run tag @s add ll.setting_table
execute unless entity @e[tag=ll.setting_table,limit=1] run return run function love_letter:settings/invalid
execute if score #setting_field ll_ctx matches 0 run return run function love_letter:settings/close
execute if score #setting_field ll_ctx matches 1 run scoreboard players operation @e[tag=ll.setting_table,limit=1] ll_first_setting = #setting_value ll_ctx
execute if score #setting_field ll_ctx matches 2 run scoreboard players operation @e[tag=ll.setting_table,limit=1] ll_goal_setting = #setting_value ll_ctx
execute if score #setting_field ll_ctx matches 3 run scoreboard players operation @e[tag=ll.setting_table,limit=1] ll_discards_setting = #setting_value ll_ctx
execute if score #setting_field ll_ctx matches 4 run scoreboard players operation @e[tag=ll.setting_table,limit=1] ll_time_setting = #setting_value ll_ctx
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
execute as @e[tag=ll.setting_table,limit=1] at @s run function love_letter:settings/open
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @e[tag=ll.setting_table] remove ll.setting_table
