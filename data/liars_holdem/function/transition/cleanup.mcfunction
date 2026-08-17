# 只清理当前牌桌创建的文本动画
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @e[tag=lh.transition.root] if score @s lh_id = #ctx_id lh_ctx run function liars_holdem:transition/cleanup_root
