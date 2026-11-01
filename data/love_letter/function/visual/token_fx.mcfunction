function love_letter:visual/favor
tag @s remove ll.favor
tag @s add ll.fx
scoreboard players set @s ll_v_kind 2
data modify entity @s data.ll_frames set from storage love_letter:visual frames
data modify entity @s transformation.translation set from entity @s data.ll_frames[0]
data remove entity @s data.ll_frames[0]
