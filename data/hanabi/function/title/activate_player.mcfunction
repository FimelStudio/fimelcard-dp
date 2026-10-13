# 当前执行者是本桌玩家；每位观察者拥有独立面板，才能排除自己的真牌。
# 若玩家此前运行过左侧面板诊断，先静默退出测试，避免测试标签阻止正式面板逐刻发送。
execute if entity @s[tag=hb.title_test_active] run function hanabi:title/clear_test_state
tag @s remove hb.title_test_direct
execute unless score @s hb_prev_panel matches 0.. run function hanabi:title/save_previous

# 花火使用BetterTitle持续接管Actionbar；阻止文本动画库的全局Actionbar覆盖牌面。
# 仅在标签原本不存在时记录所有权，退出游戏时不会误删其他系统预先设置的排除标签。
execute unless entity @s[tag=fimel.anim_text.replace.actionbar] run tag @s add hb.owns_actionbar_block
tag @s add fimel.anim_text.replace.actionbar

function fimel_title:new_panel {id:"@s hb_panel"}
scoreboard players operation @s fbt_panel = @s hb_panel
