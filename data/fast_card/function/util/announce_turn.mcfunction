# 用临时标签确保文本中的玩家名只来自当前牌桌
scoreboard players operation #ctx_id fc_ctx = @s fc_id
scoreboard players operation #ctx_turn fc_ctx = @s fc_turn
tag @a[tag=fc.announced_turn] remove fc.announced_turn
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx if score @s fc_seat = #ctx_turn fc_ctx run tag @s add fc.announced_turn
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tellraw @s [{text:'[Fast Card] ',color:'gold'},{text:'现在由 ',color:'gray'},{selector:'@a[tag=fc.announced_turn,limit=1]',color:'yellow'},{text:' 按Q传出一张牌。',color:'gray'}]
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run title @s actionbar [{text:'当前出牌：',color:'gray'},{selector:'@a[tag=fc.announced_turn,limit=1]',color:'yellow'}]
tag @a[tag=fc.announced_turn] remove fc.announced_turn
