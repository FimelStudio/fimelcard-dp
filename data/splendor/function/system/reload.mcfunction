tag @s add sp.controller
function splendor:settings/defaults
execute if score @s ct_state matches 0 run return run function splendor:game/preview
function splendor:system/context
execute unless data entity @s data.splendor.p1 run return run function splendor:game/abort
data remove entity @s data.splendor.preview
scoreboard players set @s sp_anim 0
function splendor:game/sync
execute as @a[tag=sp.audience] run function splendor:direct/reset
function splendor:visual/refresh
function splendor:sound/reload
execute as @a[tag=sp.audience] run function splendor:input/give
