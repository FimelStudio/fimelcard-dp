$data modify storage splendor:visual seat set from entity @s data.splendor.p$(turn).seat
data modify storage splendor:visual capacity set value 4
execute if score @s ct_capacity matches 8 run data modify storage splendor:visual capacity set value 8
function splendor:visual/seat_layout with storage splendor:visual
