# 仅用于清除重载前旧版Fast Card生成的牌盒；新牌盒全部由cardtable管理
scoreboard players operation #ctx_id fc_ctx = @s fc_id
execute as @e[type=minecraft:item_display,tag=fc.deal_box,distance=..2.1] if score @s fc_id = #ctx_id fc_ctx run kill @s
