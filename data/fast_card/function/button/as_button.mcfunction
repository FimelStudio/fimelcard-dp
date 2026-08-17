# 从按钮定位同编号控制器
scoreboard players operation #ctx_id fc_ctx = @s fc_id
execute as @e[type=minecraft:marker,tag=fc.controller,distance=..2] if score @s fc_id = #ctx_id fc_ctx run function fast_card:button/as_controller
