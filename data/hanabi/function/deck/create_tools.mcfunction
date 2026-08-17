# 提示牌与恢复牌不属于任何花火颜色、数字，不会被普通提示命中
scoreboard players set #deck_color hb_ctx 0
scoreboard players set #deck_rank hb_ctx 0

scoreboard players set #deck_reward hb_ctx 1
scoreboard players operation #deck_copies hb_ctx = @s hb_tool_hint
execute if score #deck_copies hb_ctx matches 1.. run function hanabi:deck/create_copies

scoreboard players set #deck_reward hb_ctx 2
scoreboard players operation #deck_copies hb_ctx = @s hb_tool_restore
execute if score #deck_copies hb_ctx matches 1.. run function hanabi:deck/create_copies

scoreboard players set #deck_reward hb_ctx 0
