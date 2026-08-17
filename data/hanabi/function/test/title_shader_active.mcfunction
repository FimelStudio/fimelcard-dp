# 此测试不使用 BetterTitle 位移字体，只验证 26.2 的自定义 core/text GUI 分支。
# 专用颜色 #12FEDC 只供着色器识别，避免影响正式游戏里的普通青色文字。
tag @s add hb.title_test_direct
title @s actionbar {text:"着色器探针正常",color:"#12FEDC",bold:true,shadow_color:0}
tellraw @s [{text:"[花火测试] ",color:"light_purple",bold:true},{text:"若屏幕左上区域出现“着色器探针正常”，说明自定义 core/text 正在执行。",color:"gray"}]
