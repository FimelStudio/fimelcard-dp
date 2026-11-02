$execute unless data entity @s data.skull.seats.s$(seat) run return 0
$data modify entity @s data.skull.seats.s$(seat).hand set from entity @s data.skull.seats.s$(seat).owned
$data modify entity @s data.skull.seats.s$(seat).stack set value []
$data modify entity @s data.skull.seats.s$(seat).visible set value []
