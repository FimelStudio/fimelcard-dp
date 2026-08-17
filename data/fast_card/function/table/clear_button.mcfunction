# 只清除当前Fast Card实例的抢按按钮外观和点击体，不影响牌盒或其他桌面实体
scoreboard players operation #ctx_id fc_ctx = @s fc_id
execute as @e[tag=fc.button,distance=..2] if score @s fc_id = #ctx_id fc_ctx run kill @s
# 兼容重载前尚未拥有fc.button_display标签的旧按钮；现有Fast Card只有按钮使用block_display
execute as @e[type=minecraft:block_display,tag=fc.game_entity,distance=..2] if score @s fc_id = #ctx_id fc_ctx run kill @s
