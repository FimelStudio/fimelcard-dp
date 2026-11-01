function love_letter:game/bump_epoch
function love_letter:visual/refresh
function love_letter:hud/refresh
execute unless score @s ll_timeout matches 1 run function love_letter:ui/refresh
