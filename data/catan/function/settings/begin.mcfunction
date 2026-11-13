execute if score #settings_serial ca_ctx matches 99999.. run scoreboard players add #settings_load ca_ctx 1
execute unless score #settings_serial ca_ctx matches 9999..99998 run scoreboard players set #settings_serial ca_ctx 9999
scoreboard players add #settings_serial ca_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ca_setnonce = #settings_serial ca_ctx
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ca_setload = #settings_load ca_ctx
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ca_settable = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ca_setepoch = @s ca_epoch
scoreboard players set @a[tag=ct.settings_actor,tag=ct.player,limit=1] ca_settings 0
scoreboard players enable @a[tag=ct.settings_actor,tag=ct.player,limit=1] ca_settings
scoreboard players set #set_scale ca_ctx 10000
scoreboard players operation #set_base ca_ctx = #settings_serial ca_ctx
scoreboard players operation #set_base ca_ctx *= #set_scale ca_ctx
execute store result storage catan:settings close int 1 run scoreboard players get #set_base ca_ctx
execute store result storage catan:settings layout int 1 run scoreboard players get @s ca_layout
execute store result storage catan:settings orient int 1 run scoreboard players get @s ca_orient
execute store result storage catan:settings first int 1 run scoreboard players get @s ca_first
execute store result storage catan:settings music int 1 run scoreboard players get @s ca_music
