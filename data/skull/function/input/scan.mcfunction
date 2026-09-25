scoreboard players operation #scan sk_ctx = @s sk_id
execute at @s as @e[type=minecraft:item,distance=..8] if items entity @s contents *[minecraft:custom_data~{skull:{}}] run function skull:input/drop
