$execute store result score #item_count ac_ctx run clear @s *[minecraft:custom_data~{aeroplane_chess:{tool:1b,action:1,table:$(table)}}] 0
$execute if score #item_count ac_ctx matches 0 run function aeroplane_chess:input/place {table:$(table),slot:0,action:1,name:"飞行棋 · 投骰",model:"card:aeroplane_chess/dice"}
