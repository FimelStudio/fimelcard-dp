function aeroplane_chess:settings/invalidate_table
function aeroplane_chess:system/context
execute as @a[tag=ac.player] if score @s ac_table = #table ac_ctx run function aeroplane_chess:player/clear_state
function aeroplane_chess:visual/clear
kill @e[tag=ac.board]
kill @e[tag=ac.sides]
data remove entity @s data.aeroplane_chess
data remove entity @s data.aeroplane_visual
tag @s remove ac.controller
tag @s remove ac.current
scoreboard players set @s ac_state 0
