# 恢复测试前的BetterTitle面板；测试前没有面板时归还原版Actionbar
scoreboard players set @s title.panel_id 0
execute if score @s hb_test_prev matches 1.. run scoreboard players operation @s title.panel_id = @s hb_test_prev
title @s actionbar {text:""}
scoreboard players reset @s hb_test_prev
tag @s remove hb.title_test_direct

# 仅移除本测试自行占用的文本动画库排除标签
execute if entity @s[tag=hb.title_test_owns_actionbar] run tag @s remove cgt_anim_text.replace.actionbar
tag @s remove hb.title_test_owns_actionbar
tag @s remove hb.title_test_active
tellraw @s [{text:"[花火测试] ",color:"light_purple"},{text:"左侧牌面测试已清除，并恢复测试前的面板。",color:"green"}]
