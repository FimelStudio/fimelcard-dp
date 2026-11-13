function guandan:system/context
function guandan:visual/context
data modify storage guandan:visual seat set from entity @s data.guandan.action.seat
data modify storage guandan:visual public set from entity @s data.guandan.action.cardtypes
execute store result storage guandan:visual count int 1 run data get storage guandan:visual public
function guandan:visual/group_layout with storage guandan:visual
scoreboard players set #index gd_ctx 0
scoreboard players set #effect gd_ctx 1
function guandan:visual/group_loop
function guandan:visual/refresh
