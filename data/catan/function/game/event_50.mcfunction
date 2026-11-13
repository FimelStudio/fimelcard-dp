data modify entity @s data.catan.last.kind set value "trade"
data modify entity @s data.catan.last.owner set from storage catan:runtime event.actor
function catan:game/event_seats with entity @s data.catan.last
function catan:visual/animate
function catan:sound/trade
function catan:game/log_event
