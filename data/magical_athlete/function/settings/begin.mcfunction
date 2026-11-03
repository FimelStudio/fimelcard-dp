execute if score #settings_serial ma_ctx matches 99999.. run scoreboard players add #settings_load ma_ctx 1
execute unless score #settings_serial ma_ctx matches 9999..99998 run scoreboard players set #settings_serial ma_ctx 9999
scoreboard players add #settings_serial ma_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_setnonce = #settings_serial ma_ctx
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_setload = #settings_load ma_ctx
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_settable = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_setepoch = @s ma_epoch
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_setseat = @a[tag=ct.settings_actor,tag=ct.player,limit=1] ct_seat
scoreboard players operation @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_setlayout = @s ct_ch_epoch
scoreboard players set @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_settings 0
scoreboard players enable @a[tag=ct.settings_actor,tag=ct.player,limit=1] ma_settings
scoreboard players operation #set_base ma_ctx = #settings_serial ma_ctx
scoreboard players operation #set_base ma_ctx *= #factor ma_ctx
execute store result storage magical_athlete:settings close int 1 run scoreboard players get #set_base ma_ctx
execute store result storage magical_athlete:settings draft int 1 run scoreboard players get @s ma_draft
execute store result storage magical_athlete:settings track int 1 run scoreboard players get @s ma_track
execute store result storage magical_athlete:settings music int 1 run scoreboard players get @s ma_music
execute store result storage magical_athlete:settings speed int 1 run scoreboard players get @s ma_speed
execute store result storage magical_athlete:settings orient int 1 run scoreboard players get @s ma_orient
