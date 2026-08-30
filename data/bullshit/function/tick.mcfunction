execute as @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=1}] at @s run function bullshit:round/tick_question
execute as @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=3,bw_timer=1..}] run scoreboard players remove @s bw_timer 1
execute as @e[type=minecraft:marker,tag=bw.controller,scores={bw_state=3,bw_timer=..0}] at @s run function bullshit:game/return_lobby
execute as @a[tag=bw.player,scores={bw_drop=1..}] at @s run function bullshit:input/q
execute as @a[tag=bw.player,scores={bw_drop_dye=1..}] at @s run function bullshit:input/q_dye
execute as @a[tag=bw.smart,scores={bw_action=1..}] at @s run function bullshit:action/handle
