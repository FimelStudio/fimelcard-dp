scoreboard players operation #ui_click_table go_ctx = @s ct_id
tag @a[tag=go.actor] remove go.actor
execute on target if entity @s[type=minecraft:player] run function weiqi:input/cell_player
data remove entity @s interaction
tag @a[tag=go.actor] remove go.actor
