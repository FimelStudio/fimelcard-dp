scoreboard players set @s dc_drop_book 0
tag @e[tag=dc.note_drop] remove dc.note_drop
execute at @s as @e[type=minecraft:item,distance=..3,sort=nearest] if items entity @s contents minecraft:book[minecraft:custom_data~{decrypto:{tool:'notes'}}] run tag @s add dc.note_drop
execute if entity @e[tag=dc.note_drop,limit=1] run function decrypto:notes/use_item
tag @e[tag=dc.note_drop] remove dc.note_drop
