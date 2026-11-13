scoreboard players operation @s gd_hud_key = @s gd_strength
scoreboard players set #hud_factor gd_ctx 108
scoreboard players operation @s gd_hud_key *= #hud_factor gd_ctx
scoreboard players operation @s gd_hud_key += @s gd_id
