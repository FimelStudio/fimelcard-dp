# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 从按钮定位同编号控制器
scoreboard players operation #ctx_id fc_ctx = @s fc_id
execute as @e[type=minecraft:marker,tag=fc.controller,distance=..2] if score @s fc_id = #ctx_id fc_ctx run function fast_card:button/as_controller
