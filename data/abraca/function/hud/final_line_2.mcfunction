execute as @a[tag=ab.player,scores={ab_seat=2}] if score @s ab_id = #ctx ab_ctx at @s run function hanabi:name/resolve
execute as @a[tag=ab.player,scores={ab_seat=2}] if score @s ab_id = #ctx ab_ctx run data modify storage abraca:hud line2 set from storage hanabi:name resolved
execute as @a[tag=ab.player,scores={ab_seat=2}] if score @s ab_id = #ctx ab_ctx run execute store result storage abraca:hud hp2 int 1 run scoreboard players get @s ab_hp
