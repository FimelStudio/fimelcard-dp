data modify entity @s data.catan.last set from entity @s data.catan.anim_production[0]
data modify entity @s data.catan.last.kind set value "production"
data modify entity @s data.catan.last.target set from entity @s data.catan.last.hex
function catan:game/event_seats with entity @s data.catan.last
function catan:visual/animate
data remove entity @s data.catan.anim_production[0]
execute if data entity @s data.catan.anim_production[0] run function catan:game/production
