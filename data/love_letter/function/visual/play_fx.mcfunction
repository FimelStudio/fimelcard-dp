function love_letter:visual/face with storage love_letter:visual seat_data
tag @s remove ll.face
tag @s add ll.fx
scoreboard players set @s ll_v_kind 1
data modify entity @s data.ll_frames set from storage love_letter:visual frames
data modify entity @s transformation.translation set from entity @s data.ll_frames[0]
data remove entity @s data.ll_frames[0]
