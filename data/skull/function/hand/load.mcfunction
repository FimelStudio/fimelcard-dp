execute store result storage skull:io hand.epoch int 1 run scoreboard players get @s sk_epoch
$data modify storage skull:io cards set from entity @s data.skull.seats.s$(seat).hand
execute if data storage skull:io cards[0] run function skull:hand/give_loop
