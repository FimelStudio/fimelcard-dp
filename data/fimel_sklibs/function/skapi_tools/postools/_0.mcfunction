

execute store result storage fimel_sklibs:runtime temp.postool.x1 int 1 run scoreboard players operation #postool.x1 fcs_lib = #postool.x2 fcs_lib
execute store result storage fimel_sklibs:runtime temp.postool.y1 int 1 run scoreboard players operation #postool.y1 fcs_lib = #postool.y2 fcs_lib
execute store result storage fimel_sklibs:runtime temp.postool.z1 int 1 run scoreboard players operation #postool.z1 fcs_lib = #postool.z2 fcs_lib

execute store result storage fimel_sklibs:runtime temp.postool.x2 int 1 store result score #postool.x2 fcs_lib store result score #postool.dx fcs_lib run data get entity @s Pos[0]
execute store result storage fimel_sklibs:runtime temp.postool.y2 int 1 store result score #postool.y2 fcs_lib store result score #postool.dy fcs_lib run data get entity @s Pos[1]
execute store result storage fimel_sklibs:runtime temp.postool.z2 int 1 store result score #postool.z2 fcs_lib store result score #postool.dz fcs_lib run data get entity @s Pos[2]

execute store result storage fimel_sklibs:runtime temp.postool.dx int 1 run scoreboard players operation #postool.dx fcs_lib -= #postool.x1 fcs_lib
execute store result storage fimel_sklibs:runtime temp.postool.dy int 1 run scoreboard players operation #postool.dy fcs_lib -= #postool.y1 fcs_lib
execute store result storage fimel_sklibs:runtime temp.postool.dz int 1 run scoreboard players operation #postool.dz fcs_lib -= #postool.z1 fcs_lib

function fimel_sklibs:skapi_tools/postools/_1 with storage fimel_sklibs:runtime temp.postool

kill @s
