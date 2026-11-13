function aeroplane_chess:system/context
function aeroplane_chess:visual/finish_move
scoreboard players operation #color ac_ctx = @s ac_turn
scoreboard players operation #plane ac_ctx = @s ac_selected
execute as @e[tag=ac.board] if score @s ac_color = #color ac_ctx if score @s ac_plane = #plane ac_ctx run scoreboard players operation @s ac_pos = @e[tag=ac.current,limit=1] ac_topos
execute if score @s ac_land matches 1 run function aeroplane_chess:engine/land
data remove entity @s data.aeroplane_chess.queue[0]
execute if entity @e[tag=ac.board,tag=ac.captured] run return run function aeroplane_chess:game/capture_wait
function aeroplane_chess:game/segment_begin
