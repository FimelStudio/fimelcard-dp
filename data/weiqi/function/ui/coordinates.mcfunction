function weiqi:input/context
execute unless entity @s[tag=go.actor] run return 0
execute unless entity @e[tag=go.current,scores={go_state=1},limit=1] run return 0
execute unless score @s go_side = @e[tag=go.current,limit=1] go_turn run return 0
execute if score #coord_serial go_ctx matches 9999.. run scoreboard players add #ui_load go_ctx 1
execute unless score #coord_serial go_ctx matches 999..9998 run scoreboard players set #coord_serial go_ctx 999
scoreboard players add #coord_serial go_ctx 1
scoreboard players operation @s go_coordnonce = #coord_serial go_ctx
scoreboard players operation @s go_coordepoch = @e[tag=go.current,limit=1] go_epoch
scoreboard players operation @s go_coordload = #ui_load go_ctx
scoreboard players operation @s go_coordtable = @s go_table
scoreboard players set @s go_coord 0
scoreboard players enable @s go_coord
execute store result storage weiqi:coordinates nonce int 1 run scoreboard players get @s go_coordnonce
execute store result storage weiqi:coordinates size int 1 run scoreboard players get @e[tag=go.current,limit=1] go_size
data modify storage weiqi:coordinates row set value "$(row)"
data modify storage weiqi:coordinates col set value "$(col)"
execute if entity @e[tag=go.current,scores={go_size=13},limit=1] run function weiqi:ui/coordinates_13 with storage weiqi:coordinates
execute if entity @e[tag=go.current,scores={go_size=15},limit=1] run function weiqi:ui/coordinates_15 with storage weiqi:coordinates
execute if entity @e[tag=go.current,scores={go_size=19},limit=1] run function weiqi:ui/coordinates_19 with storage weiqi:coordinates
tag @a[tag=go.actor] remove go.actor
