$execute store result storage splendor:engine draw.pick int 1 run random value 0..$(max)
$data modify storage splendor:engine draw.tier set value $(tier)
function splendor:engine/shuffle_pick with storage splendor:engine draw
