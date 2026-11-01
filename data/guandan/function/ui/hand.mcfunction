tag @e[tag=gd.uicards] remove gd.uicards
execute as @e[tag=gd.cards] if score @s gd_owner = #ui_seat gd_ctx run tag @s add gd.uicards
execute as @e[tag=gd.uicards] run function guandan:ui/card_key
data modify storage guandan:ui stack_columns set value []
scoreboard players set #ui_previous gd_ctx -1
scoreboard players set #ui_depth gd_ctx 0
scoreboard players set #ui_maxdepth gd_ctx 0
function guandan:ui/next_card
tag @e[tag=gd.uicards] remove gd.uicards
function guandan:ui/grid
