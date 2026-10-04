execute as @e[type=minecraft:item,distance=..6] if items entity @s contents minecraft:book[minecraft:custom_data~{decrypto:{tool:'notes'}}] run kill @s
execute as @e[type=minecraft:item,distance=..6] if items entity @s contents minecraft:paper[minecraft:custom_data~{decrypto:{tool:'guess'}}] run kill @s
execute as @e[type=minecraft:item,distance=..6] if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'guess'}}] run kill @s
execute as @e[type=minecraft:item,distance=..6] if items entity @s contents minecraft:paper[minecraft:custom_data~{decrypto:{clue:1b}}] run kill @s
execute as @e[type=minecraft:item,distance=..6] if items entity @s contents minecraft:writable_book[minecraft:custom_data~{decrypto:{clue:1b}}] run kill @s
execute as @e[type=minecraft:item,distance=..6] if items entity @s contents minecraft:written_book[minecraft:custom_data~{decrypto:{clue:1b}}] run kill @s
execute as @e[type=minecraft:item,distance=..6] if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'prompt'}}] run kill @s
