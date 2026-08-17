scoreboard players operation #ctx_id fc_ctx = @s fc_id
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run ride @s dismount
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run function fast_card:player/clear_state
execute as @e[type=minecraft:item,distance=..6] run function fast_card:util/kill_if_card
execute as @e[tag=fc.part,distance=..6] if score @s fc_id = #ctx_id fc_ctx run kill @s
kill @e[type=minecraft:marker,tag=fc.deck,distance=..1]
tellraw @a[tag=ct.remove_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'旧版展示实体牌桌已清除，可以在原地重新创建结构牌桌。',color:'green'}]
kill @s
