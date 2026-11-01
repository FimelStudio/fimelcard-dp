function love_letter:system/context
scoreboard players operation #resigning ll_ctx = #actor ll_ctx
function love_letter:engine/resign
execute unless score #ok ll_ctx matches 1 run return 0
function love_letter:sound/eliminate
function love_letter:game/bump_epoch
function love_letter:visual/refresh
function love_letter:engine/check_round
execute if score #over ll_ctx matches 1 run return 0
execute if score #resigning ll_ctx = @s ll_turn run return run function love_letter:game/next_turn
execute if score #resume ll_ctx matches 1 run return run function love_letter:game/next_turn
function love_letter:hud/refresh
function love_letter:ui/refresh
