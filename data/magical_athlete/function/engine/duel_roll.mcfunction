execute store result score #duel_a ma_ctx run random value 1..6
execute store result score #duel_b ma_ctx run random value 1..6
$data modify storage magical_athlete:engine add set value {type:"move",pawn:$(pawn),amount:2,source:9}
$execute if score #duel_a ma_ctx < #duel_b ma_ctx run data modify storage magical_athlete:engine add.pawn set value $(target)
$data modify storage magical_athlete:engine add.author set value $(pawn)
data modify storage magical_athlete:engine s.queue prepend from storage magical_athlete:engine add
