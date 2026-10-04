# 重载或无效提交后，根据控制器保存的奖励类型恢复强制处理界面
scoreboard players operation #ctx_id hb_ctx = @s hb_id
tag @a[tag=hb.reward_actor] remove hb.reward_actor
execute as @a[tag=hb.player,tag=hb.reward_pending,tag=hb.turn] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.reward_actor
execute unless entity @a[tag=hb.reward_actor,limit=1] run return fail
execute as @a[tag=hb.reward_actor,limit=1] run function hanabi:input/give_reward_reopen

execute if score @s hb_reward_pending matches 2 run return run execute as @a[tag=hb.reward_actor,limit=1] run function hanabi:dialog/restore/open
execute if score @s hb_reward_pending matches 3 if score @a[tag=hb.reward_actor,limit=1] hb_target matches 1..8 run return run function hanabi:reward/full_hint/open_card
execute if score @s hb_reward_pending matches 3 run return run function hanabi:reward/full_hint/open_target
execute if score @s hb_reward_pending matches 4 run return run function hanabi:reward/risk/open
