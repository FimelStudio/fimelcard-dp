$execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{wenfei:{tool:"menu",table:$(table)}}] run kill @s
