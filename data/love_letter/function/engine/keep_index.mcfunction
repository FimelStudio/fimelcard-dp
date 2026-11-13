$execute store result score @e[tag=ll.engine_actor,limit=1] ll_hand run data get entity @s data.ll_buffer[$(index)]
$data remove entity @s data.ll_buffer[$(index)]
