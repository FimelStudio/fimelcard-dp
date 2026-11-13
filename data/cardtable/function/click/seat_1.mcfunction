# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
execute unless score #version ct_ctx matches 1.. run return 0
# uninstall-guard: end
advancement revoke @s only cardtable:click/seat_1
advancement revoke @s only cardtable:click/seat_1_attack
tag @e[tag=ct.clicked_seat] remove ct.clicked_seat
tag @e[type=minecraft:interaction,tag=ct.seat,scores={ct_seat=1},distance=..5,sort=nearest,limit=1] add ct.clicked_seat
function cardtable:seat/click
