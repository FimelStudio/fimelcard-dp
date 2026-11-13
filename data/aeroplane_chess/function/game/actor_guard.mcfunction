function aeroplane_chess:system/context
scoreboard players set #actor_ok ac_ctx 0
execute as @e[tag=ac.actor,tag=ac.audience,limit=1] if score @s ac_table = #table ac_ctx run scoreboard players set #actor_ok ac_ctx 1
