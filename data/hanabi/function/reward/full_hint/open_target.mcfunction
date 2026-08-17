# 完全提示只能选择其他仍有普通手牌的参赛玩家
scoreboard players operation #ctx_id hb_ctx = @s hb_id
tag @a[tag=hb.reward_actor] remove hb.reward_actor
execute as @a[tag=hb.player,tag=hb.reward_pending,tag=hb.turn] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.reward_actor
execute unless entity @a[tag=hb.reward_actor,limit=1] run return fail
scoreboard players set @a[tag=hb.reward_actor,limit=1] hb_target 0
execute as @a[tag=hb.reward_actor,limit=1] run function hanabi:reward/full_hint/target_dialog
