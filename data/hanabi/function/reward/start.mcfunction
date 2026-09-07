# 当前执行者是刚完成一列烟花的控制器；奖励在补牌和回合推进前强制结算
scoreboard players operation @s hb_pending_slot = #slot hb_ctx
scoreboard players set @s hb_reward_pending 0
scoreboard players operation #ctx_id hb_ctx = @s hb_id

tag @e[tag=hb.reward_candidate] remove hb.reward_candidate
tag @e[tag=hb.reward_drawn] remove hb.reward_drawn
execute as @e[type=minecraft:marker,tag=hb.reward_deck] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.reward_candidate
execute as @e[type=minecraft:marker,tag=hb.reward_candidate,sort=random,limit=1] run tag @s add hb.reward_drawn
tag @e[tag=hb.reward_candidate] remove hb.reward_candidate

# 池状态异常时不阻塞牌局，直接完成原出牌动作
execute unless entity @e[tag=hb.reward_drawn,limit=1] run function hanabi:log {text:"奖励牌数量与实体池不一致，已跳过本次奖励"}
execute unless entity @e[tag=hb.reward_drawn,limit=1] run return run function hanabi:reward/skip

scoreboard players operation @s hb_reward_pending = @e[tag=hb.reward_drawn,limit=1] hb_reward
kill @e[tag=hb.reward_drawn,limit=1]
scoreboard players remove @s hb_reward_left 1
tag @a[tag=hb.action_actor,limit=1] add hb.reward_pending
execute as @a[tag=hb.action_actor,limit=1] run function hanabi:input/clear_actions
execute as @a[tag=hb.action_actor,limit=1] run function hanabi:hand/sync
execute as @a[tag=hb.action_actor,limit=1] run function hanabi:input/give_reward_reopen
dialog clear @a[tag=hb.action_actor,limit=1]

function hanabi:player/tag_audience
tellraw @a[tag=hb.audience] [{text:"[花火] ",color:"light_purple"},{selector:"@a[tag=hb.action_actor,limit=1]",color:"yellow"},{text:" 完成了一列烟花，立即抽取一张奖励牌！",color:"gold"}]
playsound minecraft:entity.player.levelup master @a[tag=hb.audience] ~ ~ ~ 0.75 1.35
playsound minecraft:item.book.page_turn master @a[tag=hb.audience] ~ ~ ~ 0.8 1.65
function hanabi:hud/update

execute if score @s hb_reward_pending matches 1 run return run function hanabi:action/reward/hint
execute if score @s hb_reward_pending matches 2 run return run function hanabi:action/reward/restore/open
execute if score @s hb_reward_pending matches 3 run return run function hanabi:reward/full_hint/open_target
execute if score @s hb_reward_pending matches 4 run return run function hanabi:reward/risk/open

# 100以上交给扩展函数标签；同步扩展应调用reward/finish，异步扩展需给控制器添加hb.reward_external_wait
tag @s remove hb.reward_external_wait
execute if score @s hb_reward_pending matches 100.. run function #hanabi:reward_resolve
execute if score @s hb_reward_pending matches 100.. unless entity @s[tag=hb.reward_external_wait] run tellraw @a[tag=hb.audience] [{text:"[花火] ",color:"light_purple"},{text:"该扩展奖励没有注册处理器，本次按无效果结算。",color:"yellow"}]
execute if score @s hb_reward_pending matches 100.. unless entity @s[tag=hb.reward_external_wait] run return run function hanabi:reward/finish
