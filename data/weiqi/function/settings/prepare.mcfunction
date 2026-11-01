scoreboard players set #ui_10000 go_ctx 10000
scoreboard players operation #ui_setting_base go_ctx = #setting_serial go_ctx
scoreboard players operation #ui_setting_base go_ctx *= #ui_10000 go_ctx
execute store result storage weiqi:settings close int 1 run scoreboard players get #ui_setting_base go_ctx
execute store result storage weiqi:settings size int 1 run scoreboard players get @s go_size
execute store result storage weiqi:settings board int 1 run scoreboard players get @s go_board
execute store result storage weiqi:settings orient int 1 run scoreboard players get @s go_orient
execute store result storage weiqi:settings first int 1 run scoreboard players get @s go_first
execute store result storage weiqi:settings time int 1 run scoreboard players get @s go_time
execute store result storage weiqi:settings komi int 1 run scoreboard players get @s go_komi
execute store result storage weiqi:settings level int 1 run scoreboard players get @s go_level
execute store result storage weiqi:settings coords int 1 run scoreboard players get @s go_coords
execute store result storage weiqi:settings mark int 1 run scoreboard players get @s go_mark
execute store result storage weiqi:settings confirm int 1 run scoreboard players get @s go_confirm
execute store result storage weiqi:settings estimate int 1 run scoreboard players get @s go_estimate
