# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #click_table ac_ctx = @s ct_id
scoreboard players operation #click_plane ac_ctx = @s ac_plane
scoreboard players operation #click_color ac_ctx = @s ac_color
tag @a[tag=ac.actor] remove ac.actor
execute on target if entity @s[type=minecraft:player] run function aeroplane_chess:input/plane_player
data remove entity @s interaction
tag @a[tag=ac.actor] remove ac.actor
