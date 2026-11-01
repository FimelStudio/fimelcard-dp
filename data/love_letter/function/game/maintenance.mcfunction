scoreboard players set @s ll_tick 0
function love_letter:system/context
scoreboard players set #online ll_ctx 0
execute as @a[tag=ll.audience] run scoreboard players add #online ll_ctx 1
execute unless score #online ll_ctx = @s ll_players run return run function love_letter:game/player_left
function love_letter:hud/refresh
