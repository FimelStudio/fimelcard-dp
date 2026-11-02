# Controller. Macro seat returns relative position in storage cardtable:layout position.
$scoreboard players set #layout_seat ct_ctx $(seat)
execute unless score @s ct_capacity matches 8 run function cardtable:chairs/layout/position4
execute if score @s ct_capacity matches 8 run function cardtable:chairs/layout/position8
