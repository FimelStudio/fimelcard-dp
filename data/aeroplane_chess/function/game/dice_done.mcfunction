function aeroplane_chess:system/context
function aeroplane_chess:visual/roll_done
function aeroplane_chess:sound/dice_land
execute store result storage aeroplane_chess:runtime rolled.dice int 1 run scoreboard players get @s ac_roll
function aeroplane_chess:ui/color_name
data modify storage aeroplane_chess:runtime rolled.color set from storage aeroplane_chess:ui color
function aeroplane_chess:game/announce_roll with storage aeroplane_chess:runtime rolled
execute if score @s ac_roll matches 6 run scoreboard players add @s ac_sixes 1
execute unless score @s ac_roll matches 6 run scoreboard players set @s ac_sixes 0
execute if score @s ac_triple matches 1 if score @s ac_sixes matches 3.. run return run function aeroplane_chess:game/triple_six
scoreboard players set @s ac_state 3
scoreboard players set @s ac_wait 10
function aeroplane_chess:engine/legal_planes
execute if score #available ac_ctx matches 0 run return run function aeroplane_chess:game/no_moves
scoreboard players add @s ac_epoch 1
function aeroplane_chess:ui/refresh
