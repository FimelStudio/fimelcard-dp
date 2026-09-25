scoreboard players set @s sk_timer 10
$execute unless data entity @s data.skull.seats.s$(seat).stack[-1] run return 0
scoreboard players operation @s sk_source = @s sk_lead
function skull:challenge/flip with storage skull:io flip
