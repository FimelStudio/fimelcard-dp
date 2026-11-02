tag @s add ca.player
scoreboard players operation @s ca_table = @s ct_id
scoreboard players operation @s ca_seat = @s ct_seat
scoreboard players set @s ca_mode 0
scoreboard players set @s ca_pick -1
scoreboard players set @s ca_seen -1
function catan:ui/init
