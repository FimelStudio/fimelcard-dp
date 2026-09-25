execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_id = @s sk_id run return 0
scoreboard players set #drop_owner sk_ctx -1
execute store result score #drop_owner sk_ctx run data get entity @e[tag=sk.drop,limit=1] Item.components."minecraft:custom_data".skull.owner
execute unless score @s sk_seat = #drop_owner sk_ctx run return 0
execute if items entity @e[tag=sk.drop,limit=1] contents minecraft:paper[minecraft:custom_data~{skull:{card:1b}}] run return run function skull:input/card
scoreboard players set #menu sk_ctx 0
execute if items entity @e[tag=sk.drop,limit=1] contents minecraft:purple_dye[minecraft:custom_data~{skull:{menu:1b}}] run scoreboard players set #menu sk_ctx 1
kill @e[tag=sk.drop,limit=1]
function skull:hand/sync
execute if score #menu sk_ctx matches 1 run function skull:ui/open
