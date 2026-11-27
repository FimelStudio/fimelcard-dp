# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s hb_drop_reward 0
execute unless entity @s[tag=hb.reward_pending] run return 0
# 不依赖最近物品；只回收当前玩家亲自丢出的奖励恢复染料。
tag @a[tag=hb.reward_reopen_actor] remove hb.reward_reopen_actor
tag @s add hb.reward_reopen_actor
scoreboard players set #reward_reopen_owned hb_ctx 0
execute at @s as @e[type=minecraft:item,distance=..3] if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{hanabi:{action:'reward_reopen'}}] run function hanabi:input/consume_reward_reopen
tag @s remove hb.reward_reopen_actor
execute unless score #reward_reopen_owned hb_ctx matches 1 run return 0
scoreboard players operation #ctx_id hb_ctx = @s hb_id
tag @e[tag=hb.reward_reopen_controller] remove hb.reward_reopen_controller
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=2,hb_reward_pending=1..}] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.reward_reopen_controller
execute unless entity @e[tag=hb.reward_reopen_controller,limit=1] run return 0
execute as @e[tag=hb.reward_reopen_controller,limit=1] at @s run function hanabi:reward/reopen
tag @e[tag=hb.reward_reopen_controller] remove hb.reward_reopen_controller
