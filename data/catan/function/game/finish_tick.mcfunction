scoreboard players remove @s ca_finish 1
execute if score @s ca_finish matches 0 run function catan:game/cleanup
