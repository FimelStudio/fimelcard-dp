# 即时输入由 UI 模块处理；只逐刻维护正在游戏的控制器。
# 旧正面实体只迁移一次，亦覆盖重载之后才加载的区块。
execute as @e[type=minecraft:item_display,tag=un.face,tag=!un.face_up_v2] run function uno:visual/repair_face
function uno:input/tick
execute as @e[type=minecraft:marker,tag=un.controller,scores={un_state=1..5}] at @s run function uno:system/tick
execute as @e[type=minecraft:marker,tag=un.controller,scores={un_hud_dirty=1,un_state=1..5}] at @s run function uno:system/flush
