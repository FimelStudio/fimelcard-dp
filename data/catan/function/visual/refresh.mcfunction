function catan:visual/clear
function catan:visual/context
execute at @s run function catan:visual/refresh_at
# direct-v2
execute if score @s ct_state matches 1 unless data entity @s data.catan{review:1b} run function catan:direct/deck_spawn
