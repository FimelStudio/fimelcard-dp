# 玩家入口同时核验通用归属、游戏归属与本桌控制器。
tag @a[tag=ch.actor] remove ch.actor
tag @e[tag=ch.current] remove ch.current
execute unless entity @s[tag=ct.player,tag=ch.player] run return 0
execute unless score @s ct_id = @s ch_table run return 0
scoreboard players operation #ui_table ch_ctx = @s ch_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ch.controller,scores={ct_game=12,ct_state=1}] if score @s ct_id = #ui_table ch_ctx run tag @s add ch.current
execute unless entity @e[tag=ch.current,limit=1] run return 0
tag @s add ch.actor
execute as @e[tag=ch.current,limit=1] at @s run function chess:system/context
