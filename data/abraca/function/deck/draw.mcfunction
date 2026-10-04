scoreboard players operation #ctx ab_ctx = @s ab_id
scoreboard players operation #seat ab_ctx = @s ab_seat
execute as @e[tag=ab.drawn] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.drawn
function abraca:deck/select_random
execute unless entity @e[tag=ab.drawn,limit=1] run return 0
execute as @e[tag=ab.drawn,limit=1] run scoreboard players operation @s ab_owner = #seat ab_ctx
execute as @e[tag=ab.drawn,limit=1] run tag @s remove ab.deck
execute as @e[tag=ab.drawn,limit=1] run tag @s add ab.hand
# 不向物品栏发放牌背；真实牌面仍仅在其他观察者的面板中显示。
execute as @e[type=minecraft:marker,tag=ab.controller] if score @s ab_id = #ctx ab_ctx at @s run function abraca:deck/spawn_refill_visual
execute as @e[tag=ab.drawn] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.drawn
