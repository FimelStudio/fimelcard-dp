scoreboard players operation #table it_ctx = @s ct_id
tag @e[tag=it.current] remove it.current
tag @e[tag=it.cards] remove it.cards
tag @e[tag=it.parts] remove it.parts
tag @a[tag=it.audience] remove it.audience
tag @s add it.current
execute as @e[type=minecraft:marker,tag=it.card] if score @s ct_id = #table it_ctx run tag @s add it.cards
execute as @e[type=minecraft:marker,tag=it.part] if score @s ct_id = #table it_ctx run tag @s add it.parts
execute as @a[tag=it.player,tag=ct.player] if score @s it_table = #table it_ctx if score @s ct_id = #table it_ctx run tag @s add it.audience
