scoreboard players operation #click_table ca_ctx = @s ct_id
execute on target if entity @s[type=minecraft:player] if score @s ca_table = #click_table ca_ctx run function catan:input/aim
data remove entity @s interaction
