$execute store result score #tools_have ac_ctx run clear @s minecraft:paper[minecraft:custom_data~{aeroplane_chess:{tool:1b,action:0,table:$(table)}}] 0
$execute if score #tools_have ac_ctx matches 0 run function aeroplane_chess:input/place {table:$(table),slot:8,action:0,name:"飞行棋 · 对局菜单",model:"minecraft:book"}
