function catan:visual/context
execute at @s run function catan:visual/update_at
execute unless score @s ca_vkind matches 5 run function catan:visual/dice_done
