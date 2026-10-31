scoreboard players operation #ui_click_table xq_ctx = @s ct_id
scoreboard players operation #target xq_ctx = @s xq_sq
tag @a[tag=xq.actor] remove xq.actor
execute on target if entity @s[type=minecraft:player] run function xiangqi:input/cell_player
data remove entity @s interaction
tag @a[tag=xq.actor] remove xq.actor
