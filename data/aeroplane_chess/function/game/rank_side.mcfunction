scoreboard players add @s ac_ranked 1
scoreboard players add @s ac_finished 1
execute as @e[tag=ac.sides] if score @s ac_color = #color ac_ctx run scoreboard players operation @s ac_rank = @e[tag=ac.current,limit=1] ac_finished
execute if score @s ac_winner matches -1 run scoreboard players operation @s ac_winner = @s ac_turn
execute store result storage aeroplane_chess:runtime rank.rank int 1 run scoreboard players get @s ac_finished
function aeroplane_chess:game/announce_rank with storage aeroplane_chess:runtime rank
function aeroplane_chess:game/firework
scoreboard players operation #remaining ac_ctx = @s ac_players
scoreboard players operation #remaining ac_ctx -= @s ac_ranked
execute if score @s ac_ranking matches 0 run return run function aeroplane_chess:game/finish
execute if score #remaining ac_ctx matches ..1 run return run function aeroplane_chess:game/last_side
scoreboard players set @s ac_sixes 0
