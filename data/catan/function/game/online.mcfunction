scoreboard players set #live ca_ctx 0
execute as @a[tag=ca.audience] run scoreboard players add #live ca_ctx 1
execute store result score #required ca_ctx run data get entity @s data.catan.n
