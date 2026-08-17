# 只清理由当前控制器创建的文本动画，不影响附近其他牌桌
scoreboard players operation #ctx_id fc_ctx = @s fc_id
execute as @e[tag=fc.transition.root] if score @s fc_id = #ctx_id fc_ctx run function fast_card:transition/cleanup_root
