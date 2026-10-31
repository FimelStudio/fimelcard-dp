# 控制器上的六项持久设置是唯一真值；storage只负责本次窗口的组件构造。
scoreboard players set #ui_100000 un_ctx 100000
scoreboard players operation #ui_setting_base un_ctx = #setting_serial un_ctx
scoreboard players operation #ui_setting_base un_ctx *= #ui_100000 un_ctx
execute store result storage uno:settings close int 1 run scoreboard players get #ui_setting_base un_ctx
execute store result storage uno:settings mode int 1 run scoreboard players get @s un_mode
execute store result storage uno:settings rounds int 1 run scoreboard players get @s un_rounds
execute store result storage uno:settings target int 1 run scoreboard players get @s un_target
execute store result storage uno:settings auto int 1 run scoreboard players get @s un_auto
execute store result storage uno:settings challenge int 1 run scoreboard players get @s un_challenge
scoreboard players operation #ui_sec un_ctx = @s un_window
scoreboard players set #ui_20 un_ctx 20
scoreboard players operation #ui_sec un_ctx /= #ui_20 un_ctx
execute store result storage uno:settings seconds int 1 run scoreboard players get #ui_sec un_ctx
scoreboard players operation #ui_targethundreds un_ctx = @s un_target
scoreboard players set #ui_100 un_ctx 100
scoreboard players operation #ui_targethundreds un_ctx /= #ui_100 un_ctx
execute store result storage uno:settings target_hundreds int 1 run scoreboard players get #ui_targethundreds un_ctx
