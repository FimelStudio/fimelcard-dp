# 弹数变化时立即整体重建；低频维护只在检测到缺失或数量不符时调用本函数
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @e[type=minecraft:item_display,tag=lh.bullet_hud] if score @s lh_id = #ctx_id lh_ctx run kill @s
function liars_holdem:hud/seat_north
function liars_holdem:hud/seat_east
function liars_holdem:hud/seat_south
function liars_holdem:hud/seat_west
