function cardtable:seat/mount
scoreboard players operation #mount_seat go_ctx = @s go_seat
scoreboard players set #mounted go_ctx 0
execute on vehicle if entity @s[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #table go_ctx if score @s ct_seat = #mount_seat go_ctx run scoreboard players set #mounted go_ctx 1
execute unless score #mounted go_ctx matches 1 run scoreboard players set #seats_ok go_ctx 0
