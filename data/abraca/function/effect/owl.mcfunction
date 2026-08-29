scoreboard players operation #ctx ab_ctx = @s ab_id
scoreboard players operation #seat ab_ctx = @a[tag=ab.actor,limit=1] ab_seat
# 先筛选本桌、未领取的石头，再随机选择；不能先随机后检查，否则会把别桌或已领取石误报为库存耗尽。
execute as @e[tag=ab.secret_pick] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.secret_pick
tag @e[tag=ab.secret_candidate] remove ab.secret_candidate
execute as @e[type=minecraft:marker,tag=ab.secret_stone,scores={ab_owner=0}] if score @s ab_id = #ctx ab_ctx run tag @s add ab.secret_candidate
scoreboard players set #secret_available ab_ctx 0
execute as @e[tag=ab.secret_candidate] run scoreboard players add #secret_available ab_ctx 1
execute store result storage abraca:debug id int 1 run scoreboard players get #ctx ab_ctx
execute store result storage abraca:debug seat int 1 run scoreboard players get #seat ab_ctx
execute store result storage abraca:debug available int 1 run scoreboard players get #secret_available ab_ctx
function abraca:debug/log_owl with storage abraca:debug
execute as @e[type=minecraft:marker,tag=ab.secret_candidate,sort=random,limit=1] run tag @s add ab.secret_pick
tag @e[tag=ab.this_secret_pick] remove ab.this_secret_pick
execute as @e[tag=ab.secret_pick] if score @s ab_id = #ctx ab_ctx run tag @s add ab.this_secret_pick
execute unless entity @e[tag=ab.this_secret_pick,limit=1] run tellraw @a[tag=ab.actor,limit=1] [{text:'[猫头鹰] ',color:'gold'},{text:'没有剩余的秘密咒语石。',color:'gray'}]
execute as @e[tag=ab.this_secret_pick,limit=1] run scoreboard players operation @s ab_owner = #seat ab_ctx
execute as @e[tag=ab.this_secret_pick,limit=1] run function abraca:effect/reveal_secret
execute as @e[tag=ab.secret_pick] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.secret_pick
tag @e[tag=ab.this_secret_pick] remove ab.this_secret_pick
tag @e[tag=ab.secret_candidate] remove ab.secret_candidate
