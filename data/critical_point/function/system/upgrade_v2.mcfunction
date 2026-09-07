scoreboard objectives add cp_drop_reopen minecraft.dropped:minecraft.purple_dye
scoreboard players set #version cp_ctx 2
execute as @e[type=minecraft:marker,tag=cp.controller,scores={cp_state=3}] at @s run function critical_point:vote/restore_reopen_items
