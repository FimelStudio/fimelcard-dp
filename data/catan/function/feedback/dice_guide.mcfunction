data modify storage catan:feedback pose.x set from entity @s transformation.translation[0]
data modify storage catan:feedback pose.y set from entity @s transformation.translation[1]
data modify storage catan:feedback pose.z set from entity @s transformation.translation[2]
function catan:feedback/dice_particle with storage catan:feedback pose
