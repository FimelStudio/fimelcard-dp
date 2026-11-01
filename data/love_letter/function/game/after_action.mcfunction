function love_letter:system/context
function love_letter:game/bump_epoch
function love_letter:game/announce
execute if score @s ll_card matches 4 run function love_letter:sound/seal
execute if score @s ll_card matches 7 if score @s ll_target matches 1..8 run function love_letter:sound/swap
execute if data entity @s data.love_letter.action.eliminated[0] run function love_letter:sound/eliminate
function love_letter:ui/private
function love_letter:visual/event
function love_letter:visual/refresh
function love_letter:engine/check_round
execute if score #over ll_ctx matches 1 run return 0
function love_letter:game/next_turn
