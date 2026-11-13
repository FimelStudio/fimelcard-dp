$execute if data entity @s data.splendor.p$(turn).seat run function splendor:visual/read_seat {seat:0,turn:$(turn)}
$data modify storage splendor:visual bonus set from entity @s data.splendor.p$(turn).bonus
