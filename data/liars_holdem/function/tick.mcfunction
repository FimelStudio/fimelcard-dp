# 普通玩家提交的trigger只在非零时处理
execute as @a[scores={lh_settings=1..}] run function liars_holdem:settings/save
execute as @a[scores={lh_help=1..}] run function liars_holdem:rules/handle_help
execute as @a[scores={lh_swap_pick=1..}] run function liars_holdem:swap/apply

# 26.2已无可用的主副手交换统计准则；直接检测Call物品被F键交换进副手
execute as @a[tag=lh.player,tag=lh.turn] if items entity @s weapon.offhand minecraft:lime_dye[minecraft:custom_data~{liars_holdem:{action:"call"}}] at @s run function liars_holdem:action/press_f

# Q键丢弃事件只扫描实际产生对应统计的赌命德州扑克玩家
execute as @a[tag=lh.player,scores={lh_drop_call=1..}] at @s run function liars_holdem:action/drop_call
execute as @a[tag=lh.player,scores={lh_drop_fold=1..}] at @s run function liars_holdem:action/drop_fold

# 26.2联机环境中纸张丢弃统计不会稳定同步到记分板；只扫描参赛玩家身边的本游戏手牌
# route_card_drop通过物品的origin关系回溯真正丢牌者，不会把同桌其他玩家的牌认错
execute as @a[tag=lh.player] at @s as @e[type=minecraft:item,tag=!lh.drop_processed,distance=..4] if items entity @s contents minecraft:paper[minecraft:custom_data~{liars_holdem:{card:1b}}] run function liars_holdem:action/route_card_drop
tag @e[type=minecraft:item,tag=lh.drop_processed] remove lh.drop_processed

# 只有正在过场、发牌、翻牌、左轮或局间等待的控制器需要逐刻推进
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=1}] at @s run function liars_holdem:round/intro_tick
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=2}] at @s run function liars_holdem:deal/tick
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=6}] at @s run function liars_holdem:community/reveal_tick
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=8}] at @s run function liars_holdem:community/reveal_tick
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=10}] at @s run function liars_holdem:community/reveal_tick
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=13}] at @s run function liars_holdem:gun/tick
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=14}] at @s run function liars_holdem:showdown/tick
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=15}] at @s run function liars_holdem:gun/tick
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=16}] at @s run function liars_holdem:round/end_tick
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=17}] at @s run function liars_holdem:game/finish_tick

# 前置动画库会在后续刻继续生成字符实体，过场存续期间按动画实例持续补正vertical
execute as @e[type=minecraft:text_display,tag=lh.transition.root] at @s run function liars_holdem:transition/enforce_vertical

# 掉线和保护维护每秒执行一次，不逐刻遍历全部玩家
scoreboard players add #clock lh_ctx 1
execute if score #clock lh_ctx matches 20.. run function liars_holdem:system/maintenance
execute if score #clock lh_ctx matches 20.. run scoreboard players set #clock lh_ctx 0
