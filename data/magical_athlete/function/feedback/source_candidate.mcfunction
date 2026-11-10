$data modify storage magical_athlete:feedback source_racer set from entity @s data.magical_athlete.racers[$(index)]
$execute unless data storage magical_athlete:feedback source_racer{power:$(power)} run return 0
scoreboard players add #source_count ma_ctx 1
$data modify storage magical_athlete:feedback source.source_actor set value $(index)
