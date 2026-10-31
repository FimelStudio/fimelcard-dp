# 每个入口重新绑定桌号；规则/交互均不依赖“最近实体”。
scoreboard players operation #table ch_ctx = @s ct_id
tag @e[tag=ch.current] remove ch.current
tag @e[tag=ch.board] remove ch.board
tag @a[tag=ch.audience] remove ch.audience
tag @e[tag=ch.audience] remove ch.audience
tag @s add ch.current
execute as @e[type=minecraft:marker,tag=ch.square] if score @s ct_id = #table ch_ctx run tag @s add ch.board
execute as @e[tag=ch.player,tag=ct.player] if score @s ch_table = #table ch_ctx if score @s ct_id = #table ch_ctx run tag @s add ch.audience
