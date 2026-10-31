scoreboard players operation #click_table ac_ctx = @s ct_id
tag @a[tag=ac.actor] remove ac.actor
execute on target if entity @s[type=minecraft:player] run function aeroplane_chess:input/dice_player
data remove entity @s interaction
tag @a[tag=ac.actor] remove ac.actor
