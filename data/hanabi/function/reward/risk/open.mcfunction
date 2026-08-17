# 风险牌必须立即选择0、1或2；同量增加当前提示标记与当前失误标记
scoreboard players operation #ctx_id hb_ctx = @s hb_id
tag @a[tag=hb.reward_actor] remove hb.reward_actor
execute as @a[tag=hb.player,tag=hb.reward_pending,tag=hb.turn] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.reward_actor
execute unless entity @a[tag=hb.reward_actor,limit=1] run return fail
execute store result storage hanabi:reward clues int 1 run scoreboard players get @s hb_clues
execute store result storage hanabi:reward clue_max int 1 run scoreboard players get @s hb_clue_max
execute store result storage hanabi:reward strikes int 1 run scoreboard players get @s hb_strikes
execute store result storage hanabi:reward strike_max int 1 run scoreboard players get @s hb_strike_max
scoreboard players set @a[tag=hb.reward_actor,limit=1] hb_action 0
scoreboard players enable @a[tag=hb.reward_actor,limit=1] hb_action
execute as @a[tag=hb.reward_actor,limit=1] run function hanabi:reward/risk/show with storage hanabi:reward
