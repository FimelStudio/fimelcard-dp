execute store result storage skull:io args.seat int 1 run scoreboard players get @s sk_seat
execute as @e[type=minecraft:marker,tag=sk.initializing,limit=1] run function skull:deck/init_seat with storage skull:io args
