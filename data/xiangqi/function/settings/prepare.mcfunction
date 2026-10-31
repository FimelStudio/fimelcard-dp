scoreboard players set #ui_1000 xq_ctx 1000
scoreboard players operation #ui_setting_base xq_ctx = #setting_serial xq_ctx
scoreboard players operation #ui_setting_base xq_ctx *= #ui_1000 xq_ctx
execute store result storage xiangqi:settings close int 1 run scoreboard players get #ui_setting_base xq_ctx
execute store result storage xiangqi:settings board int 1 run scoreboard players get @s xq_board
execute store result storage xiangqi:settings palette int 1 run scoreboard players get @s xq_palette
execute store result storage xiangqi:settings orient int 1 run scoreboard players get @s xq_orient
execute store result storage xiangqi:settings first int 1 run scoreboard players get @s xq_first
execute store result storage xiangqi:settings time int 1 run scoreboard players get @s xq_time
execute store result storage xiangqi:settings level int 1 run scoreboard players get @s xq_level
execute store result storage xiangqi:settings hints int 1 run scoreboard players get @s xq_hints
