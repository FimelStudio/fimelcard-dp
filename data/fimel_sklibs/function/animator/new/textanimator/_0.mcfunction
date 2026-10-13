

# 默认数据
$data merge entity @s {alignment:left,background:0, billboard:center,Tags:$(tags),transformation:{right_rotation:[0f,0f,0f,1f],left_rotation:[0f,0f,0f,1f],translation:[0f,$(y)f,0f],scale:[$(scale)f,$(scale)f,$(scale)f]},brightness:{block:15,sky:15}}
tag @s add fimel.skanimator.text

# 存储帧时间数据
execute store result score @s fcs_an_frame run data get storage fimel_sklibs:animator temp.input.start 1
execute store result score @s fcs_an_target run data get storage fimel_sklibs:animator temp.input.time 1
scoreboard players operation @s fcs_an_target += @s fcs_an_frame
execute unless data storage fimel_sklibs:animator temp.input.color run data modify storage fimel_sklibs:animator temp.input.color set value 16777215
execute store result score @s fcs_an_color run data get storage fimel_sklibs:animator temp.input.color 1

