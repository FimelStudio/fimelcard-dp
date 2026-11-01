$execute store result score @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=$(sq)},limit=1] xq_hidden run data get storage xiangqi:private bag[$(slot)]
$scoreboard players set @e[type=minecraft:marker,tag=xq.board,scores={xq_sq=$(sq)},limit=1] xq_covered 1
$data remove storage xiangqi:private bag[$(slot)]
