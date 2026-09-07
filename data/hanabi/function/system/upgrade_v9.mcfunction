scoreboard objectives add hb_drop_reward minecraft.dropped:minecraft.purple_dye
scoreboard players set #version hb_ctx 9
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=2,hb_reward_pending=1..}] at @s run function hanabi:reward/reopen
