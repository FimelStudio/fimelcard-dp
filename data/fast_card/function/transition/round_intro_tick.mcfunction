# 局数文字总过场固定为40刻，即两秒
scoreboard players add @s fc_timer 1

# 文本动画库默认保留时间较长；全部字符生成后把淡出起点提前
execute if score @s fc_timer matches 6 run function fast_card:transition/shorten_round_title

# 两秒结束后清理本桌动画，再进入逐张发牌阶段
execute if score @s fc_timer matches 40.. run function fast_card:transition/cleanup
execute if score @s fc_timer matches 40.. run function fast_card:deal/start
