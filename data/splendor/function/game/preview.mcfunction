execute unless score @s ct_game matches 22 run return 0
execute unless score @s ct_state matches 0 run return 0
function splendor:system/context
execute if data entity @s data.splendor{review:1b} run return run function splendor:visual/refresh
scoreboard players set #players sp_ctx 4
function splendor:engine/init
function splendor:game/sync
scoreboard players set @s sp_state 0
scoreboard players set @s sp_anim 0
function splendor:visual/preview
