scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 14
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 14
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 16
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 16
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
scoreboard players set #to xq_ctx 40
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 40
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 44
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 44
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 50
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 50
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
scoreboard players operation #from xq_ctx = #hint_from xq_ctx
scoreboard players set #to xq_ctx 52
function xiangqi:engine/check_move
execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx 52
execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display
