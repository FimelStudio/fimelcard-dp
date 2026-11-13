tag @s add it.card
scoreboard players operation @s ct_id = #table it_ctx
scoreboard players operation @s it_number = #build it_ctx
scoreboard players set @s it_owner -1
scoreboard players set @s it_used 0
scoreboard players set @s it_slot 0
data modify entity @s data.description set value ""
