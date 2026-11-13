# 每次入口重新绑定本桌；临时 actor 由输入层独立管理。
scoreboard players operation #table go_ctx = @s ct_id
tag @e[tag=go.current] remove go.current
tag @e[tag=go.board] remove go.board
tag @a[tag=go.audience] remove go.audience
tag @s add go.current
execute as @e[type=minecraft:marker,tag=go.square] if score @s ct_id = #table go_ctx run tag @s add go.board
execute as @a[tag=go.player,tag=ct.player] if score @s go_table = #table go_ctx if score @s ct_id = #table go_ctx run tag @s add go.audience
