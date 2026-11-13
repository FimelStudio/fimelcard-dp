function splendor:system/context
function splendor:sound/stop
data modify entity @s data.splendor.review set value 1b
function splendor:visual/refresh
execute as @e[tag=sp.firework] if score @s ct_id = #table sp_ctx run kill @s
execute as @a[tag=sp.audience] run function splendor:player/clear_state
scoreboard players set @s sp_anim 0
scoreboard players set @s sp_finish 0
function splendor:settings/invalidate_table
function cardtable:game/return_lobby
