data modify entity @e[tag=cp.card_drop,limit=1] PickupDelay set value 0s
tp @e[tag=cp.card_drop,limit=1] @s
tag @e[tag=cp.card_drop] remove cp.card_drop
tag @e[tag=cp.current] remove cp.current
