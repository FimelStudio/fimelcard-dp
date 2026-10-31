scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 6
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 6
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 8
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 8
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 24
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 24
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 26
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 26
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
