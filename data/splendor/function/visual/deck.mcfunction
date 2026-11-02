$execute unless data entity @s data.splendor.deck$(tier)[0] run return 0
$data modify storage splendor:visual model set value "back/tier$(tier)"
$data modify storage splendor:visual slot set value $(slot)
data modify storage splendor:visual kind set value 5
$data modify storage splendor:visual id set value $(slot)
function splendor:visual/deck_pose with storage splendor:visual
function splendor:visual/spawn
