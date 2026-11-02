$execute at @e[tag=ca.current,limit=1] positioned ~-4 ~-8 ~$(offset) if entity @e[type=minecraft:marker,tag=ca.ray,dx=7,dy=15,dz=7,limit=1] run scoreboard players set #greater ca_ctx 1
