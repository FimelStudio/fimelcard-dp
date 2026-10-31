scoreboard players operation #click_table ac_ctx = @s ct_id
scoreboard players operation #click_plane ac_ctx = @s ac_plane
scoreboard players operation #click_color ac_ctx = @s ac_color
tag @a[tag=ac.actor] remove ac.actor
execute on target if entity @s[type=minecraft:player] run function aeroplane_chess:input/plane_player
data remove entity @s interaction
tag @a[tag=ac.actor] remove ac.actor
