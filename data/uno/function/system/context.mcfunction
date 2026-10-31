# 同步临时标签由每次入口重新构造，绝不以距离认定实例。
scoreboard players operation #table un_ctx = @s ct_id
tag @e[tag=un.current] remove un.current
# @a 跨维度；先清全体真人，再清本维度的 GameTest 模拟玩家。
tag @a[tag=un.audience] remove un.audience
tag @e[tag=un.audience] remove un.audience
tag @e[tag=un.cards] remove un.cards
tag @e[tag=un.selected] remove un.selected
tag @s add un.current
execute as @e[tag=un.player,tag=ct.player] if score @s un_table = #table un_ctx if score @s ct_id = #table un_ctx run tag @s add un.audience
execute as @e[type=minecraft:marker,tag=un.card] if score @s ct_id = #table un_ctx run tag @s add un.cards
