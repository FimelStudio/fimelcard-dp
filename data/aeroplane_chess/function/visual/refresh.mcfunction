function aeroplane_chess:system/context
function aeroplane_chess:visual/clear
function aeroplane_chess:visual/context
execute positioned ~ ~1.02 ~ summon minecraft:item_display run function aeroplane_chess:visual/board with storage aeroplane_chess:visual
data modify storage aeroplane_chess:visual duration set value 0
execute as @e[tag=ac.board,scores={ac_active=1}] run function aeroplane_chess:visual/spawn_plane
execute positioned ~ ~1.035 ~ summon minecraft:item_display run function aeroplane_chess:visual/die_init with storage aeroplane_chess:visual
execute positioned ~ ~1.035 ~ summon minecraft:interaction run function aeroplane_chess:visual/die_click with storage aeroplane_chess:visual
function aeroplane_chess:visual/roll_done
function aeroplane_chess:visual/select
