# 以通用桌控制器执行，补清旧版4格半径之外留下的摊牌实体。
# 正在摊牌/左轮阶段的本桌实体必须保留；不依赖已清除的游戏控制器标签。
execute if score @s ct_state matches 1 if score @s ct_game matches 2 if score @s lh_state matches 14..15 run return 0
scoreboard players operation #stale_table lh_ctx = @s ct_id
execute as @e[type=minecraft:text_display,tag=lh.showdown_display] if score @s lh_id = #stale_table lh_ctx run kill @s
