$data modify storage splendor:visual card set from entity @s data.splendor.market[$(slot)]
execute if data storage splendor:visual {card:-1} run return 0
$data modify storage splendor:visual slot set value $(slot)
data modify storage splendor:visual kind set value 2
$data modify storage splendor:visual id set value $(slot)
function splendor:visual/card_model with storage splendor:visual
function splendor:visual/card_pose with storage splendor:visual
function splendor:visual/spawn
