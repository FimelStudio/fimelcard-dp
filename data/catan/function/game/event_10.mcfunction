data modify entity @s data.catan.last.kind set value "dice"
data modify entity @s data.catan.last.owner set from storage catan:runtime event.actor
data modify entity @s data.catan.last.die1 set from entity @s data.catan.dice[0]
data modify entity @s data.catan.last.die2 set from entity @s data.catan.dice[1]
function catan:game/event_seats with entity @s data.catan.last
function catan:visual/animate
function catan:sound/roll
function catan:game/log_event
