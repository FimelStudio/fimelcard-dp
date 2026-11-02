tag @s add ca.controller
function catan:settings/defaults
execute if score @s ct_state matches 0 run return run function catan:game/preview
function catan:system/context
execute unless data entity @s data.catan.p1 run return run function catan:game/abort
scoreboard players add @s ca_epoch 1
execute store result entity @s data.catan.epoch int 1 run scoreboard players get @s ca_epoch
scoreboard players set @s ca_anim 0
data remove entity @s data.catan.preview
data remove entity @s data.catan.visual_events
function catan:game/sync
function catan:visual/refresh
execute unless score @s ca_state matches 11 run function catan:input/create_surface
function catan:sound/reload
execute as @a[tag=ca.audience] run function catan:input/give
