function splendor:system/context
function splendor:sound/stop
function splendor:visual/clear
execute as @e[tag=sp.firework] if score @s ct_id = #table sp_ctx run kill @s
execute as @a[tag=sp.audience] run function splendor:player/clear_state
function splendor:settings/invalidate_table
data remove entity @s data.splendor
tag @s remove sp.controller
