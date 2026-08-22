tag @e[tag=ab.secret_pick] remove ab.secret_pick
execute as @e[type=minecraft:marker,tag=ab.deck,sort=random,limit=1] if score @s ab_id = @e[type=minecraft:marker,tag=ab.controller,limit=1] ab_id run tag @s add ab.secret_pick
execute as @e[tag=ab.secret_pick,limit=1] run tag @s remove ab.deck
execute as @e[tag=ab.secret_pick,limit=1] run tag @s add ab.secret_stone
execute as @e[tag=ab.secret_pick,limit=1] run scoreboard players set @s ab_owner 0
tag @e[tag=ab.secret_pick] remove ab.secret_pick
