# 游戏设置提交与回合操作使用彼此独立的trigger，设置保存还会复核原牌桌状态
execute as @a[scores={hb_settings=1..}] run function hanabi:settings/save

# Dialog提交只在非零时处理；所有分支都会重新校验回合、桌号和目标
execute as @a[scores={hb_action=1..}] at @s run function hanabi:action/handle

# F键把主手牌交换到副手；Q键优先使用原版丢弃统计作为低开销事件门控
execute as @a[tag=hb.player] if items entity @s weapon.offhand minecraft:paper[minecraft:custom_data~{hanabi:{card:1b}}] at @s run function hanabi:input/card_f
execute as @a[tag=hb.player] if items entity @s weapon.offhand minecraft:firework_star[minecraft:custom_data~{hanabi:{action:"hint"}}] at @s run function hanabi:input/hint_f_reject
execute as @a[tag=hb.player,scores={hb_drop_card=1..}] at @s run function hanabi:input/card_q
execute as @a[tag=hb.player,scores={hb_drop_hint=1..}] at @s run function hanabi:input/hint_q

# 26.2中丢弃统计与物品实体可能不在同一刻可见；仅在附近存在掉落物时补扫一次
# 手牌内含桌号、座位号和牌位，扫描不会误收别桌玩家或普通纸张
execute as @a[tag=hb.player,scores={hb_drop_card=0}] at @s if entity @e[type=minecraft:item,distance=..3] run function hanabi:input/card_q

# 发牌与结算等待只遍历处于对应状态的控制器
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=1}] at @s run function hanabi:deal/tick
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=3}] at @s run function hanabi:game/finish_tick

# 掉线检查每秒一次，避免逐刻扫描全部玩家
scoreboard players add #clock hb_ctx 1
execute if score #clock hb_ctx matches 20.. run function hanabi:system/maintenance
execute if score #clock hb_ctx matches 20.. run scoreboard players set #clock hb_ctx 0
