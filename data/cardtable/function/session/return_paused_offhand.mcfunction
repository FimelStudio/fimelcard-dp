execute if items entity @s weapon.mainhand * run return run function cardtable:session/swap_paused_hands
item replace entity @s weapon.mainhand from entity @s weapon.offhand
item replace entity @s weapon.offhand with minecraft:air
