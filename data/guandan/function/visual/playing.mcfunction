tag @s add gd.fx
tag @s add gd.playing
scoreboard players set @s gd_v_age 0
scoreboard players set @s gd_v_life 8
$data merge entity @s {data:{path:$(path)}}
# path 是位置列表，使用首项作为初始 translation。
data modify entity @s transformation.translation set from entity @s data.path[0]
data remove entity @s data.path[0]
