# 相同牌型、长度和点数只保留一个选牌方案。炸弹和王炸的牌型号排在最后。
scoreboard players operation #hint_kind dd_ctx = #type dd_ctx
scoreboard players operation #hint_size dd_ctx = #n dd_ctx
scoreboard players operation #hint_rank dd_ctx = #high dd_ctx
function doudizhu:hint/key
execute if score #hint_key dd_ctx < #hint_first dd_ctx run function doudizhu:hint/remember_first
execute if score #hint_key dd_ctx > #hint_cursor dd_ctx if score #hint_key dd_ctx < #hint_next dd_ctx run function doudizhu:hint/remember_next
