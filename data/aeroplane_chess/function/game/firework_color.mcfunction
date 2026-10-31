function aeroplane_chess:system/context
execute as @a[tag=ac.audience] if score @s ac_color = #winning ac_ctx at @s run function aeroplane_chess:game/firework_player
scoreboard players set #bot_winner ac_ctx 0
execute as @e[tag=ac.sides,scores={ac_active=1,ac_bot=1}] if score @s ac_color = #winning ac_ctx run scoreboard players set #bot_winner ac_ctx 1
execute if score #bot_winner ac_ctx matches 1 run function aeroplane_chess:game/firework_bot
