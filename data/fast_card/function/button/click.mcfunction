# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
execute unless score #version ct_ctx matches 1.. run return 0
# uninstall-guard: end
# 进度奖励函数会立即撤销自身，因此下一次点击仍可触发
advancement revoke @s only fast_card:button_click
# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end

# 非参赛玩家点击不会产生游戏效果
execute unless entity @s[tag=fc.player] run return fail

# 保存点击者，并只处理其所属牌桌的最近按钮
scoreboard players operation #ctx_id fc_ctx = @s fc_id
tag @s add fc.clicker
execute as @e[type=minecraft:interaction,tag=fc.button,distance=..5,sort=nearest,limit=1] if score @s fc_id = #ctx_id fc_ctx at @s run function fast_card:button/as_button
tag @s remove fc.clicker
