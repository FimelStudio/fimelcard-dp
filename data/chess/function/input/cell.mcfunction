scoreboard players operation #ui_click_table ch_ctx = @s ct_id
scoreboard players operation #target ch_ctx = @s ch_sq
tag @a[tag=ch.actor] remove ch.actor
execute on target if entity @s[type=minecraft:player] run function chess:input/cell_player
data remove entity @s interaction
tag @a[tag=ch.actor] remove ch.actor
