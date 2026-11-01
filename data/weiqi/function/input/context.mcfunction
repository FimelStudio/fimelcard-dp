# actor必须同时属于这张公共牌桌及围棋对局，复盘另校验原局资格。
tag @a[tag=go.actor] remove go.actor
tag @e[tag=go.current] remove go.current
execute unless entity @s[tag=ct.player,tag=go.player] run return 0
execute unless score @s ct_id = @s go_table run return 0
execute unless score @s go_side matches 1 unless score @s go_side matches -1 run return 0
scoreboard players operation #ui_table go_ctx = @s go_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=go.controller,scores={ct_game=20,ct_state=1}] if score @s ct_id = #ui_table go_ctx run tag @s add go.current
execute if score @s go_revelig matches 1 if score @s go_reviewtable = #ui_table go_ctx as @e[type=minecraft:marker,tag=ct.controller,tag=go.controller,scores={ct_game=20,ct_state=0}] if score @s ct_id = #ui_table go_ctx if data entity @s data.weiqi{review:1b} run tag @s add go.current
execute unless entity @e[tag=go.current,limit=1] run return 0
tag @s add go.actor
scoreboard players operation #actor go_ctx = @s go_side
execute as @e[tag=go.current,limit=1] at @s run function weiqi:system/context
