stopsound @s record splendor:bgm
playsound splendor:bgm record @s ~ ~ ~ 0.18 1 0
scoreboard players set @s sp_bgm_on 1
scoreboard players operation @s sp_bgm_table = #sound_table sp_ctx
