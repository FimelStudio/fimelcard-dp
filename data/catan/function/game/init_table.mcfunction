tag @s add ca.controller
function catan:settings/defaults
execute if score @s ct_state matches 0 run function catan:game/preview
