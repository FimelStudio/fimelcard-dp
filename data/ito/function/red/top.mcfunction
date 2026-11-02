scoreboard players set #best it_ctx -1
execute as @a[tag=it.audience,tag=!it.winner] run scoreboard players operation #best it_ctx > @s it_total
scoreboard players set #seat it_ctx 99
execute as @a[tag=it.audience,tag=!it.winner] if score @s it_total = #best it_ctx run scoreboard players operation #seat it_ctx < @s it_seat
execute as @a[tag=it.audience,tag=!it.winner] if score @s it_seat = #seat it_ctx run tag @s add it.winner
