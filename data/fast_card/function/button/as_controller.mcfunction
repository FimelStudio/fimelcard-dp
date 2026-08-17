# 保存点击发生时的阶段，防止子函数改变状态后重复进入其他分支
scoreboard players operation #ctx_id fc_ctx = @s fc_id
scoreboard players operation #click_state fc_ctx = @s fc_state
scoreboard players set #hand fc_ctx 0

# 传牌阶段的首次点击必须检查牌型
execute if score #click_state fc_ctx matches 2 as @a[tag=fc.clicker,limit=1] if score @s fc_id = #ctx_id fc_ctx run function fast_card:hand/check
execute if score #click_state fc_ctx matches 2 if score #hand fc_ctx matches 1..3 run function fast_card:button/start_rush
execute if score #click_state fc_ctx matches 2 if score #hand fc_ctx matches 0 if score @s fc_rule matches 0 run function fast_card:button/invalid_ignore
execute if score #click_state fc_ctx matches 2 if score #hand fc_ctx matches 0 if score @s fc_rule matches 1 run function fast_card:button/false_loss

# 抢按阶段不再检查牌型，只记录未响应玩家的先后顺序
execute if score #click_state fc_ctx matches 3 run function fast_card:button/follow
