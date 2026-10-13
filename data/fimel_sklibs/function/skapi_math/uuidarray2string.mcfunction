

# 原作者： ka__er



##UUID数组转化为带连字符的16进制
 

#输入：data modify storage fimel_sklibs:math uuid_list_for_hyphen.input set value [I;0,0,0,1]
# function fimel_sklibs:skapi_math/uuidarray2string
#输出：data get storage fimel_sklibs:math uuid_list_for_hyphen.output

execute store result score #temp2 fcs_math store result score #temp1 fcs_math run data get storage fimel_sklibs:math uuid_list_for_hyphen.input[0]
execute store result score #temp12 fcs_math store result score #temp11 fcs_math run data get storage fimel_sklibs:math uuid_list_for_hyphen.input[1]
execute store result score #temp22 fcs_math store result score #temp21 fcs_math run data get storage fimel_sklibs:math uuid_list_for_hyphen.input[2]
execute store result score #temp32 fcs_math store result score #temp31 fcs_math run data get storage fimel_sklibs:math uuid_list_for_hyphen.input[3]

#转16进制
execute store result score #temp3 fcs_math run scoreboard players operation #temp2 fcs_math /= 16 fcs_math
execute store result score #temp4 fcs_math run scoreboard players operation #temp3 fcs_math /= 16 fcs_math
execute store result score #temp5 fcs_math run scoreboard players operation #temp4 fcs_math /= 16 fcs_math
execute store result score #temp6 fcs_math run scoreboard players operation #temp5 fcs_math /= 16 fcs_math
execute store result score #temp7 fcs_math run scoreboard players operation #temp6 fcs_math /= 16 fcs_math
execute store result score #temp8 fcs_math run scoreboard players operation #temp7 fcs_math /= 16 fcs_math
scoreboard players operation #temp8 fcs_math /= 16 fcs_math

execute store result score #temp13 fcs_math run scoreboard players operation #temp12 fcs_math /= 16 fcs_math
execute store result score #temp14 fcs_math run scoreboard players operation #temp13 fcs_math /= 16 fcs_math
execute store result score #temp15 fcs_math run scoreboard players operation #temp14 fcs_math /= 16 fcs_math
execute store result score #temp16 fcs_math run scoreboard players operation #temp15 fcs_math /= 16 fcs_math
execute store result score #temp17 fcs_math run scoreboard players operation #temp16 fcs_math /= 16 fcs_math
execute store result score #temp18 fcs_math run scoreboard players operation #temp17 fcs_math /= 16 fcs_math
scoreboard players operation #temp18 fcs_math /= 16 fcs_math

execute store result score #temp23 fcs_math run scoreboard players operation #temp22 fcs_math /= 16 fcs_math
execute store result score #temp24 fcs_math run scoreboard players operation #temp23 fcs_math /= 16 fcs_math
execute store result score #temp25 fcs_math run scoreboard players operation #temp24 fcs_math /= 16 fcs_math
execute store result score #temp26 fcs_math run scoreboard players operation #temp25 fcs_math /= 16 fcs_math
execute store result score #temp27 fcs_math run scoreboard players operation #temp26 fcs_math /= 16 fcs_math
execute store result score #temp28 fcs_math run scoreboard players operation #temp27 fcs_math /= 16 fcs_math
scoreboard players operation #temp28 fcs_math /= 16 fcs_math

execute store result score #temp33 fcs_math run scoreboard players operation #temp32 fcs_math /= 16 fcs_math
execute store result score #temp34 fcs_math run scoreboard players operation #temp33 fcs_math /= 16 fcs_math
execute store result score #temp35 fcs_math run scoreboard players operation #temp34 fcs_math /= 16 fcs_math
execute store result score #temp36 fcs_math run scoreboard players operation #temp35 fcs_math /= 16 fcs_math
execute store result score #temp37 fcs_math run scoreboard players operation #temp36 fcs_math /= 16 fcs_math
execute store result score #temp38 fcs_math run scoreboard players operation #temp37 fcs_math /= 16 fcs_math
scoreboard players operation #temp38 fcs_math /= 16 fcs_math

data modify storage fimel_sklibs:math uuid.temp1 set value [{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0},{a:0}]
execute store result storage fimel_sklibs:math uuid.temp1[0].a int 1 run scoreboard players operation #temp8 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[1].a int 1 run scoreboard players operation #temp7 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[2].a int 1 run scoreboard players operation #temp6 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[3].a int 1 run scoreboard players operation #temp5 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[4].a int 1 run scoreboard players operation #temp4 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[5].a int 1 run scoreboard players operation #temp3 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[6].a int 1 run scoreboard players operation #temp2 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[7].a int 1 run scoreboard players operation #temp1 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[8].a int 1 run scoreboard players operation #temp18 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[9].a int 1 run scoreboard players operation #temp17 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[10].a int 1 run scoreboard players operation #temp16 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[11].a int 1 run scoreboard players operation #temp15 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[12].a int 1 run scoreboard players operation #temp14 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[13].a int 1 run scoreboard players operation #temp13 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[14].a int 1 run scoreboard players operation #temp12 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[15].a int 1 run scoreboard players operation #temp11 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[16].a int 1 run scoreboard players operation #temp28 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[17].a int 1 run scoreboard players operation #temp27 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[18].a int 1 run scoreboard players operation #temp26 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[19].a int 1 run scoreboard players operation #temp25 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[20].a int 1 run scoreboard players operation #temp24 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[21].a int 1 run scoreboard players operation #temp23 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[22].a int 1 run scoreboard players operation #temp22 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[23].a int 1 run scoreboard players operation #temp21 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[24].a int 1 run scoreboard players operation #temp38 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[25].a int 1 run scoreboard players operation #temp37 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[26].a int 1 run scoreboard players operation #temp36 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[27].a int 1 run scoreboard players operation #temp35 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[28].a int 1 run scoreboard players operation #temp34 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[29].a int 1 run scoreboard players operation #temp33 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[30].a int 1 run scoreboard players operation #temp32 fcs_math %= 16 fcs_math
execute store result storage fimel_sklibs:math uuid.temp1[31].a int 1 run scoreboard players operation #temp31 fcs_math %= 16 fcs_math

