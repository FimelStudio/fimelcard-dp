# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s dc_drop_book 0
tag @e[tag=dc.note_drop] remove dc.note_drop
execute at @s as @e[type=minecraft:item,distance=..3,sort=nearest] if items entity @s contents minecraft:book[minecraft:custom_data~{decrypto:{tool:'notes'}}] run tag @s add dc.note_drop
execute if entity @e[tag=dc.note_drop,limit=1] run function decrypto:notes/use_item
tag @e[tag=dc.note_drop] remove dc.note_drop
