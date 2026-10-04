scoreboard players set @s dd_drop 0
tag @s add dd.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:book[minecraft:custom_data~{doudizhu:{tool:"hand"}}] run function doudizhu:input/check_drop
tag @s remove dd.dropper
