scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 36
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 36
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 46
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 46
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 54
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 54
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
