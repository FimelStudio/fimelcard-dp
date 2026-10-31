scoreboard players set #hint_saved_from xq_ctx 0
scoreboard players operation #hint_saved_from xq_ctx = #from xq_ctx
scoreboard players set #hint_saved_to xq_ctx 0
scoreboard players operation #hint_saved_to xq_ctx = #to xq_ctx
scoreboard players set #hint_saved_promo xq_ctx 0
scoreboard players operation #hint_saved_promo xq_ctx = #promo xq_ctx
scoreboard players set #hint_saved_target xq_ctx 0
scoreboard players operation #hint_saved_target xq_ctx = #target xq_ctx
scoreboard players set #hint_saved_chosen xq_ctx 0
scoreboard players operation #hint_saved_chosen xq_ctx = #chosen xq_ctx
scoreboard players set #hint_saved_legal xq_ctx 0
scoreboard players operation #hint_saved_legal xq_ctx = #legal xq_ctx
scoreboard players set #hint_saved_piece xq_ctx 0
scoreboard players operation #hint_saved_piece xq_ctx = #piece xq_ctx
scoreboard players set #hint_saved_side xq_ctx 0
scoreboard players operation #hint_saved_side xq_ctx = #side xq_ctx
function xiangqi:system/context
function xiangqi:visual/context
function xiangqi:engine/cache
scoreboard players operation #hint_from xq_ctx = @s xq_sel
execute store result storage xiangqi:visual hint_from int 1 run scoreboard players get #hint_from xq_ctx
execute if score #cache_ok xq_ctx matches 1 run function xiangqi:hints/source with storage xiangqi:visual
execute if score #cache_ok xq_ctx matches 1 if score #hint_kind xq_ctx matches 1..7 run function xiangqi:hints/destinations
scoreboard players operation #from xq_ctx = #hint_saved_from xq_ctx
scoreboard players operation #to xq_ctx = #hint_saved_to xq_ctx
scoreboard players operation #promo xq_ctx = #hint_saved_promo xq_ctx
scoreboard players operation #target xq_ctx = #hint_saved_target xq_ctx
scoreboard players operation #chosen xq_ctx = #hint_saved_chosen xq_ctx
scoreboard players operation #legal xq_ctx = #hint_saved_legal xq_ctx
scoreboard players operation #piece xq_ctx = #hint_saved_piece xq_ctx
scoreboard players operation #side xq_ctx = #hint_saved_side xq_ctx
