execute unless entity @s[tag=sk.player] run return 0
execute unless score @s ct_id = @s sk_id run return 0
tag @a[tag=sk.viewer] remove sk.viewer
tag @s add sk.viewer
scoreboard players operation @s sk_ui_table = @s sk_id
scoreboard players set @s sk_action 0
scoreboard players enable @s sk_action
scoreboard players operation #view_table sk_ctx = @s sk_id
scoreboard players operation #view_seat sk_ctx = @s sk_seat
execute store result storage skull:ui view.seat int 1 run scoreboard players get @s sk_seat
execute as @e[type=minecraft:marker,tag=sk.controller] if score @s sk_id = #view_table sk_ctx run function skull:ui/build
tag @s remove sk.viewer
