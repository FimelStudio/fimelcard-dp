# Trigger在客户端提交后可能被锁定；当前回合内持续启用，确保每次都能选择咒语。
execute as @e[type=minecraft:marker,tag=ab.controller,scores={ab_state=1}] at @s run function abraca:deal/tick
# 游戏结束后保留最终血量面板 6 秒，再恢复牌桌选择菜单。
execute as @e[type=minecraft:marker,tag=ab.controller,scores={ab_state=3,ab_timer=1..}] run scoreboard players remove @s ab_timer 1
execute as @e[type=minecraft:marker,tag=ab.controller,scores={ab_state=3,ab_timer=..0}] at @s run function abraca:game/return_lobby
execute as @a[tag=ab.turn] run scoreboard players enable @s ab_action
execute as @a[tag=ab.turn,scores={ab_action=1..}] at @s run function abraca:action/handle
