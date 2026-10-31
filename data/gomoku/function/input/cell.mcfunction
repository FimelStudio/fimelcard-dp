scoreboard players operation #ui_click_table gm_ctx = @s ct_id
tag @a[tag=gm.actor] remove gm.actor
execute on target if entity @s[type=minecraft:player] run function gomoku:input/cell_player
data remove entity @s interaction
tag @a[tag=gm.actor] remove gm.actor
