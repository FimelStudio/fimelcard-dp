# 每个入口重新绑定桌号；规则/交互均不依赖“最近实体”。
scoreboard players operation #table xq_ctx = @s ct_id
tag @e[tag=xq.current] remove xq.current
tag @e[tag=xq.board] remove xq.board
tag @a[tag=xq.audience] remove xq.audience
tag @e[tag=xq.audience] remove xq.audience
tag @s add xq.current
execute as @e[type=minecraft:marker,tag=xq.square] if score @s ct_id = #table xq_ctx run tag @s add xq.board
execute as @e[tag=xq.player,tag=ct.player] if score @s xq_table = #table xq_ctx if score @s ct_id = #table xq_ctx run tag @s add xq.audience
