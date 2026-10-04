# 当前执行者是提交trigger的奖励完成者；控制器已带hb.action_controller
scoreboard players operation #reward_type hb_ctx = @e[tag=hb.action_controller,limit=1] hb_reward_pending
scoreboard players set #reward_handled hb_ctx 0

execute if score #reward_type hb_ctx matches 2 if score #action hb_ctx matches 801..999 run scoreboard players set #reward_handled hb_ctx 1
execute if score #reward_type hb_ctx matches 2 if score #action hb_ctx matches 801..999 run scoreboard players operation #restore_option hb_ctx = #action hb_ctx
execute if score #reward_type hb_ctx matches 2 if score #action hb_ctx matches 801..999 run scoreboard players remove #restore_option hb_ctx 800
execute if score #reward_type hb_ctx matches 2 if score #action hb_ctx matches 801..999 as @e[tag=hb.action_controller,limit=1] at @s run function hanabi:action/reward/restore/select

execute if score #reward_type hb_ctx matches 3 if score #action hb_ctx matches 1101..1108 run scoreboard players set #reward_handled hb_ctx 1
execute if score #reward_type hb_ctx matches 3 if score #action hb_ctx matches 1101..1108 as @e[tag=hb.action_controller,limit=1] at @s run function hanabi:reward/full_hint/select_target
execute if score #reward_type hb_ctx matches 3 if score #action hb_ctx matches 1199 run scoreboard players set #reward_handled hb_ctx 1
execute if score #reward_type hb_ctx matches 3 if score #action hb_ctx matches 1199 as @e[tag=hb.action_controller,limit=1] at @s run function hanabi:reward/finish
execute if score #reward_type hb_ctx matches 3 if score #action hb_ctx matches 1201..1205 run scoreboard players set #reward_handled hb_ctx 1
execute if score #reward_type hb_ctx matches 3 if score #action hb_ctx matches 1201..1205 as @e[tag=hb.action_controller,limit=1] at @s run function hanabi:reward/full_hint/select_card

execute if score #reward_type hb_ctx matches 4 if score #action hb_ctx matches 1300..1302 run scoreboard players set #reward_handled hb_ctx 1
execute if score #reward_type hb_ctx matches 4 if score #action hb_ctx matches 1300..1302 as @e[tag=hb.action_controller,limit=1] at @s run function hanabi:reward/risk/select

# Q/F误操作、过期点击或关闭界面后的其他提交都不会跳过奖励，只会重新打开当前奖励
execute unless score #reward_handled hb_ctx matches 1 as @e[tag=hb.action_controller,limit=1] at @s run function hanabi:reward/reopen
