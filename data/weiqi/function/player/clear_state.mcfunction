function weiqi:input/clear
scoreboard players reset @s go_table
scoreboard players reset @s go_side
scoreboard players reset @s go_seat
scoreboard players reset @s go_weight
scoreboard players reset @s go_reviewtable
scoreboard players reset @s go_revelig
scoreboard players reset @s go_view
tag @s remove go.player
tag @s remove go.audience
