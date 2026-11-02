# 两手都有物品时只交换，绝不覆盖玩家原本的副手物品。
summon minecraft:item ~ ~ ~ {Tags:["ct.pause_swap"],Item:{id:"minecraft:stone",count:1},PickupDelay:32767s}
item replace entity @e[type=minecraft:item,tag=ct.pause_swap,limit=1] contents from entity @s weapon.mainhand
item replace entity @s weapon.mainhand from entity @s weapon.offhand
item replace entity @s weapon.offhand from entity @e[type=minecraft:item,tag=ct.pause_swap,limit=1] contents
kill @e[type=minecraft:item,tag=ct.pause_swap]
