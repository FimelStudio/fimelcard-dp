# 六张奖励牌独立于普通牌库：提示恢复×2、弃牌恢复×2、完全提示×1、风险牌×1
scoreboard players set @s hb_reward_left 0

scoreboard players set #reward_type hb_ctx 1
scoreboard players set #reward_copies hb_ctx 2
function hanabi:reward/deck/create_copies

scoreboard players set #reward_type hb_ctx 2
scoreboard players set #reward_copies hb_ctx 2
function hanabi:reward/deck/create_copies

scoreboard players set #reward_type hb_ctx 3
scoreboard players set #reward_copies hb_ctx 1
function hanabi:reward/deck/create_copies

scoreboard players set #reward_type hb_ctx 4
scoreboard players set #reward_copies hb_ctx 1
function hanabi:reward/deck/create_copies

# 扩展包可以通过函数标签追加奖励牌注册函数
function #hanabi:reward_cards
function hanabi:log {text:"独立奖励牌堆已创建，共六张基础奖励牌"}
