scoreboard players operation #color ac_ctx = @s ac_color
execute as @e[tag=ac.sides,scores={ac_active=1,ac_bot=0,ac_rank=0}] if score @s ac_color = #color ac_ctx run scoreboard players add #online_active ac_ctx 1
