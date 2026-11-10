# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
execute unless score #version ct_ctx matches 1.. run return 0
# uninstall-guard: end
# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 即时输入由 UI 模块处理；只逐刻维护正在游戏的控制器。
# 旧正面实体只迁移一次，亦覆盖重载之后才加载的区块。
execute as @e[type=minecraft:item_display,tag=un.face,tag=!un.face_up_v2] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run function uno:visual/repair_face
function uno:input/tick
execute as @e[type=minecraft:marker,tag=un.controller,scores={un_state=1..5}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function uno:system/tick
execute as @e[type=minecraft:marker,tag=un.controller,scores={un_hud_dirty=1,un_state=1..5}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function uno:system/flush
