function aeroplane_chess:game/actor_guard
execute unless score #actor_ok ac_ctx matches 1 run return 0
execute if score @s ac_state matches 0 run return 0
execute if score @s ac_state matches 5 run return 0
scoreboard players operation #resigning ac_ctx = @e[tag=ac.actor,limit=1] ac_color
scoreboard players set #rank ac_ctx -1
execute as @e[tag=ac.sides] if score @s ac_color = #resigning ac_ctx run scoreboard players operation #rank ac_ctx = @s ac_rank
execute unless score #rank ac_ctx matches 0 run return 0
execute as @e[tag=ac.sides] if score @s ac_color = #resigning ac_ctx run scoreboard players set @s ac_rank 99
scoreboard players add @s ac_ranked 1
tellraw @a[tag=ac.audience] {"text": "[飞行棋] 一方已认输退出本局。", "color": "yellow"}
scoreboard players operation #remaining ac_ctx = @s ac_players
scoreboard players operation #remaining ac_ctx -= @s ac_ranked
execute if score #remaining ac_ctx matches ..1 run return run function aeroplane_chess:game/last_side
execute if score #resigning ac_ctx = @s ac_turn run data remove entity @s data.aeroplane_chess.queue
execute if score #resigning ac_ctx = @s ac_turn run function aeroplane_chess:game/next_turn
