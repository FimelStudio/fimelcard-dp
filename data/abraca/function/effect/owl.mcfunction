scoreboard players operation #ctx ab_ctx = @s ab_id
scoreboard players operation #seat ab_ctx = @a[tag=ab.actor,limit=1] ab_seat
tag @e[tag=ab.secret_pick] remove ab.secret_pick
execute as @e[type=minecraft:marker,tag=ab.secret_stone,sort=random,limit=1] if score @s ab_id = #ctx ab_ctx if score @s ab_owner matches 0 run tag @s add ab.secret_pick
execute unless entity @e[tag=ab.secret_pick,limit=1] run tellraw @a[tag=ab.actor,limit=1] [{text:'[猫头鹰] ',color:'gold'},{text:'没有剩余的秘密咒语石。',color:'gray'}]
execute as @e[tag=ab.secret_pick,limit=1] run scoreboard players operation @s ab_owner = #seat ab_ctx
execute as @e[tag=ab.secret_pick,limit=1] run function abraca:effect/reveal_secret
tag @e[tag=ab.secret_pick] remove ab.secret_pick
