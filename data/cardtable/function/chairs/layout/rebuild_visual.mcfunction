# Rebuild chairs only; preserve table, board and corner decorations.
scoreboard players operation #seat_owner ct_ctx = @s ct_id
execute as @e[type=minecraft:item_display,tag=ct.skin] if score @s ct_id = #seat_owner ct_ctx if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/sofa"] run tag @s add ct.skin_chair
execute as @e[type=minecraft:item_display,tag=ct.skin] if score @s ct_id = #seat_owner ct_ctx if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/electro_chair"] run tag @s add ct.skin_chair
execute as @e[type=minecraft:item_display,tag=ct.skin] if score @s ct_id = #seat_owner ct_ctx if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/toys_chair"] run tag @s add ct.skin_chair
execute as @e[type=minecraft:item_display,tag=ct.skin] if score @s ct_id = #seat_owner ct_ctx if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/vintage_chair"] run tag @s add ct.skin_chair
execute as @e[type=minecraft:item_display,tag=ct.skin] if score @s ct_id = #seat_owner ct_ctx if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/bamboo_chair"] run tag @s add ct.skin_chair
execute as @e[type=minecraft:item_display,tag=ct.skin] if score @s ct_id = #seat_owner ct_ctx if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/garden_chair"] run tag @s add ct.skin_chair
execute as @e[tag=ct.chair4] if score @s ct_id = #seat_owner ct_ctx run kill @s
execute as @e[tag=ct.chair8] if score @s ct_id = #seat_owner ct_ctx run kill @s
execute as @e[tag=ct.skin_chair] if score @s ct_id = #seat_owner ct_ctx run kill @s
function cardtable:chairs/layout/spawn_visual
