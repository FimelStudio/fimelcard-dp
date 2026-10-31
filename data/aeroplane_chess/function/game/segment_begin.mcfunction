tag @e[tag=ac.captured] remove ac.captured
execute unless data entity @s data.aeroplane_chess.queue[0] run return run function aeroplane_chess:game/move_done
scoreboard players operation #color ac_ctx = @s ac_turn
scoreboard players operation #plane ac_ctx = @s ac_selected
execute as @e[tag=ac.board] if score @s ac_color = #color ac_ctx if score @s ac_plane = #plane ac_ctx run scoreboard players operation @e[tag=ac.current,limit=1] ac_frompos = @s ac_pos
execute store result score @s ac_topos run data get entity @s data.aeroplane_chess.queue[0].pos
execute store result score @s ac_kind run data get entity @s data.aeroplane_chess.queue[0].kind
execute store result score @s ac_land run data get entity @s data.aeroplane_chess.queue[0].land
scoreboard players set @s ac_timer 4
execute if score @s ac_speed matches 1 run scoreboard players set @s ac_timer 2
execute if score @s ac_kind matches 1 run function aeroplane_chess:sound/takeoff
execute if score @s ac_kind matches 2 run function aeroplane_chess:sound/jump
execute if score @s ac_kind matches 3 run function aeroplane_chess:sound/fly
execute if score @s ac_kind matches 0 run function aeroplane_chess:sound/move
function aeroplane_chess:visual/move
