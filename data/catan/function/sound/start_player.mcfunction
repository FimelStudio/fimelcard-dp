stopsound @s record card:catan.bgm
playsound card:catan.bgm record @s ~ ~ ~ 0.20 1 0
scoreboard players set @s ca_bgm_on 1
scoreboard players operation @s ca_bgm_table = #sound_table ca_ctx
