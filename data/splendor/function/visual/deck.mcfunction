$data modify storage splendor:visual model set value "back/tier$(tier)"
$data modify storage splendor:visual slot set value $(slot)
data modify storage splendor:visual kind set value 5
$data modify storage splendor:visual id set value $(slot)
function splendor:visual/deck_pose with storage splendor:visual
function splendor:visual/spawn
$execute store result storage splendor:visual count int 1 run data get entity @s data.splendor.deck$(tier)
function splendor:visual/deck_count with storage splendor:visual
