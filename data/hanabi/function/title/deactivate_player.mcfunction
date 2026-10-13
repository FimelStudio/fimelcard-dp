# 恢复进入花火前由其他模块设置的BetterTitle面板；没有旧面板时归还原版Actionbar。
scoreboard players set @s fbt_panel 0
execute if score @s hb_prev_panel matches 1.. run scoreboard players operation @s fbt_panel = @s hb_prev_panel
title @s actionbar {text:""}
scoreboard players reset @s hb_prev_panel

# 只归还由花火占用的文本动画库Actionbar排除标签。
execute if entity @s[tag=hb.owns_actionbar_block] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove hb.owns_actionbar_block
