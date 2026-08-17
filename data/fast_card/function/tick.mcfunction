# 小局过场和逐张发牌都由牌桌控制器自己的计时器推进
execute as @e[type=minecraft:marker,tag=fc.controller,scores={fc_state=1,fc_phase=0}] at @s run function fast_card:transition/round_intro_tick

# 普通玩家通过对话框提交的trigger只在数值非零时处理；0表示取消
execute as @a[scores={fc_settings=1..}] run function fast_card:settings/save

# 重载时可能残留旧版飞行牌；这里只做一次标签和记分项迁移，后续由cardtable公共动画处理
execute as @e[type=minecraft:item,tag=fc.dealt_card] run function fast_card:deal/migrate_legacy_flying

# 发牌分为牌盒出现、逐张发牌和牌盒消失三个阶段
execute as @e[type=minecraft:marker,tag=fc.controller,scores={fc_state=1,fc_phase=1}] at @s run function fast_card:deal/intro_tick
execute as @e[type=minecraft:marker,tag=fc.controller,scores={fc_state=1,fc_phase=2}] at @s run function fast_card:deal/tick
execute as @e[type=minecraft:marker,tag=fc.controller,scores={fc_state=1,fc_phase=3}] at @s run function fast_card:deal/outro_tick

# 传牌阶段只检查当前出牌者附近的物品
execute as @e[type=minecraft:marker,tag=fc.controller,scores={fc_state=2}] at @s run function fast_card:pass/tick

# 结算等待只增加一个控制器分数
execute as @e[type=minecraft:marker,tag=fc.controller,scores={fc_state=4}] at @s run function fast_card:round/tick

# 掉线检测与玩家保护每秒执行一次；游戏中不再强制维持骑乘
scoreboard players add #clock fc_ctx 1
execute if score #clock fc_ctx matches 20.. run function fast_card:system/maintenance
execute if score #clock fc_ctx matches 20.. run scoreboard players set #clock fc_ctx 0
