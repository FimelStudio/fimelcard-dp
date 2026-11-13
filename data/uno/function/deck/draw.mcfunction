# 输入 #seat、#amount；只摸到实际有的牌，每张成功取得的牌都会入公共动画队列。
scoreboard players operation #draw_left un_ctx = #amount un_ctx
scoreboard players set #draw_actual un_ctx 0
execute if score #draw_left un_ctx matches 109.. run scoreboard players set #draw_left un_ctx 108
execute if score #draw_left un_ctx matches 1.. run function uno:deck/draw_loop
