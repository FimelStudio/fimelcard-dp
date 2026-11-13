function catan:visual/context
function catan:visual/clear_selection
execute unless data entity @s data.catan.preview run return 0
data modify storage catan:visual selection set from entity @s data.catan.preview
execute at @s run function catan:visual/selection with storage catan:visual selection
