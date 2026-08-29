scoreboard players operation #ctx ab_ctx = @s ab_id
scoreboard players operation #seat ab_ctx = @s ab_seat
execute as @e[tag=ab.drawn] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.drawn
execute as @e[type=minecraft:marker,tag=ab.deck,sort=random,limit=1] if score @s ab_id = #ctx ab_ctx run tag @s add ab.drawn
execute unless entity @e[tag=ab.drawn,limit=1] run return 0
execute as @e[tag=ab.drawn,limit=1] run scoreboard players operation @s ab_owner = #seat ab_ctx
execute as @e[tag=ab.drawn,limit=1] run tag @s remove ab.deck
execute as @e[tag=ab.drawn,limit=1] run tag @s add ab.hand
# 持有者始终只看到咒语石背面；真实牌面仅在其他观察者的BetterTitle面板中显示。
give @s minecraft:paper[minecraft:item_model='card:abraca/back',minecraft:item_name='未知咒语石',minecraft:custom_data={abraca:{stone:1b}},minecraft:max_stack_size=1]
execute as @e[type=minecraft:marker,tag=ab.controller] if score @s ab_id = #ctx ab_ctx at @s run function abraca:deck/spawn_refill_visual
execute as @e[tag=ab.drawn] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.drawn
