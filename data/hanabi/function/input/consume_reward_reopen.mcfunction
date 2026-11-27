# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 必须是本次恢复者丢出的物品，不能收走附近其他人的染料。
scoreboard players set #reward_drop_owner hb_ctx 0
execute on origin if entity @s[tag=hb.player,tag=hb.reward_reopen_actor,tag=hb.reward_pending] run scoreboard players set #reward_drop_owner hb_ctx 1
execute unless score #reward_drop_owner hb_ctx matches 1 run return 0
scoreboard players set #reward_reopen_owned hb_ctx 1
kill @s
