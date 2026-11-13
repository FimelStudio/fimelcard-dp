$execute store result storage xiangqi:private pick.slot int 1 run random value 0..$(max)
$data modify storage xiangqi:private pick.sq set value $(sq)
function xiangqi:engine/covered/pick with storage xiangqi:private pick
