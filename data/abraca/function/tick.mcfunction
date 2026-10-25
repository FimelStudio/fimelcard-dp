execute as @a[scores={ab_settings=1..}] run function abraca:settings/save
# 使用掉落物origin分派Q键施法；不依赖可能漏报的丢弃统计。
execute as @e[type=minecraft:item] if items entity @s contents minecraft:paper[minecraft:custom_data~{abraca:{cast:1b}}] run function abraca:input/drop
execute as @e[type=minecraft:item] if items entity @s contents minecraft:black_dye[minecraft:custom_data~{abraca:{cast:1b}}] run function abraca:input/drop
execute as @e[type=minecraft:marker,tag=ab.controller,scores={ab_state=1}] at @s run function abraca:deal/tick
# 游戏结束后保留最终血量面板 6 秒，再恢复牌桌选择菜单。
execute as @e[type=minecraft:marker,tag=ab.controller,scores={ab_state=3,ab_timer=1..}] run scoreboard players remove @s ab_timer 1
execute as @e[type=minecraft:marker,tag=ab.controller,scores={ab_state=3,ab_timer=..0}] at @s run function abraca:game/return_lobby
# 旧聊天提交只作清零处理，施法及结束均必须来自本次合法Q键输入。
execute as @a[tag=ab.turn,scores={ab_action=1..}] at @s run function abraca:action/handle

# 自己的手牌数量随左上角面板在发牌完成、施法、补牌和重载时一起刷新。
