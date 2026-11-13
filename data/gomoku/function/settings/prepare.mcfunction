scoreboard players set #ui_10000 gm_ctx 10000
scoreboard players operation #ui_setting_base gm_ctx = #setting_serial gm_ctx
scoreboard players operation #ui_setting_base gm_ctx *= #ui_10000 gm_ctx
execute store result storage gomoku:settings close int 1 run scoreboard players get #ui_setting_base gm_ctx
execute store result storage gomoku:settings board int 1 run scoreboard players get @s gm_board
execute store result storage gomoku:settings palette int 1 run scoreboard players get @s gm_palette
execute store result storage gomoku:settings orient int 1 run scoreboard players get @s gm_orient
execute store result storage gomoku:settings first int 1 run scoreboard players get @s gm_first
execute store result storage gomoku:settings time int 1 run scoreboard players get @s gm_time
execute store result storage gomoku:settings level int 1 run scoreboard players get @s gm_level
execute store result storage gomoku:settings size int 1 run scoreboard players get @s gm_size
execute store result storage gomoku:settings mark int 1 run scoreboard players get @s gm_mark
execute store result storage gomoku:settings coords int 1 run scoreboard players get @s gm_coords
execute store result storage gomoku:settings confirm int 1 run scoreboard players get @s gm_confirm
