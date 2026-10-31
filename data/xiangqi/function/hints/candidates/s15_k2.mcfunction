scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 4
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 4
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 8
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 8
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 22
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 22
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 26
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 26
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 32
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 32
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 34
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 34
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
