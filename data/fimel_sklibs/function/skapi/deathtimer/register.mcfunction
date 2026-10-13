
$scoreboard players set @s fcs_life $(time)
$data modify storage fimel_sklibs:runtime deathtimer.temp.events set value $(events)

function fimel_sklibs:skapi/deathtimer/_register_0 with entity @s
