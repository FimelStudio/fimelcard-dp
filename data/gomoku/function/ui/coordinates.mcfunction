function gomoku:input/context
execute unless entity @s[tag=gm.actor] run return 0
execute unless entity @e[tag=gm.current,scores={gm_state=1},limit=1] run return 0
execute unless score @s gm_side = @e[tag=gm.current,limit=1] gm_turn run return 0
# 四位nonce + 行 + 0 + 列；行列1～19的十进制串无歧义，最长九位。
execute if score #coord_serial gm_ctx matches 9999.. run scoreboard players add #ui_load gm_ctx 1
execute unless score #coord_serial gm_ctx matches 999..9998 run scoreboard players set #coord_serial gm_ctx 999
scoreboard players add #coord_serial gm_ctx 1
scoreboard players operation @s gm_coordnonce = #coord_serial gm_ctx
scoreboard players operation @s gm_coordepoch = @e[tag=gm.current,limit=1] gm_epoch
scoreboard players operation @s gm_coordload = #ui_load gm_ctx
scoreboard players operation @s gm_coordtable = @s gm_table
scoreboard players set @s gm_coord 0
scoreboard players enable @s gm_coord
execute store result storage gomoku:coordinates nonce int 1 run scoreboard players get @s gm_coordnonce
execute store result storage gomoku:coordinates size int 1 run scoreboard players get @e[tag=gm.current,limit=1] gm_size
data modify storage gomoku:coordinates row set value "$(row)"
data modify storage gomoku:coordinates col set value "$(col)"
function gomoku:ui/coordinates_show with storage gomoku:coordinates
tag @a[tag=gm.actor] remove gm.actor
