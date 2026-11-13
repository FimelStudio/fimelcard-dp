scoreboard players set #pub_order gd_ctx 0
execute as @e[tag=gd.board] if score @s gd_seat = #hud_seat gd_ctx run scoreboard players operation #pub_order gd_ctx = @s gd_order
scoreboard players operation #pub_target gd_ctx = #pub_order gd_ctx
scoreboard players add #pub_target gd_ctx 1
scoreboard players operation #pub_target gd_ctx %= #four gd_ctx
data modify storage guandan:hud label set value "上家 "
data modify storage fimel_title:io y set value -48.0d
data modify storage fimel_title:io x set value 8.0d
data modify storage fimel_title:io align set value "left"
data modify storage fimel_title:io origin set value "up-left"
execute as @e[tag=gd.board] if score @s gd_order = #pub_target gd_ctx run function guandan:hud/public_row
scoreboard players operation #pub_target gd_ctx = #pub_order gd_ctx
scoreboard players add #pub_target gd_ctx 0
scoreboard players operation #pub_target gd_ctx %= #four gd_ctx
data modify storage guandan:hud label set value "自己 "
data modify storage fimel_title:io y set value -126.0d
data modify storage fimel_title:io x set value 8.0d
data modify storage fimel_title:io align set value "left"
data modify storage fimel_title:io origin set value "up-left"
execute as @e[tag=gd.board] if score @s gd_order = #pub_target gd_ctx run function guandan:hud/public_row
scoreboard players operation #pub_target gd_ctx = #pub_order gd_ctx
scoreboard players add #pub_target gd_ctx 2
scoreboard players operation #pub_target gd_ctx %= #four gd_ctx
data modify storage guandan:hud label set value "队友 "
data modify storage fimel_title:io y set value -48.0d
data modify storage fimel_title:io x set value -8.0d
data modify storage fimel_title:io align set value "right"
data modify storage fimel_title:io origin set value "up-right"
execute as @e[tag=gd.board] if score @s gd_order = #pub_target gd_ctx run function guandan:hud/public_row
scoreboard players operation #pub_target gd_ctx = #pub_order gd_ctx
scoreboard players add #pub_target gd_ctx 3
scoreboard players operation #pub_target gd_ctx %= #four gd_ctx
data modify storage guandan:hud label set value "下家 "
data modify storage fimel_title:io y set value -126.0d
data modify storage fimel_title:io x set value -8.0d
data modify storage fimel_title:io align set value "right"
data modify storage fimel_title:io origin set value "up-right"
execute as @e[tag=gd.board] if score @s gd_order = #pub_target gd_ctx run function guandan:hud/public_row
