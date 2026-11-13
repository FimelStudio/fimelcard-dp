data modify storage avalon:heads drop set from entity @s Item.components."minecraft:custom_data".avalon
execute on origin if entity @s[tag=av.player,tag=ct.player] unless score @s ct_paused matches 1 run function avalon:input/use_head with storage avalon:heads drop
kill @s
