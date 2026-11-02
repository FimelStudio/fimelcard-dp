$execute store result storage catan:engine rng.pick int 1 run random value 0..$(max) catan:shuffle
$data modify storage catan:engine rng.hex set value $(hex)
function catan:engine/pick_terrain with storage catan:engine rng
