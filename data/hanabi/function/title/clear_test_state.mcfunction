# 静默恢复测试前的面板；只由正式花火面板接管流程调用。
scoreboard players set @s fbt_panel 0
execute if score @s hb_test_prev matches 1.. run scoreboard players operation @s fbt_panel = @s hb_test_prev
scoreboard players reset @s hb_test_prev

# 只归还测试函数自己占用的Actionbar排除标签。
execute if entity @s[tag=hb.title_test_owns_actionbar] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove hb.title_test_owns_actionbar
tag @s remove hb.title_test_direct
tag @s remove hb.title_test_active
