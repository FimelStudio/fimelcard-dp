function catan:system/context
function catan:input/clear_surface
function catan:sound/stop
scoreboard players set @s ca_state 0
scoreboard players set @s ca_anim 0
scoreboard players add @s ca_epoch 1
execute store result entity @s data.catan.epoch int 1 run scoreboard players get @s ca_epoch
data remove entity @s data.catan.preview
function catan:visual/refresh
