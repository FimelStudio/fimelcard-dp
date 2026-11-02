data modify storage catan:visual seat set value 0
execute if data storage catan:visual event.seat run data modify storage catan:visual seat set from storage catan:visual event.seat
execute unless data storage catan:visual event.seat run function catan:visual/owner_seat with storage catan:visual event
function catan:visual/seat_coordinate with storage catan:visual
