scoreboard players operation @s gd_ui_key = @s gd_strength
scoreboard players set #ui_key_factor gd_ctx 108
scoreboard players operation @s gd_ui_key *= #ui_key_factor gd_ctx
scoreboard players operation @s gd_ui_key += @s gd_id
