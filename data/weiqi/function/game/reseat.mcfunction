function weiqi:system/context
function weiqi:system/side_seats
scoreboard players set #black_ready go_ctx 0
scoreboard players set #white_ready go_ctx 0
execute as @a[tag=go.audience,scores={go_side=1}] run scoreboard players add #black_ready go_ctx 1
execute as @a[tag=go.audience,scores={go_side=-1}] run scoreboard players add #white_ready go_ctx 1
execute if score @s go_bot matches 1 run scoreboard players add #black_ready go_ctx 1
execute if score @s go_bot matches -1 run scoreboard players add #white_ready go_ctx 1
scoreboard players set #seats_ok go_ctx 0
execute unless score #black_ready go_ctx matches 1 run return 0
execute unless score #white_ready go_ctx matches 1 run return 0
execute as @a[tag=go.audience] run function weiqi:player/place_side
execute as @a[tag=go.audience] run ride @s dismount
execute as @a[tag=go.audience] run scoreboard players operation @s ct_seat = @s go_seat
scoreboard players operation @s go_black = #black_seat go_ctx
scoreboard players operation @s go_white = #white_seat go_ctx
execute unless score @s go_bot matches 1 run scoreboard players operation @s go_black = @a[tag=go.audience,scores={go_side=1},limit=1] go_seat
execute unless score @s go_bot matches -1 run scoreboard players operation @s go_white = @a[tag=go.audience,scores={go_side=-1},limit=1] go_seat
function cardtable:table/ensure_seats
scoreboard players set #seats_ok go_ctx 1
execute as @a[tag=go.audience,scores={go_side=1},limit=1] at @s run function weiqi:player/mount_side
execute as @a[tag=go.audience,scores={go_side=-1},limit=1] at @s run function weiqi:player/mount_side
return run scoreboard players get #seats_ok go_ctx
