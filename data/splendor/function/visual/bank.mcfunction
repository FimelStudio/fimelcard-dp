$data modify storage splendor:visual count set from entity @s data.splendor.bank[$(slot)]
$data modify storage splendor:visual model set value "$(model)"
$data modify storage splendor:visual slot set value $(slot)
data modify storage splendor:visual kind set value 4
$data modify storage splendor:visual id set value $(slot)
function splendor:visual/bank_pose with storage splendor:visual
function splendor:visual/spawn
function splendor:visual/gem_count with storage splendor:visual
