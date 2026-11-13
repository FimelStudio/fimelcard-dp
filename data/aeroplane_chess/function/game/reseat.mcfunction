function aeroplane_chess:system/context
execute as @a[tag=ac.audience] run ride @s dismount
execute as @a[tag=ac.audience] run function aeroplane_chess:player/place_color
function cardtable:table/ensure_seats
execute as @a[tag=ac.audience] at @s run function cardtable:seat/mount
