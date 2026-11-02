execute if score #settings_serial sp_ctx matches 99999.. run scoreboard players add #settings_load sp_ctx 1
execute unless score #settings_serial sp_ctx matches 9999..99998 run scoreboard players set #settings_serial sp_ctx 9999
scoreboard players add #settings_serial sp_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_setnonce = #settings_serial sp_ctx
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_setload = #settings_load sp_ctx
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_settable = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_setepoch = @s sp_epoch
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_setseat = @a[tag=ct.settings_actor,tag=ct.player,limit=1] ct_seat
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_setlayout = @s ct_ch_epoch
scoreboard players set @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_settings 0
scoreboard players enable @a[tag=ct.settings_actor,tag=ct.player,limit=1] sp_settings
scoreboard players operation #set_base sp_ctx = #settings_serial sp_ctx
scoreboard players operation #set_base sp_ctx *= #factor sp_ctx
execute store result storage splendor:settings close int 1 run scoreboard players get #set_base sp_ctx
execute store result storage splendor:settings first int 1 run scoreboard players get @s sp_first
execute store result storage splendor:settings music int 1 run scoreboard players get @s sp_music