data modify storage fimel_sklibs:math uuid.temp1[{a:10}].a set value "a"
data modify storage fimel_sklibs:math uuid.temp1[{a:11}].a set value "b"
data modify storage fimel_sklibs:math uuid.temp1[{a:12}].a set value "c"
data modify storage fimel_sklibs:math uuid.temp1[{a:13}].a set value "d"
data modify storage fimel_sklibs:math uuid.temp1[{a:14}].a set value "e"
data modify storage fimel_sklibs:math uuid.temp1[{a:15}].a set value "f"

#转存，合并字符串
data modify storage fimel_sklibs:math uuid.stemp0 set from storage fimel_sklibs:math uuid.temp1[0].a
data modify storage fimel_sklibs:math uuid.stemp1 set from storage fimel_sklibs:math uuid.temp1[1].a
data modify storage fimel_sklibs:math uuid.stemp2 set from storage fimel_sklibs:math uuid.temp1[2].a
data modify storage fimel_sklibs:math uuid.stemp3 set from storage fimel_sklibs:math uuid.temp1[3].a
data modify storage fimel_sklibs:math uuid.stemp4 set from storage fimel_sklibs:math uuid.temp1[4].a
data modify storage fimel_sklibs:math uuid.stemp5 set from storage fimel_sklibs:math uuid.temp1[5].a
data modify storage fimel_sklibs:math uuid.stemp6 set from storage fimel_sklibs:math uuid.temp1[6].a
data modify storage fimel_sklibs:math uuid.stemp7 set from storage fimel_sklibs:math uuid.temp1[7].a
data modify storage fimel_sklibs:math uuid.stemp9 set from storage fimel_sklibs:math uuid.temp1[8].a
data modify storage fimel_sklibs:math uuid.stemp10 set from storage fimel_sklibs:math uuid.temp1[9].a
data modify storage fimel_sklibs:math uuid.stemp11 set from storage fimel_sklibs:math uuid.temp1[10].a
data modify storage fimel_sklibs:math uuid.stemp12 set from storage fimel_sklibs:math uuid.temp1[11].a
data modify storage fimel_sklibs:math uuid.stemp14 set from storage fimel_sklibs:math uuid.temp1[12].a
data modify storage fimel_sklibs:math uuid.stemp15 set from storage fimel_sklibs:math uuid.temp1[13].a
data modify storage fimel_sklibs:math uuid.stemp16 set from storage fimel_sklibs:math uuid.temp1[14].a
data modify storage fimel_sklibs:math uuid.stemp17 set from storage fimel_sklibs:math uuid.temp1[15].a
data modify storage fimel_sklibs:math uuid.stemp19 set from storage fimel_sklibs:math uuid.temp1[16].a
data modify storage fimel_sklibs:math uuid.stemp20 set from storage fimel_sklibs:math uuid.temp1[17].a
data modify storage fimel_sklibs:math uuid.stemp21 set from storage fimel_sklibs:math uuid.temp1[18].a
data modify storage fimel_sklibs:math uuid.stemp22 set from storage fimel_sklibs:math uuid.temp1[19].a
data modify storage fimel_sklibs:math uuid.stemp24 set from storage fimel_sklibs:math uuid.temp1[20].a
data modify storage fimel_sklibs:math uuid.stemp25 set from storage fimel_sklibs:math uuid.temp1[21].a
data modify storage fimel_sklibs:math uuid.stemp26 set from storage fimel_sklibs:math uuid.temp1[22].a
data modify storage fimel_sklibs:math uuid.stemp27 set from storage fimel_sklibs:math uuid.temp1[23].a
data modify storage fimel_sklibs:math uuid.stemp28 set from storage fimel_sklibs:math uuid.temp1[24].a
data modify storage fimel_sklibs:math uuid.stemp29 set from storage fimel_sklibs:math uuid.temp1[25].a
data modify storage fimel_sklibs:math uuid.stemp30 set from storage fimel_sklibs:math uuid.temp1[26].a
data modify storage fimel_sklibs:math uuid.stemp31 set from storage fimel_sklibs:math uuid.temp1[27].a
data modify storage fimel_sklibs:math uuid.stemp32 set from storage fimel_sklibs:math uuid.temp1[28].a
data modify storage fimel_sklibs:math uuid.stemp33 set from storage fimel_sklibs:math uuid.temp1[29].a
data modify storage fimel_sklibs:math uuid.stemp34 set from storage fimel_sklibs:math uuid.temp1[30].a
data modify storage fimel_sklibs:math uuid.stemp35 set from storage fimel_sklibs:math uuid.temp1[31].a

function fimel_sklibs:skapi_math/private/uuidarray2string/macro with storage fimel_sklibs:math uuid

