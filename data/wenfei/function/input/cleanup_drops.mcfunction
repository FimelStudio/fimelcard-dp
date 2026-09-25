$execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{wenfei:{table:$(table)}}] run kill @s
