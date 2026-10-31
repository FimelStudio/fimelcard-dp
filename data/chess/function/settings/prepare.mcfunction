scoreboard players set #ui_1000 ch_ctx 1000
scoreboard players operation #ui_setting_base ch_ctx = #setting_serial ch_ctx
scoreboard players operation #ui_setting_base ch_ctx *= #ui_1000 ch_ctx
execute store result storage chess:settings close int 1 run scoreboard players get #ui_setting_base ch_ctx
execute store result storage chess:settings board int 1 run scoreboard players get @s ch_board
execute store result storage chess:settings palette int 1 run scoreboard players get @s ch_palette
execute store result storage chess:settings orient int 1 run scoreboard players get @s ch_orient
execute store result storage chess:settings first int 1 run scoreboard players get @s ch_first
execute store result storage chess:settings time int 1 run scoreboard players get @s ch_time
execute store result storage chess:settings level int 1 run scoreboard players get @s ch_level
execute store result storage chess:settings hints int 1 run scoreboard players get @s ch_hints
