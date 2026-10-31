execute if score #setting_serial ac_ctx matches 99999.. run scoreboard players add #ui_load ac_ctx 1
execute unless score #setting_serial ac_ctx matches 9999..99998 run scoreboard players set #setting_serial ac_ctx 9999
scoreboard players add #setting_serial ac_ctx 1
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ac_setnonce = #setting_serial ac_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ac_nonce = #ui_load ac_ctx
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ac_set_table = @s ct_id
scoreboard players operation @a[tag=ct.settings_actor,limit=1] ac_setepoch = @s ac_epoch
scoreboard players set @a[tag=ct.settings_actor,limit=1] ac_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] ac_settings
scoreboard players set #setting_scale ac_ctx 10000
scoreboard players operation #setting_base ac_ctx = #setting_serial ac_ctx
scoreboard players operation #setting_base ac_ctx *= #setting_scale ac_ctx
execute store result storage aeroplane_chess:settings close int 1 run scoreboard players get #setting_base ac_ctx
execute store result storage aeroplane_chess:settings takeoff int 1 run scoreboard players get @s ac_takeoff
execute store result storage aeroplane_chess:settings extra int 1 run scoreboard players get @s ac_extra
execute store result storage aeroplane_chess:settings triple int 1 run scoreboard players get @s ac_triple
execute store result storage aeroplane_chess:settings jump int 1 run scoreboard players get @s ac_jump
execute store result storage aeroplane_chess:settings fly int 1 run scoreboard players get @s ac_fly
execute store result storage aeroplane_chess:settings finish int 1 run scoreboard players get @s ac_finish
execute store result storage aeroplane_chess:settings palette int 1 run scoreboard players get @s ac_palette
execute store result storage aeroplane_chess:settings orient int 1 run scoreboard players get @s ac_orient
execute store result storage aeroplane_chess:settings first int 1 run scoreboard players get @s ac_first
execute store result storage aeroplane_chess:settings speed int 1 run scoreboard players get @s ac_speed
execute store result storage aeroplane_chess:settings hints int 1 run scoreboard players get @s ac_hints
execute store result storage aeroplane_chess:settings fill int 1 run scoreboard players get @s ac_fill
execute store result storage aeroplane_chess:settings ranking int 1 run scoreboard players get @s ac_ranking
execute store result storage aeroplane_chess:settings assign int 1 run scoreboard players get @s ac_assign
