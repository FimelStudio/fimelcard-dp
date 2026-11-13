$execute as @e[tag=ac.man,scores={ac_color=$(color),ac_plane=$(plane)}] if score @s ct_id = #vis_table ac_ctx run function aeroplane_chess:visual/plane_pose with storage aeroplane_chess:visual
