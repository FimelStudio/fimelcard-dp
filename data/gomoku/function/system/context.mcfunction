# 每个入口重新绑定桌号；规则/交互均不依赖“最近实体”。
scoreboard players operation #table gm_ctx = @s ct_id
tag @e[tag=gm.current] remove gm.current
tag @e[tag=gm.board] remove gm.board
tag @a[tag=gm.audience] remove gm.audience
tag @e[tag=gm.audience] remove gm.audience
tag @s add gm.current
execute as @e[type=minecraft:marker,tag=gm.square] if score @s ct_id = #table gm_ctx run tag @s add gm.board
execute as @e[tag=gm.player,tag=ct.player] if score @s gm_table = #table gm_ctx if score @s ct_id = #table gm_ctx run tag @s add gm.audience
