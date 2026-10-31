scoreboard players set #hint_saved_from ch_ctx 0
scoreboard players operation #hint_saved_from ch_ctx = #from ch_ctx
scoreboard players set #hint_saved_to ch_ctx 0
scoreboard players operation #hint_saved_to ch_ctx = #to ch_ctx
scoreboard players set #hint_saved_promo ch_ctx 0
scoreboard players operation #hint_saved_promo ch_ctx = #promo ch_ctx
scoreboard players set #hint_saved_target ch_ctx 0
scoreboard players operation #hint_saved_target ch_ctx = #target ch_ctx
scoreboard players set #hint_saved_chosen ch_ctx 0
scoreboard players operation #hint_saved_chosen ch_ctx = #chosen ch_ctx
scoreboard players set #hint_saved_legal ch_ctx 0
scoreboard players operation #hint_saved_legal ch_ctx = #legal ch_ctx
scoreboard players set #hint_saved_piece ch_ctx 0
scoreboard players operation #hint_saved_piece ch_ctx = #piece ch_ctx
scoreboard players set #hint_saved_side ch_ctx 0
scoreboard players operation #hint_saved_side ch_ctx = #side ch_ctx
function chess:system/context
function chess:visual/context
function chess:engine/cache
scoreboard players operation #hint_from ch_ctx = @s ch_sel
scoreboard players set #promo ch_ctx 5
execute if score #cache_ok ch_ctx matches 1 run function chess:hints/destinations
scoreboard players operation #from ch_ctx = #hint_saved_from ch_ctx
scoreboard players operation #to ch_ctx = #hint_saved_to ch_ctx
scoreboard players operation #promo ch_ctx = #hint_saved_promo ch_ctx
scoreboard players operation #target ch_ctx = #hint_saved_target ch_ctx
scoreboard players operation #chosen ch_ctx = #hint_saved_chosen ch_ctx
scoreboard players operation #legal ch_ctx = #hint_saved_legal ch_ctx
scoreboard players operation #piece ch_ctx = #hint_saved_piece ch_ctx
scoreboard players operation #side ch_ctx = #hint_saved_side ch_ctx
