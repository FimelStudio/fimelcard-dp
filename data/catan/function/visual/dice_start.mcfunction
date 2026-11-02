execute unless data entity @s data.catan.visual_active.die1 run data modify entity @s data.catan.visual_active.die1 set from entity @s data.catan.dice[0]
execute unless data entity @s data.catan.visual_active.die2 run data modify entity @s data.catan.visual_active.die2 set from entity @s data.catan.dice[1]
function catan:visual/dice_tick
