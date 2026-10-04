advancement revoke @s only cardtable:click/seat_7
advancement revoke @s only cardtable:click/seat_7_attack
tag @e[tag=ct.clicked_seat] remove ct.clicked_seat
tag @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=7},distance=..5,sort=nearest,limit=1] add ct.clicked_seat
function cardtable:seat/click
