# 控制器入口；清本桌所有设置会话，不影响邻桌或持久规则值。
scoreboard players operation #ui_setting_table un_ctx = @s ct_id
execute as @a if score @s un_set_table = #ui_setting_table un_ctx run function uno:settings/clear_session
