scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 3
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 3
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 7
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 7
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 21
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 21
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 25
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 25
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 31
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 31
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 33
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 33
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
