function catan:sound/stop
execute if score @s ct_game matches 21 if score @s ct_state matches 1 if score @s ca_music matches 1 run function catan:sound/start
