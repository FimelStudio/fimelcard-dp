execute as @a[tag=hb.player] at @s run function hanabi:system/recover_orphan_player
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=1..2}] at @s run function hanabi:system/maintenance_one
