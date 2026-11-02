execute unless data entity @s data.catan.last.kind run return 0
execute unless data entity @s data.catan.visual_events run data modify entity @s data.catan.visual_events set value []
data modify entity @s data.catan.visual_events append from entity @s data.catan.last
execute unless score @s ca_vtimer matches 1.. run function catan:visual/start_next
