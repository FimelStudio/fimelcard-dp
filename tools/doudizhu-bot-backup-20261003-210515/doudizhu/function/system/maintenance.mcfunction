function doudizhu:player/audience
scoreboard players set #online dd_ctx 0
execute as @a[tag=dd.audience,tag=ct.player] if score @s ct_id = #ctx dd_ctx run scoreboard players add #online dd_ctx 1
execute unless score #online dd_ctx matches 3 run return run function doudizhu:game/player_left
execute unless score @s dd_state matches 1 run function doudizhu:system/refresh
tag @a[tag=dd.audience] remove dd.audience
