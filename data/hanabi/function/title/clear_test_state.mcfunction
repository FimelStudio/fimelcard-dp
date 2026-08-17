# 静默恢复测试前的面板；只由正式花火面板接管流程调用。
scoreboard players set @s title.panel_id 0
execute if score @s hb_test_prev matches 1.. run scoreboard players operation @s title.panel_id = @s hb_test_prev
scoreboard players reset @s hb_test_prev

# 只归还测试函数自己占用的Actionbar排除标签。
execute if entity @s[tag=hb.title_test_owns_actionbar] run tag @s remove cgt_anim_text.replace.actionbar
tag @s remove hb.title_test_owns_actionbar
tag @s remove hb.title_test_direct
tag @s remove hb.title_test_active
