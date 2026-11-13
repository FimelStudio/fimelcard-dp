tag @e[tag=it.cards,scores={it_owner=-1},sort=random,limit=1] add it.reference
scoreboard players set @e[tag=it.cards,tag=it.reference] it_used 4
scoreboard players set @e[tag=it.cards,tag=it.reference] it_owner -4
execute store result entity @s data.ito.reference int 1 run scoreboard players get @e[tag=it.cards,tag=it.reference,limit=1] it_number
