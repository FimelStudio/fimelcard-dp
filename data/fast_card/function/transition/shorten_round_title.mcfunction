# 找到本桌的动画中心，再按文本动画库的实例编号调整所有字符
scoreboard players operation #ctx_id fc_ctx = @s fc_id
execute as @e[type=minecraft:text_display,tag=fc.transition.root,tag=cgt_anim_text.positional.animation.center] if score @s fc_id = #ctx_id fc_ctx run function fast_card:transition/shorten_round_title_root
