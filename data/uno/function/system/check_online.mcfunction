function uno:system/context
scoreboard players set @s un_clock 0
scoreboard players set #u_online un_ctx 0
execute as @e[tag=un.audience,tag=ct.player] if score @s ct_id = #table un_ctx run scoreboard players add #u_online un_ctx 1
execute unless score #u_online un_ctx = @s un_size run function uno:game/player_left
