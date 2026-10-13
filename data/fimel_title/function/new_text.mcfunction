
# 新文本

function fimel_title:new_part

execute store result score x fbt_int run data get storage fimel_title:io x 2.0
execute store result score dx fbt_int run data get storage fimel_title:io dx 2.0
scoreboard players operation x fbt_int += dx fbt_int
execute store result storage fimel_title:io x double 0.5 run scoreboard players get x fbt_int
execute store result storage fimel_title:io tempx int 1.0 run scoreboard players add x fbt_int 4000
data modify storage fimel_title:io dx set value 0

execute store result score y fbt_int run data get storage fimel_title:io y 2.0
execute store result score dy fbt_int run data get storage fimel_title:io dy 2.0
scoreboard players operation y fbt_int += dy fbt_int
execute store result storage fimel_title:io y double 0.5 run scoreboard players get y fbt_int
execute store result storage fimel_title:io tempy int 1.0 run scoreboard players add y fbt_int 2500
data modify storage fimel_title:io dy set value 0

function fimel_title:code/new_text_macro with storage fimel_title:io

data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []

