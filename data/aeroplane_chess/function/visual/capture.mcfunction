function aeroplane_chess:visual/context
data modify storage aeroplane_chess:visual duration set value 6
execute as @e[tag=ac.board,tag=ac.captured] run function aeroplane_chess:visual/capture_plane
