function guandan:system/context
function guandan:visual/context
data modify storage guandan:visual exchanges set value []
data modify storage guandan:visual exchanges set from entity @s data.guandan.exchange
execute if data storage guandan:visual exchanges[0] run function guandan:visual/tribute_loop
function guandan:visual/refresh
