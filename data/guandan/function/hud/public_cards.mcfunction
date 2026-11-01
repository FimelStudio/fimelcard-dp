execute unless data storage guandan:hud shown[0] run return 0
execute store result score #public_type gd_ctx run data get storage guandan:hud shown[0]
function guandan:hud/public_type
data remove storage guandan:hud shown[0]
function guandan:hud/public_cards
