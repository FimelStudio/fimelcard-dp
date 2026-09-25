data modify storage skull:io hand.slot set from storage skull:io cards[0].slot
data modify storage skull:io hand.model set from storage skull:io cards[0].model
data modify storage skull:io hand.name set from storage skull:io cards[0].name
execute as @a[tag=sk.receiver,limit=1] run function skull:hand/give with storage skull:io hand
data remove storage skull:io cards[0]
execute if data storage skull:io cards[0] run function skull:hand/give_loop
