$data merge entity @s {start_interpolation:0,interpolation_duration:1,transformation:{translation:[$(x)f,$(y)f,$(z)f],scale:[$(scale)f,$(scale)f,$(scale)f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,1f,0f,0f]}}
execute if score @s sp_vid matches 1 run function splendor:visual/noble_flight_offset
