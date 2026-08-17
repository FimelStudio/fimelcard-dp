# 当前执行者是游戏控制器；重载或回合切换后恢复本桌唯一的提示操作物
scoreboard players operation #ctx_id hb_ctx = @s hb_id
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run function hanabi:input/clear_actions
execute if score @s hb_clues matches 1.. as @a[tag=hb.player,tag=hb.turn] unless entity @s[tag=hb.reward_pending] if score @s hb_id = #ctx_id hb_ctx run function hanabi:input/give_hint
execute if score @s hb_reward_pending matches 1.. run function hanabi:reward/reopen
