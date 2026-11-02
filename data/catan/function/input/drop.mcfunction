scoreboard players set @s ca_drop 0
tag @a[tag=ca.dropper] remove ca.dropper
tag @s add ca.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:paper[minecraft:custom_data~{catan:{tool:1b}}] run function catan:input/check_drop
tag @s remove ca.dropper
