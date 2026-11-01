scoreboard players set @s ll_drop 0
tag @a[tag=ll.dropper] remove ll.dropper
tag @s add ll.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents *[minecraft:custom_data~{love_letter:{tool:1b}}] run function love_letter:input/check_drop
tag @a[tag=ll.dropper] remove ll.dropper
