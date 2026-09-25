clear @s *[minecraft:custom_data~{skull:{}}]
execute store result storage skull:io hand.seat int 1 run scoreboard players get @s sk_seat
execute store result storage skull:io hand.table int 1 run scoreboard players get @s sk_id
scoreboard players operation #hand_table sk_ctx = @s sk_id
tag @a[tag=sk.receiver] remove sk.receiver
tag @s add sk.receiver
execute as @e[type=minecraft:marker,tag=sk.controller] if score @s sk_id = #hand_table sk_ctx run function skull:hand/load with storage skull:io hand
function skull:hand/menu with storage skull:io hand
tag @s remove sk.receiver
