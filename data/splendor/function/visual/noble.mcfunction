$data modify storage splendor:visual noble set from entity @s data.splendor.nobles[$(slot)]
execute if data storage splendor:visual {noble:-1} run return 0
$data modify storage splendor:visual slot set value $(slot)
data modify storage splendor:visual kind set value 3
$data modify storage splendor:visual id set value $(slot)
function splendor:visual/noble_model with storage splendor:visual
function splendor:visual/noble_pose with storage splendor:visual
function splendor:visual/spawn
