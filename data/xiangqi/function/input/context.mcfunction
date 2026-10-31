# 玩家入口同时核验通用归属、游戏归属与本桌控制器。
tag @a[tag=xq.actor] remove xq.actor
tag @e[tag=xq.current] remove xq.current
execute unless entity @s[tag=ct.player,tag=xq.player] run return 0
execute unless score @s ct_id = @s xq_table run return 0
scoreboard players operation #ui_table xq_ctx = @s xq_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=xq.controller,scores={ct_game=13,ct_state=1}] if score @s ct_id = #ui_table xq_ctx run tag @s add xq.current
execute unless entity @e[tag=xq.current,limit=1] run return 0
tag @s add xq.actor
execute as @e[tag=xq.current,limit=1] at @s run function xiangqi:system/context
