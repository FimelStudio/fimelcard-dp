# 玩家入口：同时核验通用座位、游戏归属与控制器当前游戏。
tag @a[tag=un.actor] remove un.actor
tag @e[tag=un.current] remove un.current
execute unless entity @s[tag=un.player,tag=ct.player] run return 0
execute unless score @s ct_id = @s un_table run return 0
scoreboard players operation #ui_table un_ctx = @s un_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=un.controller,scores={ct_game=11,ct_state=1}] if score @s ct_id = #ui_table un_ctx run tag @s add un.current
execute unless entity @e[tag=un.current,limit=1] run return 0
tag @s add un.actor
execute as @e[tag=un.current,limit=1] at @s run function uno:system/context
