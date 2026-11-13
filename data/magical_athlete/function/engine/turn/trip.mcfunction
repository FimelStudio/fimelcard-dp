scoreboard players set #tripped ma_ctx 0
$execute store result score #tripped ma_ctx run data get storage magical_athlete:engine s.racers[$(pawn)].trip
execute unless score #tripped ma_ctx matches 1 run return 0
$data modify storage magical_athlete:engine s.racers[$(pawn)].trip set value 0
$data modify storage magical_athlete:engine s.events append value {kind:4,pawn:$(pawn),from:0,to:0,source:-2,amount:0,die:0}
data modify storage magical_athlete:engine s.queue append value {"type":"turn_end"}
scoreboard players set #tripped ma_ctx 1
