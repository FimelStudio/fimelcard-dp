function love_letter:system/context
function love_letter:engine/start_turn
function love_letter:game/bump_epoch
scoreboard players set @s ll_anim 8
scoreboard players set @s ll_timeout 0
scoreboard players operation @s ll_clock = @s ll_time_setting
scoreboard players set #twenty ll_ctx 20
scoreboard players operation @s ll_clock *= #twenty ll_ctx
scoreboard players operation #deal_seat ll_ctx = @s ll_turn
function love_letter:deal/launch
function love_letter:visual/refresh
function love_letter:hud/refresh
