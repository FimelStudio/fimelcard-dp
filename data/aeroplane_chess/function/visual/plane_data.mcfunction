execute store result storage aeroplane_chess:visual color int 1 run scoreboard players get @s ac_color
execute store result storage aeroplane_chess:visual plane int 1 run scoreboard players get @s ac_plane
scoreboard players operation #vis_index ac_ctx = @s ac_pos
scoreboard players add #vis_index ac_ctx 1
execute store result storage aeroplane_chess:visual index int 1 run scoreboard players get #vis_index ac_ctx
function aeroplane_chess:visual/coord with storage aeroplane_chess:visual
function aeroplane_chess:visual/color_name
