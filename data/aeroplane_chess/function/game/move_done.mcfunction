function aeroplane_chess:visual/refresh
execute if score @s ac_topos matches 57 run function aeroplane_chess:sound/home
scoreboard players set #home ac_ctx 0
scoreboard players operation #color ac_ctx = @s ac_turn
execute as @e[tag=ac.board,scores={ac_pos=57}] if score @s ac_color = #color ac_ctx run scoreboard players add #home ac_ctx 1
execute if score #home ac_ctx matches 4 run function aeroplane_chess:game/rank_side
execute if score @s ac_state matches 5 run return 0
function aeroplane_chess:game/action_done
